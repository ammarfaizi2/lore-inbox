Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268140AbRG2UPf>; Sun, 29 Jul 2001 16:15:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268147AbRG2UP0>; Sun, 29 Jul 2001 16:15:26 -0400
Received: from bacchus.veritas.com ([204.177.156.37]:15518 "EHLO
	bacchus-int.veritas.com") by vger.kernel.org with ESMTP
	id <S268140AbRG2UPS>; Sun, 29 Jul 2001 16:15:18 -0400
Date: Sun, 29 Jul 2001 21:16:30 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hold cow while breaking
In-Reply-To: <Pine.LNX.4.33.0107290827430.7119-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.21.0107292107160.1014-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Sun, 29 Jul 2001, Linus Torvalds wrote:
> On Sun, 29 Jul 2001, Hugh Dickins wrote:
> >
> > do_wp_page() COW breaking is now very slightly unsafe.  Please don't
> > ask me to provide a test case! but the pte_same() check after regetting
> > page_table_lock is not quite enough to guarantee that the old_page was
> > not reaped, reused for something else, copy_cow_paged while containing
> > that other data, freed and then reused for precisely its original pte.
> 
> Oh, but it is.
> 
> We do hold the MM semaphore over the whole sequence, so there's no way the
> page table entry can be replaced by anything else than a non-present one
> (ie vmscan can swap it out, but nothing can swap it in because of the
> lock).

Sorry for being dense, but I still don't get it.  I thought the
down_read on mmap_sem is permitting concurrent faults by other users
of the address space (but excluding structural changes to the address
space)?  and we haven't locked the page itself, and we've temporarily
dropped the page_table_lock.  I just don't see what lock prevents the
page from being refaulted in.

Hugh

