Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265984AbRF1O7I>; Thu, 28 Jun 2001 10:59:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265986AbRF1O66>; Thu, 28 Jun 2001 10:58:58 -0400
Received: from bacchus.veritas.com ([204.177.156.37]:3293 "EHLO
	bacchus-int.veritas.com") by vger.kernel.org with ESMTP
	id <S265984AbRF1O6q>; Thu, 28 Jun 2001 10:58:46 -0400
Date: Thu, 28 Jun 2001 15:59:47 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
To: alad@hss.hns.com
cc: linux-kernel@vger.kernel.org
Subject: Re: kernel memory leak: freeing pagetables in vmfree_area_pages in
  vmalloc.c
In-Reply-To: <65256A79.00383EB6.00@sandesh.hss.hns.com>
Message-ID: <Pine.LNX.4.21.0106281546070.1692-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Jun 2001 alad@hss.hns.com wrote:
> I was talking about this leak 2 days back but my mail ot lost..
> ----
> we have in vfree -->
> vmfree_area_pages (calling) free_area_pmd (calling) free_area_pte (calling)
> free_page.
> The final free_page frees all the pages that are allocated to a memory
> region in vmalloc.
> Now where are we freeing pages that are allocated to page table themselves.
> For simplicity we can assume 2 level page tables (pgd == pmd)

They're not freed, but I don't see that as a memory leak.  The page
tables stay there ready for the next time a vmalloc() needs to expand
into them.  Seems sensible to me: do you have an actual case where it
wastes significant memory?

(I haven't thought it through, but I would not be surprised if there
turned out to be awkward races if those page tables were freed when
emptied: the code's probably simpler and surer the way it is.)

Hugh

