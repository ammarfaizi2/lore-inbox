Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750931AbVLBWlI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750931AbVLBWlI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Dec 2005 17:41:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750944AbVLBWlH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Dec 2005 17:41:07 -0500
Received: from cantor2.suse.de ([195.135.220.15]:25832 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750941AbVLBWlG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Dec 2005 17:41:06 -0500
Date: Fri, 2 Dec 2005 23:41:04 +0100
From: Andi Kleen <ak@suse.de>
To: Ravikiran G Thirumalai <kiran@scalex86.org>
Cc: Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, discuss@x86-64.org, shai@scalex86.org
Subject: Re: [patch 3/3] x86_64: Node local PDA -- allocate node local memory for pda
Message-ID: <20051202224104.GE9766@wotan.suse.de>
References: <20051202081028.GA5312@localhost.localdomain> <20051202082309.GC5312@localhost.localdomain> <20051202114708.GM997@wotan.suse.de> <20051202200234.GB3727@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051202200234.GB3727@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 02, 2005 at 12:02:34PM -0800, Ravikiran G Thirumalai wrote:
> On Fri, Dec 02, 2005 at 12:47:09PM +0100, Andi Kleen wrote:
> > On Fri, Dec 02, 2005 at 12:23:09AM -0800, Ravikiran G Thirumalai wrote:
> > > Patch uses a static PDA array early at boot and reallocates processor PDA
> > > with node local memory when kmalloc is ready, just before pda_init.
> > > The boot_cpu_pda is needed sice the cpu_pda is used even before pda_init for
> > > that cpu is called (to set the static per-cpu areas offset table etc)
> > 
> > Where is it needed?  Perhaps it should be just allocated in the 
> > CPU triggering the other CPU start instead. Then you could avoid that
> > or rather only define a __initdata boot_pda for the BP.
> >
> 
> setup_per_cpu_areas() is invoked quite early in the boot process and it
> writes into the cpu_pda.data_offset field for all the cpus. I'd even tried
> storing the offset table for cpus in a temporary table (which can be marked
> __initdata and discarded later),  but there were references
> to the static per cpu areas through per_cpu macros (which need to use the
> cpu_pda) even before the BP boots up and starts the secondary cpus,
> resulting in early exceptions.

Move it into smpboot.c then on the parent CPU.

-Andi
