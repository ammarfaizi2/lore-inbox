Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262231AbTIMWS0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Sep 2003 18:18:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262232AbTIMWS0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Sep 2003 18:18:26 -0400
Received: from natsmtp00.webmailer.de ([192.67.198.74]:17300 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP id S262231AbTIMWSZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Sep 2003 18:18:25 -0400
Message-Id: <200309132218.h8DMIBHj007826@post.webmailer.de>
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [patch] Make slab allocator work with SLAB_MUST_HWCACHE_ALIGN
To: Manfred Spraul <manfred@colorfullife.com>, linux-kernel@vger.kernel.org,
       Martin Schwidefsky <schwidefsky@de.ibm.com>,
       Ravikiran G Thirumalai <kiran@in.ibm.com>
Date: Sun, 14 Sep 2003 00:18:02 +0200
References: <u8mV.so.19@gated-at.bofh.it> <ufor.30e.21@gated-at.bofh.it> <usvj.6s9.17@gated-at.bofh.it> <uxv1.5D5.23@gated-at.bofh.it> <uCuI.5hY.13@gated-at.bofh.it> <uRWI.xK.5@gated-at.bofh.it> <voSF.8l7.17@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Manfred Spraul wrote:

> But back to the patch that started this thread: Do you still need the 
> ability to set an explicit alignment for slab allocations? If yes, then 
> I'd polish my patch, double check all kmem_cache_create callers and then 
> send the patch to akpm. Otherwise I'd wait - the patch is not a bugfix.

The explicit alignment would be my preferred way to fix slab debugging
on s390. We still have the problem that practically all s390 device drivers
need 64-bit alignment on slab allocations.

Our current hack is to redefine BYTES_PER_WORD in slab.c to 8, but what
I'd like to see is a per-architecture alignment in kmem_cache_init
that would default to 8 on s390 and to sizeof(long) otherwise.

Using the current SLAB_MUST_HWCACHE_ALIGN is not an option since
it wastes a lot of memory with our 2048-bit L1 cache lines.
I'd also like to avoid creating special slab caches for anything
that needs 8-byte alignment.

        Arnd <><
