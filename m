Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932704AbVLHXLr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932704AbVLHXLr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 18:11:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932705AbVLHXLr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 18:11:47 -0500
Received: from mail.suse.de ([195.135.220.2]:15034 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932704AbVLHXLr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 18:11:47 -0500
Date: Fri, 9 Dec 2005 00:11:41 +0100
From: Andi Kleen <ak@suse.de>
To: Rohit Seth <rohit.seth@intel.com>
Cc: Ravikiran G Thirumalai <kiran@scalex86.org>, Andi Kleen <ak@suse.de>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       discuss@x86-64.org, zach@vmware.com, shai@scalex86.org,
       nippung@calsoftinc.com
Subject: Re: [discuss] [patch] x86_64:  align and pad x86_64 GDT on page boundary
Message-ID: <20051208231141.GX11190@wotan.suse.de>
References: <20051208215514.GE3776@localhost.localdomain> <1134083357.7131.21.camel@akash.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1134083357.7131.21.camel@akash.sc.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 08, 2005 at 03:09:17PM -0800, Rohit Seth wrote:
> On Thu, 2005-12-08 at 13:55 -0800, Ravikiran G Thirumalai wrote:
> > On Thu, Dec 08, 2005 at 09:15:18PM +0100, Andi Kleen wrote:
> > > On Thu, Dec 08, 2005 at 11:42:32AM -0800, Ravikiran G Thirumalai
> > wrote:
> > > > 
> > > > -   .align  L1_CACHE_BYTES
> > > > +   /* zero the remaining page */
> > > > +   .fill PAGE_SIZE / 8 - GDT_ENTRIES,8,0
> > > > +  
> > > >  ENTRY(idt_table)  
> > >
> > > Why can't the IDT not be shared with the GDT page? It should be
> > mostly
> > > read only right and putting r-o data on that page should be ok,
> > right?
> > 
> > Yes, you are right.  This should not have been a problem. 
> > Some people reported this symbol (cpu_gdt) though.  Will have to go
> > back and
> > check.
> 
> IIRC, Zach's patches for gdt alignment, moved the gdts from per_cpu data
> structure to each secondary CPU dynamically allocating page for its gdt.

Kiran's patch does this too.  Except for the BP GDT, which could
be shared with the single IDT.

-Andi (who actually plans to attack per CPU IDTs at some point
so this could change later) 

