Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266731AbSKHCeZ>; Thu, 7 Nov 2002 21:34:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266732AbSKHCeZ>; Thu, 7 Nov 2002 21:34:25 -0500
Received: from deimos.hpl.hp.com ([192.6.19.190]:26867 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S266731AbSKHCeY>;
	Thu, 7 Nov 2002 21:34:24 -0500
Date: Thu, 7 Nov 2002 18:40:58 -0800
To: rmk@arm.linux.org.uk,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Martin Diehl <lists@mdiehl.de>
Subject: Re: [Serial 2.5]: packet drop problem (FE ?)
Message-ID: <20021108024058.GA1266@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
References: <20021107224750.GA699@bougret.hpl.hp.com> <20021108001822.E11437@flint.arm.linux.org.uk> <20021108004155.GA837@bougret.hpl.hp.com> <20021108004924.H11437@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021108004924.H11437@flint.arm.linux.org.uk>
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 08, 2002 at 12:49:24AM +0000, Russell King wrote:
> On Thu, Nov 07, 2002 at 04:41:55PM -0800, Jean Tourrilhes wrote:
> > 	Is there a way to see the current flag configuration of the
> > port with setserial or /proc ?
> 
> stty -a -F /dev/ttySx
> 
> should do the trick.
> 
> -- 
> Russell King

	More data...
	I rebooted my 2.5.X box with 2.4.X (still SMP).

	If I use the same traffic as before (unidirectional), I don't
see any FE (none).

	On the other hand, if I use bidirectional traffic of large
packets I see the FE and packet drops (actually, I start seeing them
on both side) :
--------------------------------
2.4.20-rc1 (was 2.4.46) :
0: uart:16550A port:3F8 irq:4 baud:9600 tx:1440518 rx:7466705 fe:303 RTS|DTR
2.4.20-pre8 :
0: uart:16550A port:3F8 irq:4 baud:9600 tx:16502356 rx:2486282 fe:8 RTS|DTR
--------------------------------
	(all the 303 of them appeared during the few bidirectional tests)
	(as my perf numbers for directional traffic are up from 2.5.X,
I guess there is less spacket drop than with 2.5.X).

	Lastly, directional traffic of small packet doesn't produce any FE.

	So, clearly it depend on the traffic pattern. And the move
from 2.4.X to 2.5.X bring FE/drop in case where there was none,
i.e. 2.5.X make it worse.
	And I'm wondering if it's just a case a crappy hardware, but
there seems to be more.

	From your description of what FE is, I don't understand how
changing the kernel/driver/traffic pattern would make this number
change. Puzzling...

	Good luck...

	Jean
