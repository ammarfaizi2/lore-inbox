Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261982AbVASXw2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261982AbVASXw2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 18:52:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261988AbVASXu2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 18:50:28 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:43004 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S261982AbVASXpl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 18:45:41 -0500
Subject: Re: [PATCH] dynamic tick patch
From: john stultz <johnstul@us.ibm.com>
To: tglx@linutronix.de
Cc: George Anzinger <george@mvista.com>, Andrea Arcangeli <andrea@suse.de>,
       Tony Lindgren <tony@atomide.com>, Pavel Machek <pavel@suse.cz>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Con Kolivas <kernel@kolivas.org>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1106177171.16877.274.camel@tglx.tec.linutronix.de>
References: <20050119000556.GB14749@atomide.com>
	 <20050119094342.GB25623@elf.ucw.cz> <20050119171323.GB14545@atomide.com>
	 <20050119174858.GB12647@dualathlon.random>  <41EEE648.2010309@mvista.com>
	 <1106177171.16877.274.camel@tglx.tec.linutronix.de>
Content-Type: text/plain
Date: Wed, 19 Jan 2005 15:45:29 -0800
Message-Id: <1106178329.21490.19.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-01-20 at 00:26 +0100, Thomas Gleixner wrote:
> On Wed, 2005-01-19 at 14:59 -0800, George Anzinger wrote:
> > I don't think you will ever get good time if you EVER reprogramm the PIT.
> 
> Why not ? If you have a continous time source, which keeps track of
> "ticks" regardless the CPU state, why should PIT reprogramming be evil ?

That's a big if.  The problem is that while the PIT has its problems
(such as lost ticks), it runs at a known frequency and is reasonably
accurate. Time sources like the TSC have the problem that it doesn't run
at a known frequency, and thus we have to calibrate it (usually using
the PIT). Unfortunately this calibration is not extremely accurate
(George can go on to the reasons why), which causes the TSC to be a poor
stand alone time source.

That said, the PIT is a poor time source as well, as it does loose ticks
and is very slow to access. ACPI PM and HPET are better as they don't
have the lost tick problem, but they are still off chip and slower to
access then the TSC.

For an example of your ideal continuous timesource, check out the
timebase on PPC/PPC64. Other arches also have similar well behaved time
hardware. 

thanks
-john



