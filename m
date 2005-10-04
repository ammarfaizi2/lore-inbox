Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964897AbVJDTBg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964897AbVJDTBg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 15:01:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964920AbVJDTBg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 15:01:36 -0400
Received: from mx2.suse.de ([195.135.220.15]:16103 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S964897AbVJDTBf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 15:01:35 -0400
From: Andi Kleen <ak@suse.de>
To: Tejun Heo <htejun@gmail.com>
Subject: Re: Question regarding x86_64 __PHYSICAL_MASK_SHIFT
Date: Tue, 4 Oct 2005 21:01:44 +0200
User-Agent: KMail/1.8.2
Cc: lkml <linux-kernel@vger.kernel.org>, discuss@x86-64.org
References: <43426EB4.6080703@gmail.com> <200510041924.56772.ak@suse.de> <20051004185230.GA8431@htj.dyndns.org>
In-Reply-To: <20051004185230.GA8431@htj.dyndns.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510042101.44946.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 04 October 2005 20:52, Tejun Heo wrote:
>  Hello, Andi.
>
> On Tue, Oct 04, 2005 at 07:24:56PM +0200, Andi Kleen wrote:
> > You're right - PHYSICAL_MASK shouldn't be applied to PFNs, only to full
> > addresses. Fixed with appended patch.
> >
> > The 46bits limit is because half of the 48bit virtual space
> > is used for user space and the other 47 bit half is divided into
> > direct mapping and other mappings (ioremap, vmalloc etc.). All
> > physical memory has to fit into the direct mapping, so you
> > end with a 46 bit limit.
>
>  __PHYSICAL_MASK is only used to mask out non-pfn bits from page table
> entries.  I don't really see how it's related to virtual space
> construction.

Any other bits are not needed and should be pte_bad()ed.

Ok there could be IO mappings beyond 46bits in theory, but I will worry about
these when they happen. For now it's better to error out to easier detect
memory corruptions in page tables (some x86-64 CPUs tend to machine
check when presented with unmapped physical addresses, which 
is nasty to track down) 

>
> > See also Documentation/x86-64/mm.txt
>
>  Thanks.  :-)
>
>  I think PHYSICAL_PAGE_MASK and PTE_FILE_MAX_BITS should also be
> updated.  How about the following patch?  Compile & boot tested.

No, I think the existing code with my patch is fine.

-Andi
