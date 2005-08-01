Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261260AbVHAUvT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261260AbVHAUvT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 16:51:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261161AbVHAUvP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 16:51:15 -0400
Received: from silver.veritas.com ([143.127.12.111]:15384 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S261260AbVHAUuI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 16:50:08 -0400
Date: Mon, 1 Aug 2005 21:51:48 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Andrew Morton <akpm@osdl.org>
cc: nickpiggin@yahoo.com.au, holt@sgi.com, torvalds@osdl.org, mingo@elte.hu,
       roland@redhat.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [patch 2.6.13-rc4] fix get_user_pages bug
In-Reply-To: <20050801131240.4e8b1873.akpm@osdl.org>
Message-ID: <Pine.LNX.4.61.0508012144590.6323@goblin.wat.veritas.com>
References: <20050801032258.A465C180EC0@magilla.sf.frob.com>
 <42EDDB82.1040900@yahoo.com.au> <Pine.LNX.4.61.0508012045050.5373@goblin.wat.veritas.com>
 <20050801131240.4e8b1873.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 01 Aug 2005 20:50:07.0603 (UTC) FILETIME=[99B96C30:01C596DA]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Aug 2005, Andrew Morton wrote:
> static inline int handle_mm_fault(...)
> {
> 	int ret = __handle_mm_fault(...);
> 
> 	if (unlikely(ret == VM_FAULT_RACE))
> 		ret = VM_FAULT_MINOR;
> 	return ret;
> }
> because VM_FAULT_RACE is some internal private thing.
> It does add another test-n-branch to the pagefault path though.

Good idea, at least to avoid changing all arches at this moment;
though I don't think handle_mm_fault itself can be static inline.

But let's set this VM_FAULT_RACE approach aside for now: I think
we're agreed that the pte_dirty-with-mods-to-s390 route is more
attractive, so I'll now try to find fault with that approach.

Hugh
