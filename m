Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262078AbVEEMc4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262078AbVEEMc4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 May 2005 08:32:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262080AbVEEMc4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 May 2005 08:32:56 -0400
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:48649 "EHLO
	pollux.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S262078AbVEEMcy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 May 2005 08:32:54 -0400
Date: Thu, 5 May 2005 13:32:49 +0100 (BST)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: Len Brown <len.brown@intel.com>
Cc: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>, mingo@elte.hu,
       linux-kernel <linux-kernel@vger.kernel.org>,
       "Shah, Rajesh" <rajesh.shah@intel.com>,
       John Stultz <johnstul@us.ibm.com>, Andi Kleen <ak@suse.de>,
       Asit K Mallick <asit.k.mallick@intel.com>
Subject: RE: [RFC][PATCH] i386 x86-64 Eliminate Local APIC timer interrupt
In-Reply-To: <1115266581.7644.52.camel@d845pe>
Message-ID: <Pine.LNX.4.61L.0505051325230.21387@blysk.ds.pg.gda.pl>
References: <88056F38E9E48644A0F562A38C64FB60049EE972@scsmsx403.amr.corp.intel.com>
 <1115266581.7644.52.camel@d845pe>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 May 2005, Len Brown wrote:

> Re: SMP using i8259
> While Linux in ACPI mode allows "noapic" on SMP, it isn't recommended.
> It is there for comparisons, debugging, and to work-around the odd
> broken system.  It is an exception configuration, and supporting it
> should in no way impact the design for other 99.99% normal systems.
> 
> Indeed, note that SMP systems using i8259 instead of IOAPIC
> is explicity forbidden by MPS, and thus would probably fail
> the compatibility test for your favorite high volume binary OS.

 I'm not quite sure if that's forbidden by MPS -- the mixed mode certainly 
is not as not all interrupt sources may necessarily be routed to one of 
I/O APICs, and "noapic" can probably be treated as a special case of the 
mixed mode.  Regardless, there used to be systems in existence that 
wouldn't route IRQ 0 to an I/O APIC, so using that interrupt requires 
either the mixed mode or using the "through-i8259A" trick (which 
unfortunately does not work for a subset of affected systems as a result 
of manufacturers implementing the Intel-recommended glue logic at the 
output of the master i8259).

  Maciej
