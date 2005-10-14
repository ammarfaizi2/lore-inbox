Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750821AbVJNSKf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750821AbVJNSKf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Oct 2005 14:10:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750828AbVJNSKf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Oct 2005 14:10:35 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:44006 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1750821AbVJNSKd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Oct 2005 14:10:33 -0400
Date: Fri, 14 Oct 2005 13:09:46 -0500
From: Robin Holt <holt@sgi.com>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: Robin Holt <holt@sgi.com>, ia64 list <linux-ia64@vger.kernel.org>,
       linux-mm <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       hch@infradead.org, jgarzik@pobox.com,
       William Lee Irwin III <wli@holomorphy.com>
Subject: Re: [Patch 2/2] Special Memory (mspec) driver.
Message-ID: <20051014180946.GA4143@lnx-holt.americas.sgi.com>
References: <20051012194022.GE17458@lnx-holt.americas.sgi.com> <20051012194233.GG17458@lnx-holt.americas.sgi.com> <1129266725.22903.25.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1129266725.22903.25.camel@localhost>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 13, 2005 at 10:12:05PM -0700, Dave Hansen wrote:
> On Wed, 2005-10-12 at 14:42 -0500, Robin Holt wrote:
> ...
> 
> Looks like you could un-indent almost the entire function of you just
> did this instead:
> 
> 	if (!atomic_dec_and_test(&vdata->refcnt))
> 		return;

Done

> 
> This looks pretty similar to get_one_pte_map().  Is there enough
> commonality to use it?
> 

Added an extra patch to export get_one_pte_map and used that instead.

> How about:
> 
> 	vdata = vmalloc(sizeof(struct vma_data) + pages * sizeof(long));
> 	if (!vdata)
> 		return -ENOMEM;

Done

> This whole thing really is a driver for a piece of arch-specific
> hardware, right?  Does it really belong in /proc?  You already have a
> misc device, so you already have some area in sysfs.  Would that make a
> better place for it?

Most of the useful information for this was removed when the kernel
uncached allocator (and gen_alloc) were moved out of the earliest mspec.c.
Removed entirely.

> Isn't the general kernel style for these to keep the action out of the
> if() condition?
> 
> 	ret = misc_register(&cached_miscdev);
> 	if (ret) {
> 		...

Done.

Thanks,
Robin Holt
