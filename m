Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964815AbWDCWgj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964815AbWDCWgj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Apr 2006 18:36:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964848AbWDCWgj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Apr 2006 18:36:39 -0400
Received: from mail.gmx.net ([213.165.64.20]:28600 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S964815AbWDCWgi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Apr 2006 18:36:38 -0400
X-Authenticated: #31060655
Message-ID: <4431A338.3000709@gmx.net>
Date: Tue, 04 Apr 2006 00:35:36 +0200
From: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2006@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.7.12) Gecko/20050921
X-Accept-Language: de, en
MIME-Version: 1.0
To: Sam Ravnborg <sam@ravnborg.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] Fix unneeded rebuilds in drivers/media/video after moving
 source tree
References: <442BC74B.7060305@gmx.net> <20060330202208.GA14016@mars.ravnborg.org> <442C4469.1040408@gmx.net> <20060331152226.GB8992@mars.ravnborg.org>
In-Reply-To: <20060331152226.GB8992@mars.ravnborg.org>
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sam Ravnborg schrieb:

>On Thu, Mar 30, 2006 at 10:49:45PM +0200, Carl-Daniel Hailfinger wrote:
> 
>  
>
>>Well, it would cause less confusion. It seems that ~90% of rebuilt files
>>are due to the following makefiles where full paths to includes are
>>specified:
>>./drivers/media/video/cx88/Makefile
>>./drivers/media/video/Makefile
>>./drivers/media/video/cx25840/Makefile
>>./drivers/media/video/saa7134/Makefile
>>./drivers/media/video/em28xx/Makefile
>>
>>Any objections to fix these?
>>    
>>
>
>Care to send a path - then I will include it with next kbuild update.
>  
>
This fixes some uneeded rebuilds under drivers/media/video after moving
the source tree. The makefiles used $(src) and $(srctree) for include
paths, which is unnecessary. Changed to use relative paths.

Compile tested, produces byte-identical code to the previous makefiles.

Signed-off-by: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2006@gmx.net>

-- 
http://www.hailfinger.org/

--- linux-2.6.16/drivers/media/video/cx25840/Makefile	2006-03-20 06:53:29.000000000 +0100
+++ linux-2.6.16-fixed/drivers/media/video/cx25840/Makefile	2006-04-04 00:07:01.000000000 +0200
@@ -3,4 +3,4 @@
 
 obj-$(CONFIG_VIDEO_DECODER) += cx25840.o
 
-EXTRA_CFLAGS += -I$(src)/..
+EXTRA_CFLAGS += -Idrivers/media/video
--- linux-2.6.16/drivers/media/video/cx88/Makefile	2006-03-20 06:53:29.000000000 +0100
+++ linux-2.6.16-fixed/drivers/media/video/cx88/Makefile	2006-04-04 00:05:04.000000000 +0200
@@ -8,9 +8,9 @@
 obj-$(CONFIG_VIDEO_CX88_ALSA) += cx88-alsa.o
 obj-$(CONFIG_VIDEO_CX88_VP3054) += cx88-vp3054-i2c.o
 
-EXTRA_CFLAGS += -I$(src)/..
-EXTRA_CFLAGS += -I$(srctree)/drivers/media/dvb/dvb-core
-EXTRA_CFLAGS += -I$(srctree)/drivers/media/dvb/frontends
+EXTRA_CFLAGS += -Idrivers/media/video
+EXTRA_CFLAGS += -Idrivers/media/dvb/dvb-core
+EXTRA_CFLAGS += -Idrivers/media/dvb/frontends
 
 extra-cflags-$(CONFIG_VIDEO_BUF_DVB) += -DHAVE_VIDEO_BUF_DVB=1
 extra-cflags-$(CONFIG_DVB_CX22702)   += -DHAVE_CX22702=1
--- linux-2.6.16/drivers/media/video/em28xx/Makefile	2006-03-20 06:53:29.000000000 +0100
+++ linux-2.6.16-fixed/drivers/media/video/em28xx/Makefile	2006-04-04 00:07:40.000000000 +0200
@@ -3,4 +3,4 @@
 
 obj-$(CONFIG_VIDEO_EM28XX) += em28xx.o
 
-EXTRA_CFLAGS += -I$(src)/..
+EXTRA_CFLAGS += -Idrivers/media/video
--- linux-2.6.16/drivers/media/video/Makefile	2006-03-20 06:53:29.000000000 +0100
+++ linux-2.6.16-fixed/drivers/media/video/Makefile	2006-04-04 00:00:19.000000000 +0200
@@ -63,4 +63,4 @@
 
 obj-$(CONFIG_VIDEO_DECODER)     += saa7115.o cx25840/ saa7127.o
 
-EXTRA_CFLAGS += -I$(srctree)/drivers/media/dvb/dvb-core
+EXTRA_CFLAGS += -Idrivers/media/dvb/dvb-core
--- linux-2.6.16/drivers/media/video/saa7134/Makefile	2006-03-20 06:53:29.000000000 +0100
+++ linux-2.6.16-fixed/drivers/media/video/saa7134/Makefile	2006-04-04 00:07:20.000000000 +0200
@@ -11,9 +11,9 @@
 
 obj-$(CONFIG_VIDEO_SAA7134_DVB) += saa7134-dvb.o
 
-EXTRA_CFLAGS += -I$(src)/..
-EXTRA_CFLAGS += -I$(srctree)/drivers/media/dvb/dvb-core
-EXTRA_CFLAGS += -I$(srctree)/drivers/media/dvb/frontends
+EXTRA_CFLAGS += -Idrivers/media/video
+EXTRA_CFLAGS += -Idrivers/media/dvb/dvb-core
+EXTRA_CFLAGS += -Idrivers/media/dvb/frontends
 
 extra-cflags-$(CONFIG_VIDEO_BUF_DVB) += -DHAVE_VIDEO_BUF_DVB=1
 extra-cflags-$(CONFIG_DVB_MT352)     += -DHAVE_MT352=1





