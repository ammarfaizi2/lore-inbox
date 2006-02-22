Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751332AbWBVEDp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751332AbWBVEDp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 23:03:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751331AbWBVEDo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 23:03:44 -0500
Received: from ozlabs.org ([203.10.76.45]:42705 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1751322AbWBVEDn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 23:03:43 -0500
Date: Wed, 22 Feb 2006 15:02:50 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: David Mosberger-Tang <David.Mosberger@acm.org>
Cc: "Chen, Kenneth W" <kenneth.w.chen@intel.com>, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: IA64 non-contiguous memory space bugs
Message-ID: <20060222040250.GA3081@localhost.localdomain>
Mail-Followup-To: David Gibson <david@gibson.dropbear.id.au>,
	David Mosberger-Tang <David.Mosberger@acm.org>,
	"Chen, Kenneth W" <kenneth.w.chen@intel.com>,
	linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20060222001359.GA23574@localhost.localdomain> <200602220253.k1M2rWg10346@unix-os.sc.intel.com> <ed5aea430602211955k225698c9w35ac02eae071a0c5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ed5aea430602211955k225698c9w35ac02eae071a0c5@mail.gmail.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 21, 2006 at 08:55:15PM -0700, David Mosberger-Tang wrote:
> I'm only following this superficially, but keep in mind that a vm-area
> MUST NEVER cross a hole.

Yes.. but it can, that's precisely the bug.

> On 2/21/06, Chen, Kenneth W <kenneth.w.chen@intel.com> wrote:
> > David Gibson wrote on Tuesday, February 21, 2006 4:14 PM
> > > First bug (confirmed many months ago by Chris Wedgwood) - you can get
> > > weird effects if you attempt to mmap() something into one of the
> > > address space gaps.  The ia64 outer wrapper for mmap2() tries to
> > > prevent it, but doesn't do a good enough job, it's still possible
> > > indirectly with shmat() and maybe mremap().  Basic trouble is that
> > > most of the checks applied by the generic code assume that everything
> > > between 0 and TASK_SIZE is valid.
> >
> > Ha ha ha.
> >
> > On ia64, the low level tlb fault handler (vhpt_miss and nested_dtlb_miss)
> > checks that all unused address bits (between REGION_NUMBER and PGDIR_SHIFT)
> > should be all zero.  If they are not zero, it will fall into page fault
> > handler and in there, ia64 should just send SEGV instead of happily hand
> > over a page.  Buggy buggy....

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
