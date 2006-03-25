Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751501AbWCYRvE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751501AbWCYRvE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Mar 2006 12:51:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751503AbWCYRvE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Mar 2006 12:51:04 -0500
Received: from silver.veritas.com ([143.127.12.111]:19745 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S1751501AbWCYRvC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Mar 2006 12:51:02 -0500
X-BrightmailFiltered: true
X-Brightmail-Tracker: AAAAAA==
X-IronPort-AV: i="4.03,128,1141632000"; 
   d="scan'208"; a="36417307:sNHT25273128"
Date: Sat, 25 Mar 2006 17:51:56 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: rgetz@blackfin.uclinux.org
cc: Nick Piggin <nickpiggin@yahoo.com.au>, Andi Kleen <ak@suse.de>,
       linux-kernel@vger.kernel.org
Subject: Re: RFC: Non Power of 2 memory allocator
In-Reply-To: <p73mzfepkad.fsf@verdi.suse.de>
Message-ID: <Pine.LNX.4.61.0603251745500.8348@goblin.wat.veritas.com>
References: <6.1.1.1.0.20060325090152.01ec63f0@ptg1.spd.analog.com>
 <p73mzfepkad.fsf@verdi.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 25 Mar 2006 17:51:02.0108 (UTC) FILETIME=[AE6601C0:01C65034]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Mar 2006, Andi Kleen wrote:
> Robin Getz <rgetz@blackfin.uclinux.org> writes:
> 
> > The  buddy system allocates things in power of 2 pages sizes (4k, 8k,
> > 16k, 32k, 64k, 128k, 256k, 512k, 1024k), which works fine on most
> > systems, but an embedded system, which is running without a MMU (
> > Memory Management Unit) - RAM is precious, and when you only need
> > 129k for an application, you don't want to allocate a power of 2,
> > which gives you 256k -  an extra 127k, which can't be used by
> > anything else.
> 
> In 2.4 I solved this problem at some point by just returning
> the excess pages to the buddy allocator. There was even
> a nice function to do this (alloc_exact)
> 
> That won't work for slab, but does for __get_free_pages() which
> is better for large allocations anyways. slab imho doesn't make
> sense for allocation anywhere bigger PAGE_SIZE/2. At some
> point in 2.6 there was trouble with "compound pages" but I think
> that has been resolved. 
> 
> Just implementing alloc_exact again would be the simplest solution
> for your problem.

Nick has put a split_page function into the 2.6.16-git mm/page_alloc.c,
which I believe is supposed to be a helper in this kind of operation.
You'd best take a look at where and how it's used.  Perhaps Andi's
alloc_exact should be reimplemented in terms of it.

Hugh
