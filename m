Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131023AbRBPTDq>; Fri, 16 Feb 2001 14:03:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131025AbRBPTDg>; Fri, 16 Feb 2001 14:03:36 -0500
Received: from nat-pool.corp.redhat.com ([199.183.24.200]:40173 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S131023AbRBPTD2>; Fri, 16 Feb 2001 14:03:28 -0500
Date: Fri, 16 Feb 2001 14:02:10 -0500 (EST)
From: Ben LaHaise <bcrl@redhat.com>
To: Manfred Spraul <manfred@colorfullife.com>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Jamie Lokier <lk@tantalophile.demon.co.uk>,
        <linux-kernel@vger.kernel.org>
Subject: Re: x86 ptep_get_and_clear question
In-Reply-To: <3A8D764B.9CD6B3A8@colorfullife.com>
Message-ID: <Pine.LNX.4.30.0102161355270.17251-100000@today.toronto.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Feb 2001, Manfred Spraul wrote:

> That leaves msync() - it currently does a flush_tlb_page() for every
> single dirty page.
> Is it possible to integrate that into the mmu gather code?
>
> tlb_transfer_dirty() in addition to tlb_clear_page()?

Actually, in the filemap_sync case, the flush_tlb_page is redundant --
there's already a call to flush_tlb_range in filemap_sync after the dirty
bits are cleared.  None of the cpus we support document having a writeback
tlb, and intel's docs explicitely state that they do not as they state
that the dirty bit is updated on the first write to dirty the pte.

		-ben

