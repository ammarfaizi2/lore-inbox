Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131984AbRAWXTx>; Tue, 23 Jan 2001 18:19:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131614AbRAWXTj>; Tue, 23 Jan 2001 18:19:39 -0500
Received: from db0bm.automation.fh-aachen.de ([193.175.144.197]:41223 "EHLO
	db0bm.ampr.org") by vger.kernel.org with ESMTP id <S131952AbRAWXTT>;
	Tue, 23 Jan 2001 18:19:19 -0500
Date: Wed, 24 Jan 2001 00:19:14 +0100
From: f5ibh <f5ibh@db0bm.ampr.org>
Message-Id: <200101232319.AAA08536@db0bm.ampr.org>
To: vandrove@vc.cvut.cz
Subject: Re: display problem with matroxfb
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Petr,

> Stop. Do you see right portion of screen in left, left portion in right,
> with black column in between, or is picture only shifted, without
> wraparound? I thought that you see wrapped display...

The display is shifted, WITH wraparound : the end of the line is at the
beginning of the following one ...

> Are you sure that it is source of problem? Default matroxfb settings
> for 640x480 is 'timmings 39721 48 16 33 10 96 2' - As horizontal position

No, I'm not sure ... so I've tested the parameters you mention : 
timmings 39721 48 16 33 10 96 2

I copied the following block in /etc/fb.modes

mode "640x480-60"
    # D: 25.200 MHz, H: 31.500 kHz, V: 59.999 Hz
    geometry 640 480 640 480 8
    timings 39683 48 16 33 10 96 2
    accel true
    rgba 8/0,8/0,8/0,0/0
endmode

With these parameters, the command 'fbset -match -a' is enough to reset the
display to normal operation. So, you was right.

> After boot look at /proc/cmdline. If it is cutted at column 64 (or 79),
> you have to upgrade your LILO. RedHat6.2 uses LILO with this dumb limitation.

I use Debian 2.2 and ... grub. But I've tested with lilo too. With the sae
results. The cmdline is not truncated.

> Also, you do not have to specify vesa,pixclock,hslen and vslen, as you leave
> them on defaults. So 'video=matrox:left:50,right:10,upper:32,lower:11'
> should work... But I think that only 'right:' really matters.

This does not work ... I've to use the fbset command to reset the display to
normal operation after login in (or in an automatic command at boot time in
/et/init.d). This works, but I've lost the logo  ;-)

--
Regards
		Jean-Luc
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
