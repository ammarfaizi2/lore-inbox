Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311030AbSCHTpq>; Fri, 8 Mar 2002 14:45:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311067AbSCHTpg>; Fri, 8 Mar 2002 14:45:36 -0500
Received: from chaos.analogic.com ([204.178.40.224]:15488 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S311030AbSCHTp0>; Fri, 8 Mar 2002 14:45:26 -0500
Date: Fri, 8 Mar 2002 14:45:27 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: johan.adolfsson@axis.com
cc: Jamie Lokier <lk@tantalophile.demon.co.uk>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Terje Eggestad <terje.eggestad@scali.com>,
        Ben Greear <greearb@candelatech.com>,
        Davide Libenzi <davidel@xmailserver.org>,
        george anzinger <george@mvista.com>
Subject: Re: gettimeofday() system call timing curiosity
In-Reply-To: <025b01c1c6d4$63c05500$aab270d5@homeip.net>
Message-ID: <Pine.LNX.3.95.1020308143013.6910A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Mar 2002 johan.adolfsson@axis.com wrote:

> What happens if you remove the printf/puts and simply counts the number
> of times the different cases happen?
> 

Try it. It doesn't matter. Alan was correct, my computer sucks. However,
they won't give me a 10 GHz one (yet). Note that although gettimeofday()
has 1 microsecond resolution, not all the codes are exercised. We get
something with the granularity of 50 to 190 microseconds. This is
to be expected. You would need a timer that updates at least twice
the expected resolution to be able to exercise all the bits, i.e.,
something with a 2 MHz update-rate, that could be read before it
changed, or a real 'buzzer' of an ISR at 2 MHz. Before everybody
argues, a 1 MHz ISR would give you a value that is updated at
1 microsecond intervals, but now we have to read in asynchronously
and that's where Shannon (information theory) laws take effect.

> Another thought: Isn't it quite common that clock generators has a mode
> where the frequency differs around the desired frequency to spread the
> spectrum
> and easier pass EMC tests?

Actually, I think they just use a junk piezo-resonator instead of a
quartz crystal. If you try spread-spectrum with a bus-clock, you will
screw up all the timing so the bus won't work. Think PCI Bus with its
'reflected-wave' mechanism. If the clock timimg was to change during
PCI Bus activity, all bets are off.

> Could that be the case with the laptop?
> /Johan
> 
Don't think so.


Cheers,
Dick Johnson

Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).

	Bill Gates? Who?

