Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752011AbWHNLrO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752011AbWHNLrO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 07:47:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752016AbWHNLrN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 07:47:13 -0400
Received: from mail.suse.de ([195.135.220.2]:54707 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1752011AbWHNLrL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 07:47:11 -0400
To: linux@horizon.com
Cc: linux-kernel@vger.kernel.org, clameter@sgi.com
Subject: Re: [RFC] Simple Slab: A slab allocator with minimal meta information
References: <20060814011056.2381.qmail@science.horizon.com>
From: Andi Kleen <ak@suse.de>
In-Reply-To: <20060814011056.2381.qmail@science.horizon.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
Date: 14 Aug 2006 13:47:10 +0200
Message-ID: <p73d5b3a69t.fsf@verdi.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linux@horizon.com writes:

[this time without typo in cc, sorry if you get it twice]

> Um, with all this discussion of keeping caches hot, people do remember
> that FIFO handling of free blocks *greatly* reduces fragmentation, right?
> 
> That's an observation from malloc implementations that support merging
> of any two adjacent blocks, but at least some of it should apply to slab
> pages that require multple adjacent free objects to be returned to the
> free-page pool.

Interesting observation.

slab is a zone allocator and stores objects of the same type
into zones. The theory behind that is that normally that objects of the same
type have similar livetimes and that should in theory avoid
many fragmentation problems.

However some caches like dcache/inode cache don't seem to follow
that, and kmalloc which mixes all kinds of objects into the same
caches especially doesn't.

> Especially in a memory-constrained embedded environment, I'd think
> space-efficiency would be at least as important as time.

For memory-constrained environments there is already the optional 
specialized "slob" allocator.

That said even big systems have problems with fragmentation.

It is good that the basic assumptions behind slabs are being
revisited now. I suspect some of them might be obsolete.

-Andi
