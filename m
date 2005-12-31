Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932292AbVLaRpZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932292AbVLaRpZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Dec 2005 12:45:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932305AbVLaRpZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Dec 2005 12:45:25 -0500
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:52419 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S932292AbVLaRpZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Dec 2005 12:45:25 -0500
Subject: Re: 2.6.15-rc7-rt1
From: Steven Rostedt <rostedt@goodmis.org>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Ingo Molnar <mingo@elte.hu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.61.0512311808070.7910@yvahk01.tjqt.qr>
References: <20051228172643.GA26741@elte.hu>
	 <Pine.LNX.4.61.0512311808070.7910@yvahk01.tjqt.qr>
Content-Type: text/plain
Date: Sat, 31 Dec 2005 12:45:13 -0500
Message-Id: <1136051113.6039.109.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-12-31 at 18:15 +0100, Jan Engelhardt wrote:
> Hi,
> 
> 
> >i have released the 2.6.15-rc7-rt1 tree, which can be downloaded from 
> >the usual place:
> >[...]
> >Please re-report any bugs that remain.
> >
> This happened upon starting mplayer for the first time:

> BUG at include/linux/timer.h:83!
> ------------[ cut here ]------------
> kernel BUG at include/linux/timer.h:83!
> invalid operand: 0000 [#1]
[...]
>  [<df111b4f>] rtc_ioctl+0xf/0x20 [rtc] (8)

Hmm, which rtc_ioctl?

>  [<c0170e68>] do_ioctl+0x78/0x90 (28)
>  [<c0171017>] vfs_ioctl+0x57/0x1f0 (32)
>  [<c01711e9>] sys_ioctl+0x39/0x60 (28)
>  [<c01031b5>] syscall_call+0x7/0xb (-8116)
> Code: 00 e9 30 ff ff ff e8 fe d7 19 e1 eb 8c be 53 00 00 00 bb f4 25 11 df 89
> 74 24 08 89 5c 24 04 c7 04 24 0a 26 11 df e8 de 9c 00 e1 <0f> 0b 53 00 f4 25 11
> df e9 73 ff ff ff e8 cc d7 19 e1 e9 63 f9
>  Segmentation fault
> 
> This looks like it's due to some timer - mplayer opens /dev/rtc if you want 
> to know. A second invocation of mplayer went fine, I guess due to 
> /dev/rtc still having a refcount of >0 and therefore not able to be opened 
> again.
> 
> AFA-IIRC this did not happen with (my own portage of) 2.6.15-rc5-rt4 into 
> 2.6.15-rc7 (on the very day that rc7 was released).
> If you need config.gz/.config or other info, please let me know.

Yeah, could you send it. If anything, just so I know which rtc_ioctl is
used.

> 
> 
> I also notice that mplayer uses approximately a lot more CPU, as shown in 
> top when CONFIG_HIGH_RES_TIMERS=y. That is, without highres timers, mplayer 
> uses less than 1%, with hrt it's somewhere between 10% and 18%.
> I practically just ran the decoding routine:
>   `mplayer -ao null sometrack.ogg`.

I'll give this a try too.  This isn't an x86_64 box is it?

Thanks,

-- Steve


