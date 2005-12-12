Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932323AbVLLXwA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932323AbVLLXwA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Dec 2005 18:52:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932312AbVLLXvq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Dec 2005 18:51:46 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:28555 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S932310AbVLLXvo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Dec 2005 18:51:44 -0500
Date: Mon, 12 Dec 2005 15:51:17 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org, ak@suse.de, bunk@stusta.de
Subject: Re: [PATCH] Introduce atomic_long_t and asm-generic/atomic.h
In-Reply-To: <20051212154224.10a8c5e4.akpm@osdl.org>
Message-ID: <Pine.LNX.4.62.0512121542330.15821@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.62.0512121028410.14769@schroedinger.engr.sgi.com>
 <20051212154224.10a8c5e4.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Dec 2005, Andrew Morton wrote:

> It assumes that sizeof(long) = sizeof(int) ifndef ATOMIC64_INIT.  Which is
> true, but there are still problems.  For example, I'd reasonably expect this:

If ATOMIC64_INIT is not defined then atomic_t == atomic_long_t. Everything 
beyond that comes already with atomic_t.

> 	printk("%ld", atomic_long_read(v));
> 
> to not produce a warning.  It may also lead to long*/int* warnings or build
> errors.

The mm_counter_t logic in include/linux/sched.h already does the same as 
this patch. So we already have that issue.

> Also, it kind-of assumes that each 64-bit arch uses `long' for its 64-bit
> value.  sh64, for example, appears to use `long long'.

sh64 has no atomic64 support. And so atomic_long will be 32bit.

Hmmm.. Maybe rename atomic_long_t to something else?

