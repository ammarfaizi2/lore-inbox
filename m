Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262058AbVATF5S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262058AbVATF5S (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 00:57:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262060AbVATF5S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 00:57:18 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:14488
	"EHLO debian.tglx.de") by vger.kernel.org with ESMTP
	id S262058AbVATF5C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 00:57:02 -0500
Subject: Re: [PATCH] dynamic tick patch
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: john stultz <johnstul@us.ibm.com>
Cc: George Anzinger <george@mvista.com>, Andrea Arcangeli <andrea@suse.de>,
       Tony Lindgren <tony@atomide.com>, Pavel Machek <pavel@suse.cz>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Con Kolivas <kernel@kolivas.org>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1106178329.21490.19.camel@cog.beaverton.ibm.com>
References: <20050119000556.GB14749@atomide.com>
	 <20050119094342.GB25623@elf.ucw.cz> <20050119171323.GB14545@atomide.com>
	 <20050119174858.GB12647@dualathlon.random>  <41EEE648.2010309@mvista.com>
	 <1106177171.16877.274.camel@tglx.tec.linutronix.de>
	 <1106178329.21490.19.camel@cog.beaverton.ibm.com>
Content-Type: text/plain
Date: Thu, 20 Jan 2005 06:56:59 +0100
Message-Id: <1106200619.16877.285.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 (2.0.3-2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-01-19 at 15:45 -0800, john stultz wrote:
> On Thu, 2005-01-20 at 00:26 +0100, Thomas Gleixner wrote:
> > On Wed, 2005-01-19 at 14:59 -0800, George Anzinger wrote:
> > > I don't think you will ever get good time if you EVER reprogramm the PIT.
> > 
> > Why not ? If you have a continous time source, which keeps track of
> > "ticks" regardless the CPU state, why should PIT reprogramming be evil ?
> 
> That's a big if.  The problem is that while the PIT has its problems
> (such as lost ticks), it runs at a known frequency and is reasonably
> accurate. Time sources like the TSC have the problem that it doesn't run
> at a known frequency, and thus we have to calibrate it (usually using
> the PIT). Unfortunately this calibration is not extremely accurate
> (George can go on to the reasons why), which causes the TSC to be a poor
> stand alone time source.
>
> That said, the PIT is a poor time source as well, as it does loose ticks
> and is very slow to access. ACPI PM and HPET are better as they don't
> have the lost tick problem, but they are still off chip and slower to
> access then the TSC.

And they aren't available on every board - especially not on embedded
ones. 

> For an example of your ideal continuous timesource, check out the
> timebase on PPC/PPC64. Other arches also have similar well behaved time
> hardware. 

Yes, I'm aware of that. Unfortunately we live in the x86 universe. 

tglx


