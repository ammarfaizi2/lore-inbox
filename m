Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130648AbQKPPIK>; Thu, 16 Nov 2000 10:08:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130646AbQKPPIA>; Thu, 16 Nov 2000 10:08:00 -0500
Received: from styx.suse.cz ([195.70.145.226]:62190 "EHLO kerberos.suse.cz")
	by vger.kernel.org with ESMTP id <S130645AbQKPPHw>;
	Thu, 16 Nov 2000 10:07:52 -0500
Date: Thu, 16 Nov 2000 11:57:30 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: "H. Peter Anvin" <hpa@transmeta.com>
Cc: Pavel Machek <pavel@suse.cz>, "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org
Subject: Re: rdtsc to mili secs?
Message-ID: <20001116115730.A665@suse.cz>
In-Reply-To: <3A078C65.B3C146EC@mira.net> <E13t7ht-0007Kv-00@the-village.bc.nu> <20001110154254.A33@bug.ucw.cz> <8uhps8$1tm$1@cesium.transmeta.com> <20001114222240.A1537@bug.ucw.cz> <3A12FA97.ACFF1577@transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A12FA97.ACFF1577@transmeta.com>; from hpa@transmeta.com on Wed, Nov 15, 2000 at 01:05:27PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 15, 2000 at 01:05:27PM -0800, H. Peter Anvin wrote:

> > > Intel PIIX-based systems will do duty-cycle throttling, for example.
> > 
> > Don't think so. My toshiba is PIIX-based, AFAIC:
> 
> Interesting.  Some will, definitely.  Didn't know that wasn't universal.
> 
> Clearly, on a machine like that, there is no hope for RDTSC, at least
> unless the CPU (and OS!) gets notification that the TSC needs to be
> recalibrated whenever it switches.
> 
> > Still, it is willing to run with RDTSC at 300MHz, 150MHz, and
> > 40MHz. (The last one in _extreme_ cases when CPU fan fails -- running
> > at 40MHz is better than cooking cpu).

I believe that pulsing the STPCLK pin of the processor by connecting it
to a say 32kHz signal and then changing the duty cycle of that signal
could have the effect of slowing down the processor to these speeds.

Somehow I can't believe a PMMX would be able to run at 40MHz. Which in
turn means that STPCLK also stops TSC, which is equally bad.

Anyway, this should be solvable by checking for clock change in the
timer interrupt. This way we should be able to detect when the clock
went weird with a 10 ms accuracy. And compensate for that. It should be
possible to keep a 'reasonable' clock running even through the clock
changes, where reasonable means constantly growing and as close to real
time as 10 ms difference max.

Yes, this is not perfect, but still keep every program quite happy and
running.

-- 
Vojtech Pavlik
SuSE Labs
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
