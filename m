Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932146AbVKWSV0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932146AbVKWSV0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 13:21:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932147AbVKWSV0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 13:21:26 -0500
Received: from vms042pub.verizon.net ([206.46.252.42]:2028 "EHLO
	vms042pub.verizon.net") by vger.kernel.org with ESMTP
	id S932146AbVKWSVZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 13:21:25 -0500
Date: Wed, 23 Nov 2005 13:19:39 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: Linux 2.6.15-rc2
In-reply-to: <20051123174237.GO3963@stusta.de>
To: linux-kernel@vger.kernel.org
Cc: Adrian Bunk <bunk@stusta.de>, Michael Krufky <mkrufky@m1k.net>,
       Johannes Stezenbach <js@linuxtv.org>
Message-id: <200511231319.39802.gene.heskett@verizon.net>
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

You're welcome.

>The bug is obvious. A possible patch is below (and at least
>drivers/media/video/saa7134/Makefile contains the same bug),
>but I'd really prfer getting rid of the -DHAVE_* stuff in the
>Makefiles and using Kconfig variables instead.
>
>Would such a patch be accepted?

I'm trying this to build with this patch right now.  No errors,
although I did see it building a cx88-blackbird.o, which I've ndi what
that is.  Now the acid test, does tvtime work again, or do I have to do
a powerdown reset and reboot to 2.6.14.2 to restore it.  Reboot to
2.6.15-rc2-patched comeing up.

Rebooted to this patch.  Tvtime now has very faint sound, like the
station is 200 miles away, and no video.  Blue screen even if signal
detection is turned off.  Its like the antenna input has been
disconnected.  The dish receiver in use here is banging it with nearly
65,000 u-volts of signal, so some is leaking thru. 
 
Now, to see if a simple reboot to 2.6.14.2 fixes it, or if I have to do
the full powerdown again. brb.

>> Cheers, Gene
>
>cu
>Adrian
>
>BTW: Please don't strip the Cc whenreplying to linux-kernel.
>
>
>
>--- linux-2.6.15-rc2/drivers/media/video/cx88/Makefile.old 2005-11-23
> 18:34:07.000000000 +0100 +++
> linux-2.6.15-rc2/drivers/media/video/cx88/Makefile 2005-11-23
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


