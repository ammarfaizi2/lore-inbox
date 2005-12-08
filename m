Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932700AbVLHXDM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932700AbVLHXDM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 18:03:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932704AbVLHXDM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 18:03:12 -0500
Received: from fmr21.intel.com ([143.183.121.13]:29873 "EHLO
	scsfmr001.sc.intel.com") by vger.kernel.org with ESMTP
	id S932702AbVLHXDK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 18:03:10 -0500
Subject: Re: [discuss] [patch] x86_64:  align and pad x86_64 GDT on page
	boundary
From: Rohit Seth <rohit.seth@intel.com>
To: Ravikiran G Thirumalai <kiran@scalex86.org>
Cc: Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, discuss@x86-64.org, zach@vmware.com,
       shai@scalex86.org, nippung@calsoftinc.com
In-Reply-To: <20051208215514.GE3776@localhost.localdomain>
References: <20051208215514.GE3776@localhost.localdomain>
Content-Type: text/plain
Organization: Intel 
Date: Thu, 08 Dec 2005 15:09:17 -0800
Message-Id: <1134083357.7131.21.camel@akash.sc.intel.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 08 Dec 2005 23:02:26.0748 (UTC) FILETIME=[751C8FC0:01C5FC4B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-12-08 at 13:55 -0800, Ravikiran G Thirumalai wrote:
> On Thu, Dec 08, 2005 at 09:15:18PM +0100, Andi Kleen wrote:
> > On Thu, Dec 08, 2005 at 11:42:32AM -0800, Ravikiran G Thirumalai
> wrote:
> > > 
> > > -   .align  L1_CACHE_BYTES
> > > +   /* zero the remaining page */
> > > +   .fill PAGE_SIZE / 8 - GDT_ENTRIES,8,0
> > > +  
> > >  ENTRY(idt_table)  
> >
> > Why can't the IDT not be shared with the GDT page? It should be
> mostly
> > read only right and putting r-o data on that page should be ok,
> right?
> 
> Yes, you are right.  This should not have been a problem. 
> Some people reported this symbol (cpu_gdt) though.  Will have to go
> back and
> check.

IIRC, Zach's patches for gdt alignment, moved the gdts from per_cpu data
structure to each secondary CPU dynamically allocating page for its gdt.
This was mainly to address the excessive cost in virtualized
environments of sharing the gdt page with other RW items in per_cpu_data
structure.  I think the padding was because xen does not like sharing
gdt page with anything else...

I agree that if no other constraint is there then IDT could be moved
into the same page.

-rohit

