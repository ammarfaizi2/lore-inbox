Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263333AbSLUTRf>; Sat, 21 Dec 2002 14:17:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263794AbSLUTRf>; Sat, 21 Dec 2002 14:17:35 -0500
Received: from twilight.ucw.cz ([195.39.74.230]:60392 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S263333AbSLUTRe>;
	Sat, 21 Dec 2002 14:17:34 -0500
Date: Sat, 21 Dec 2002 20:19:18 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: "Preston A. Elder" <prez@goth.net>
Cc: James Simmons <jsimmons@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: Fw: PROBLEM: Keyboard not found, but it exists!
Message-ID: <20021221201918.A31050@ucw.cz>
References: <200212180805.08049.prez@goth.net> <200212211408.04350.prez@goth.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200212211408.04350.prez@goth.net>; from prez@goth.net on Sat, Dec 21, 2002 at 02:08:02PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 21, 2002 at 02:08:02PM -0500, Preston A. Elder wrote:

> Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua> said I should forward this 
> to you, as I got no response from the LKML.

Well, I'm doing keyboards in 2.5 only, that's why I didn't comment on
the LKML posting.

> So, if you have any ideas, please, let me know.  I suppose the more important 
> issue is the 'time warp' issue (with the hwclock command failing, and 
> concequently the time jumping forward and back again).  But the keyboard 
> timeout is also important, and it is symtomatic of the other problem.  If the 
> keyboard works, the clock is fine.
> 
> Original message Wednesday 18 December 2002 08:05 am:
> > [1.] One line summary of the problem:
> > Keyboard not found, but it exists!
> >
> > [2.] Full description of the problem/report:
> > The PS/2 keyboard fails during the kernel boot (before init), saying:
> > keyboard: Timeout - AT keyboard not present?(ed)
> > keyboard: Timeout - AT keyboard not present?(f4)
> >
> > The keyboard does indeed exist, and I am able to use it in BIOS, in the
> > boot manager, and booting to DOS.  The above errors, however disable the
> > keyboard after the kenel boot, and so I am unable to use it in the running
> > system.

That's not correct. The above messages don't disable the keyboard - even
when they appear the kernel still listens to keypresses from the
keyboard - it only doesn't send LED commands to the keyboard anymore
(because it'd have to timeout on each LED command). It'll start sending
LED commands as soon as a keypress from the keyboard arrives.

Which means: The messages are just saying that the keyboard doesn't
work. And it doesn't for some reason. But the reason is not the
messages.

> > Thats not the full extent of the problem though. I also have problems
> > running "hwclock" without the --directisa option, it will just block (and I
> > can't abort it with no keyboard).  I've added the --directisa option to
> > startup/shutdown for now.

This may be caused by the same problem.

What BIOS timing setup are you using? Have you by any chance 'tuned' the
board for better performance?

> > I've also experienced some problems with the system time just jumping ahead
> > by 35 minutes, and then back again.  The back again part could be because
> > I'm running NTP to keep the system in sync, but I'm getting weird behavior
> > with time on this system, which is causing havoc on applications.

This is a known vt82c686a bug. Workarounds exist in various kernels.
2.4.18 has an incomplete workaround which isn't used if the CPU supports
TSC.

> > [3.] Keywords (i.e., modules, networking, kernel):
> > 2.4.19 keyboard ps2

I hate bugreports done by exactly following the bugreport cookbook. ;)

> > [6.] A small shell script or example program which triggers the
> >      problem (if possible)
> > N/A

... because I don't need to know a small shell script isn't applicable,
for example ...

> > 00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev 22)
> >         Subsystem: VIA Technologies, Inc. VT82C686/A PCI to ISA Bridge

Yes, a vt82c686a buggy chip ...

-- 
Vojtech Pavlik
SuSE Labs
