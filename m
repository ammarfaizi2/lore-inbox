Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263146AbUB1EeR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 23:34:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263159AbUB1EeQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 23:34:16 -0500
Received: from citrine.spiritone.com ([216.99.193.133]:37859 "EHLO
	citrine.spiritone.com") by vger.kernel.org with ESMTP
	id S263146AbUB1EeP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 23:34:15 -0500
Date: Fri, 27 Feb 2004 20:34:07 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: john stultz <johnstul@us.ibm.com>, Andrew Morton <akpm@osdl.org>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.3-mm3 (ioremap failure w/ _X86_4G and _NUMA)
Message-ID: <466740000.1077942846@[10.10.2.4]>
In-Reply-To: <1077936504.10076.63.camel@cog.beaverton.ibm.com>
References: <20040222172200.1d6bdfae.akpm@osdl.org> <1077924860.10076.49.camel@cog.beaverton.ibm.com> <20040227160613.17be31cb.akpm@osdl.org> <1077936504.10076.63.camel@cog.beaverton.ibm.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Fri, 2004-02-27 at 16:06, Andrew Morton wrote:
>> john stultz <johnstul@us.ibm.com> wrote:
>> > 
>> > When running -mm3 (plus the one-line fix to the expanded-pci-config
>> > patch) to on an x440  w/ 4G enabled, the tg3 driver cannot find my
>> > network card. 
>> > 
>> > When booting I get:
>> > tg3.c:v2.7 (February 17, 2004)                
>> > tg3: Cannot map device registers, aborting.
>> > tg3: probe of 0000:01:04.0 failed with error -12
>> > 
>> > Otherwise the system seems to come up fine. 
>> > 
>> > Disabling CONFIG_ACPI (or CONFIG_X86_4G) makes the problem go away.
>> 
>> Beats me.  Maybe acpi is returning some monstrous reosurce length and we're
>> running out of kernel virtual space only with the 4g split?
>> 
>> 'twould be appreciated if you could stick a few printk's in there and work
>> out what's happening please.  Check out the pci space base address and
>> length with and without ACPI?
> 
> The base address and length are the same either way, instead its
> __ioremap that's failing at "if(!PageReserved(page))"[ioremap.c:142].
> 
> I've also narrowed down the issue to only occur w/ (CONFIG_X86_4G=y &&
> CONFIG_NUMA=y) so it looks like its a propblem w/ 4G and discontigmem
> together. 
> 
> I've also finally moved to -mm4 and reproduced the problem there.
> 
> Martin: Any ideas?

Darren and I worked out that CONFIG_SCHED_SMT seems to be causing problems
in -mjb at least ... you might try turning that off for -mm, and see if 
that helps. Meanwhile, I'll try seeing if any of the updated sched stuff
in -mm works for me ;-)

M.

