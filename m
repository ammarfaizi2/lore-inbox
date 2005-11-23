Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751267AbVKWRfJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751267AbVKWRfJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 12:35:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751277AbVKWRfJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 12:35:09 -0500
Received: from mx1.suse.de ([195.135.220.2]:4069 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751267AbVKWRfH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 12:35:07 -0500
Date: Wed, 23 Nov 2005 18:35:05 +0100
From: Andi Kleen <ak@suse.de>
To: Ronald G Minnich <rminnich@lanl.gov>
Cc: Andi Kleen <ak@suse.de>, yhlu <yhlu.kernel@gmail.com>, discuss@x86-64.org,
       linuxbios@openbios.org, linux-kernel@vger.kernel.org
Subject: Re: [LinuxBIOS] x86_64: apic id lift patch
Message-ID: <20051123173504.GK20775@brahms.suse.de>
References: <86802c440511211349t6a0a9d30i60e15fa23b86c49d@mail.gmail.com> <20051121220605.GD20775@brahms.suse.de> <43849FA5.4020201@lanl.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43849FA5.4020201@lanl.gov>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> At the same time, we seem to be treading in territory where the fuctory 
> BIOSes have not yet been. We're in the weird position, at times, of 
> finding things out before the proprietary BIOSes get there.

You're saying that Arima machine only runs with LinuxBIOS so far?

> 
> Sometimes the ease of updating the BIOS can cause troubles you don't 
> expect. Fuctory BIOSes seem to count on infrequent updates, forked code 
> bases, and so on, so that you have to update each mainboard source base 
> individually -- they have the disadvantage of a forked code base, but 
> the one advantage is that a mod to fix one platform won't ever break 
> another.
> 
> At some point I had understood that linux was going to be able to 
> function without resorting to SRAT tables -- has that changed? Is this 

SRAT is definitely the wave of the future.  I'm going to keep
the old code working as long as it's relatively cleanly possible.
But this needs to make some assumptions, and in particular your
discontiguous APIC IDs broke that. I don't plan to try to handle
every weird case in this case - if your setup is really
weird use SRAT.

Regarding the BSP 0 - you probably just have a stupid bug
somewhere that breaks the timer interrupt. I don't know
of any hardware issue that would prevent the timer interrupt
going to a APIC ID != 0. There are some troubles with timer
interrupts, but they are different issues. IMHO the discontig
APIC IDs was just a workaround because you didn't want to fix
the interrupt routing properly, with the burden on the kernel.

You have two options now:

- Trace down why interrupt 0 doesn't work with BSP LAPIC != 0
and fix that. 
- Provide SRAT.

First is probably better, although the second also wouldn't hurt.


> patch really intrusive enough that it is not acceptable? The issue is 

Yes it complicates the logic enough and makes it more fragile,
which would be a long term maintenance issue. The only way 
to keep the fallback code alive at all is to keep it simple
and clean.


-Andi
