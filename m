Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131773AbQKRWbr>; Sat, 18 Nov 2000 17:31:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131519AbQKRWbi>; Sat, 18 Nov 2000 17:31:38 -0500
Received: from [194.213.32.137] ([194.213.32.137]:8452 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S131495AbQKRWb2>;
	Sat, 18 Nov 2000 17:31:28 -0500
Message-ID: <20001118211231.A382@bug.ucw.cz>
Date: Sat, 18 Nov 2000 21:12:31 +0100
From: Pavel Machek <pavel@suse.cz>
To: Vojtech Pavlik <vojtech@suse.cz>, "H. Peter Anvin" <hpa@transmeta.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: rdtsc to mili secs?
In-Reply-To: <3A078C65.B3C146EC@mira.net> <E13t7ht-0007Kv-00@the-village.bc.nu> <20001110154254.A33@bug.ucw.cz> <8uhps8$1tm$1@cesium.transmeta.com> <20001114222240.A1537@bug.ucw.cz> <3A12FA97.ACFF1577@transmeta.com> <20001116115730.A665@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <20001116115730.A665@suse.cz>; from Vojtech Pavlik on Thu, Nov 16, 2000 at 11:57:30AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > Intel PIIX-based systems will do duty-cycle throttling, for example.
> > > 
> > > Don't think so. My toshiba is PIIX-based, AFAIC:
> > 
> > Interesting.  Some will, definitely.  Didn't know that wasn't universal.
> > 
> > Clearly, on a machine like that, there is no hope for RDTSC, at least
> > unless the CPU (and OS!) gets notification that the TSC needs to be
> > recalibrated whenever it switches.
> > 
> > > Still, it is willing to run with RDTSC at 300MHz, 150MHz, and
> > > 40MHz. (The last one in _extreme_ cases when CPU fan fails -- running
> > > at 40MHz is better than cooking cpu).
> 
> I believe that pulsing the STPCLK pin of the processor by connecting it
> to a say 32kHz signal and then changing the duty cycle of that signal
> could have the effect of slowing down the processor to these speeds.
> 
> Somehow I can't believe a PMMX would be able to run at 40MHz. Which in
> turn means that STPCLK also stops TSC, which is equally bad.

Why not? From 300MHz to 40MHz... 10 times, that is not that big
difference. (I've ran k6/400 at 66MHz, IIRC, while debugging -- I'm
not really sure, and don't want to open machine, but it should work).

> Anyway, this should be solvable by checking for clock change in the
> timer interrupt. This way we should be able to detect when the clock
> went weird with a 10 ms accuracy. And compensate for that. It should be
> possible to keep a 'reasonable' clock running even through the clock
> changes, where reasonable means constantly growing and as close to real
> time as 10 ms difference max.
> 
> Yes, this is not perfect, but still keep every program quite happy and
> running.

No. Udelay has just gone wrong and your old ISA xxx card just crashed
whole system. Oops.

BTW I mailed patch to do exactly that kind of autodetection to the
list some time ago. (I just can't find it now :-( -- search archives
for 'TSC is slower than it should be'.
								Pavel

-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
