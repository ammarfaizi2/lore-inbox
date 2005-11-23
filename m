Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932157AbVKWScS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932157AbVKWScS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 13:32:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932159AbVKWScS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 13:32:18 -0500
Received: from vms040pub.verizon.net ([206.46.252.40]:19562 "EHLO
	vms040pub.verizon.net") by vger.kernel.org with ESMTP
	id S932157AbVKWScR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 13:32:17 -0500
Date: Wed, 23 Nov 2005 13:31:55 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: Linux 2.6.15-rc2
In-reply-to: <20051123174237.GO3963@stusta.de>
To: linux-kernel@vger.kernel.org
Cc: Adrian Bunk <bunk@stusta.de>, Michael Krufky <mkrufky@m1k.net>,
       Johannes Stezenbach <js@linuxtv.org>
Message-id: <200511231331.56087.gene.heskett@verizon.net>
Organization: None, usuallly detectable by casual observers
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
References: <Pine.LNX.4.64.0511191934210.8552@g5.osdl.org>
 <200511222336.48506.gene.heskett@verizon.net> <20051123174237.GO3963@stusta.de>
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 23 November 2005 12:42, Adrian Bunk wrote:
>On Tue, Nov 22, 2005 at 11:36:48PM -0500, Gene Heskett wrote:
>>...
>> Well, I just went thru it again, and turned off everything but the
>> cx8800 and ORv51132 stuffs, and now I get this at the and of the
>> 'makeit' script I use here:
>>
>> WARNING:
>> /lib/modules/2.6.15-rc2/kernel/drivers/media/video/cx88/cx88-dvb.ko
>> needs unknown symbol mt352_attach
>> WARNING:
>> /lib/modules/2.6.15-rc2/kernel/drivers/media/video/cx88/cx88-dvb.ko
>> needs unknown symbol nxt200x_attach
>> WARNING:
>> /lib/modules/2.6.15-rc2/kernel/drivers/media/video/cx88/cx88-dvb.ko
>> needs unknown symbol mt352_write
>> WARNING:
>> /lib/modules/2.6.15-rc2/kernel/drivers/media/video/cx88/cx88-dvb.ko
>> needs unknown symbol lgdt330x_attach
>> WARNING:
>> /lib/modules/2.6.15-rc2/kernel/drivers/media/video/cx88/cx88-dvb.ko
>> needs unknown symbol cx22702_attach
>>...
>
>Nice catch and thanks for your report.
>
>The bug is obvious. A possible patch is below (and at least
>drivers/media/video/saa7134/Makefile contains the same bug),
>but I'd really prfer getting rid of the -DHAVE_* stuff in the
>Makefiles and using Kconfig variables instead.

Damn, I sent the last message too quick. So this is a continuation of
that message.

Anyway, a hot reboot to 2.6.14.2 did not fix it fully although I
noticed that with signal detection turned off, I now had digital noise
bars instead of a blue screen.  Its now working normally again after a
full powerdown reboot to 2.6.14.2.  So while that patch would make it
build ok, it doesn't make it work...

>Would such a patch be accepted?
>
>> Cheers, Gene
>
>cu
>Adrian
>
>BTW: Please don't strip the Cc whenreplying to linux-kernel.

Oopps, sorry.  I guess I need to make a reply2all button for kmail...

>
>--- linux-2.6.15-rc2/drivers/media/video/cx88/Makefile.old	2005-11-23
> 18:34:07.000000000 +0100 +++
> linux-2.6.15-rc2/drivers/media/video/cx88/Makefile	2005-11-23
> 18:34:18.000000000 +0100 @@ -9,21 +9,21 @@
> EXTRA_CFLAGS += -I$(src)/..
> EXTRA_CFLAGS += -I$(srctree)/drivers/media/dvb/dvb-core
> EXTRA_CFLAGS += -I$(srctree)/drivers/media/dvb/frontends
>-ifneq ($(CONFIG_VIDEO_BUF_DVB),n)
>+ifneq ($(CONFIG_VIDEO_BUF_DVB),)
>  EXTRA_CFLAGS += -DHAVE_VIDEO_BUF_DVB=1
> endif
>-ifneq ($(CONFIG_DVB_CX22702),n)
>+ifneq ($(CONFIG_DVB_CX22702),)
>  EXTRA_CFLAGS += -DHAVE_CX22702=1
> endif
>-ifneq ($(CONFIG_DVB_OR51132),n)
>+ifneq ($(CONFIG_DVB_OR51132),)
>  EXTRA_CFLAGS += -DHAVE_OR51132=1
> endif
>-ifneq ($(CONFIG_DVB_LGDT330X),n)
>+ifneq ($(CONFIG_DVB_LGDT330X),)
>  EXTRA_CFLAGS += -DHAVE_LGDT330X=1
> endif
>-ifneq ($(CONFIG_DVB_MT352),n)
>+ifneq ($(CONFIG_DVB_MT352),)
>  EXTRA_CFLAGS += -DHAVE_MT352=1
> endif
>-ifneq ($(CONFIG_DVB_NXT200X),n)
>+ifneq ($(CONFIG_DVB_NXT200X),)
>  EXTRA_CFLAGS += -DHAVE_NXT200X=1
> endif

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.36% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2005 by Maurice Eugene Heskett, all rights reserved.

