Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932067AbVKWRmk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932067AbVKWRmk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 12:42:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751292AbVKWRmk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 12:42:40 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:63758 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751289AbVKWRmj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 12:42:39 -0500
Date: Wed, 23 Nov 2005 18:42:37 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Gene Heskett <gene.heskett@verizon.net>
Cc: linux-kernel@vger.kernel.org, Michael Krufky <mkrufky@m1k.net>,
       Johannes Stezenbach <js@linuxtv.org>
Subject: Re: Linux 2.6.15-rc2
Message-ID: <20051123174237.GO3963@stusta.de>
References: <Pine.LNX.4.64.0511191934210.8552@g5.osdl.org> <200511202049.30952.gene.heskett@verizon.net> <4383CC4E.40206@m1k.net> <200511222336.48506.gene.heskett@verizon.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200511222336.48506.gene.heskett@verizon.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 22, 2005 at 11:36:48PM -0500, Gene Heskett wrote:
>...
> Well, I just went thru it again, and turned off everything but the
> cx8800 and ORv51132 stuffs, and now I get this at the and of the
> 'makeit' script I use here:
> 
> WARNING:
> /lib/modules/2.6.15-rc2/kernel/drivers/media/video/cx88/cx88-dvb.ko
> needs unknown symbol mt352_attach
> WARNING:
> /lib/modules/2.6.15-rc2/kernel/drivers/media/video/cx88/cx88-dvb.ko
> needs unknown symbol nxt200x_attach
> WARNING:
> /lib/modules/2.6.15-rc2/kernel/drivers/media/video/cx88/cx88-dvb.ko
> needs unknown symbol mt352_write
> WARNING:
> /lib/modules/2.6.15-rc2/kernel/drivers/media/video/cx88/cx88-dvb.ko
> needs unknown symbol lgdt330x_attach
> WARNING:
> /lib/modules/2.6.15-rc2/kernel/drivers/media/video/cx88/cx88-dvb.ko
> needs unknown symbol cx22702_attach
>...

Nice catch and thanks for your report.

The bug is obvious. A possible patch is below (and at least 
drivers/media/video/saa7134/Makefile contains the same bug),
but I'd really prfer getting rid of the -DHAVE_* stuff in the
Makefiles and using Kconfig variables instead.

Would such a patch be accepted?

> Cheers, Gene

cu
Adrian

BTW: Please don't strip the Cc whenreplying to linux-kernel.



--- linux-2.6.15-rc2/drivers/media/video/cx88/Makefile.old	2005-11-23 18:34:07.000000000 +0100
+++ linux-2.6.15-rc2/drivers/media/video/cx88/Makefile	2005-11-23 18:34:18.000000000 +0100
@@ -9,21 +9,21 @@
 EXTRA_CFLAGS += -I$(src)/..
 EXTRA_CFLAGS += -I$(srctree)/drivers/media/dvb/dvb-core
 EXTRA_CFLAGS += -I$(srctree)/drivers/media/dvb/frontends
-ifneq ($(CONFIG_VIDEO_BUF_DVB),n)
+ifneq ($(CONFIG_VIDEO_BUF_DVB),)
  EXTRA_CFLAGS += -DHAVE_VIDEO_BUF_DVB=1
 endif
-ifneq ($(CONFIG_DVB_CX22702),n)
+ifneq ($(CONFIG_DVB_CX22702),)
  EXTRA_CFLAGS += -DHAVE_CX22702=1
 endif
-ifneq ($(CONFIG_DVB_OR51132),n)
+ifneq ($(CONFIG_DVB_OR51132),)
  EXTRA_CFLAGS += -DHAVE_OR51132=1
 endif
-ifneq ($(CONFIG_DVB_LGDT330X),n)
+ifneq ($(CONFIG_DVB_LGDT330X),)
  EXTRA_CFLAGS += -DHAVE_LGDT330X=1
 endif
-ifneq ($(CONFIG_DVB_MT352),n)
+ifneq ($(CONFIG_DVB_MT352),)
  EXTRA_CFLAGS += -DHAVE_MT352=1
 endif
-ifneq ($(CONFIG_DVB_NXT200X),n)
+ifneq ($(CONFIG_DVB_NXT200X),)
  EXTRA_CFLAGS += -DHAVE_NXT200X=1
 endif
