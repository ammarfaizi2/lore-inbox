Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261726AbVCHGCv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261726AbVCHGCv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 01:02:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261523AbVCHGCu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 01:02:50 -0500
Received: from waste.org ([216.27.176.166]:25769 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261726AbVCHGBn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 01:01:43 -0500
Date: Mon, 7 Mar 2005 22:01:29 -0800
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, viro@parcelfarce.linux.theplanet.co.uk
Subject: Re: [PATCH] unified device list allocator
Message-ID: <20050308060128.GJ3120@waste.org>
References: <20050308051818.GI3120@waste.org> <20050307213302.560de053.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050307213302.560de053.akpm@osdl.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 07, 2005 at 09:33:02PM -0800, Andrew Morton wrote:
> Matt Mackall <mpm@selenic.com> wrote:
> >
> > +	/* search for insertion point in reverse for dynamic allocation */
> >  +	list_for_each_prev(l, list) {
> 
> hrmph.  Any time we do anything in O(n) time, some smarty comes along with
> a workload which blows us out of the water.  Although it's hard to think of
> any register_blkdev()-intensive workloads.
> 
> It's not possible to do this with prio-trees?

I thought about using rbtrees. But I decided it was overkill. Beyond
the 4k limit of the current proc code, currently that's limited to
~256 entries per block/char and will be limited to about ~1024 each
for the foreseeable future. It's only walked on driver init/exit and
when catting said proc file (where O(n) is unavoidable). In other
words, worst case we're talking less than a millisecond at
boot/shutdown.

-- 
Mathematics is the supreme nostalgia of our time.
