Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131087AbRBPToY>; Fri, 16 Feb 2001 14:44:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131094AbRBPToO>; Fri, 16 Feb 2001 14:44:14 -0500
Received: from nat-pool.corp.redhat.com ([199.183.24.200]:58897 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S131087AbRBPToB>; Fri, 16 Feb 2001 14:44:01 -0500
Date: Fri, 16 Feb 2001 14:42:52 -0500 (EST)
From: Ben LaHaise <bcrl@redhat.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Manfred Spraul <manfred@colorfullife.com>,
        Jamie Lokier <lk@tantalophile.demon.co.uk>,
        <linux-kernel@vger.kernel.org>
Subject: Re: x86 ptep_get_and_clear question
In-Reply-To: <Pine.LNX.4.10.10102161124500.1046-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.30.0102161439050.17251-100000@today.toronto.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Feb 2001, Linus Torvalds wrote:

> This is, actually, a problem that I suspect ends up being _very_ similar
> to the zap_page_range() case. zap_page_range() needs to make sure that
> everything has been updated by the time the page is actually free'd. While
> filemap_sync() needs to make sure that everything has been updated before
> the page is written out (or marked dirty - which obviously also guarantees
> the ordering, and makes the problems look even more similar).

Ah, I see what I was missing.  So long as the tlb flush is in between the
ptep_test_and_clear_dirty and the set_page_dirty, we're fine (ie the
current code is good).  If we really want to reduce the number of tlb
flushes, yes, we can use the gather code and then just do the
set_page_dirty after a tlb_flush_range.

		-ben

