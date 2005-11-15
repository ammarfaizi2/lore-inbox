Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964988AbVKOSWd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964988AbVKOSWd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 13:22:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964989AbVKOSWd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 13:22:33 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:11405 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S964988AbVKOSWc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 13:22:32 -0500
Date: Tue, 15 Nov 2005 10:22:06 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Andrew Morton <akpm@osdl.org>
cc: torvalds@osdl.org, marcelo.tosatti@cyclades.com, kravetz@us.ibm.com,
       raybry@mpdtxmail.amd.com, lee.schermerhorn@hp.com,
       linux-kernel@vger.kernel.org, magnus.damm@gmail.com, pj@sgi.com,
       haveblue@us.ibm.com, kamezawa.hiroyu@jp.fujitsu.com
Subject: Re: [PATCH 1/5] Swap Migration V5: LRU operations
In-Reply-To: <20051115100248.5ba2383d.akpm@osdl.org>
Message-ID: <Pine.LNX.4.62.0511151011150.10267@schroedinger.engr.sgi.com>
References: <20051101031239.12488.76816.sendpatchset@schroedinger.engr.sgi.com>
 <20051101031244.12488.38211.sendpatchset@schroedinger.engr.sgi.com>
 <20051114214415.1e107c7b.akpm@osdl.org> <Pine.LNX.4.62.0511150837190.9258@schroedinger.engr.sgi.com>
 <20051115100248.5ba2383d.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Nov 2005, Andrew Morton wrote:

> But lru_add_drain_per_cpu() will be called from interrupt context: the IPI
> handler.

Ahh.. thought you meant the lru_add_drain run on the local processor.
 
> I'm asking whether it is safe for the IPI handler to reenable interupts on
> all architectures.  It might be so, but I don't recall ever having seen it
> discussed, nor have I seen code which does it.

smp_call_function is also used by the slab allocator to drain the 
pages. All the spinlocks in there and those of the page allocator (called 
for freeing pages) use spin_lock_irqsave. Why is this not used for 
lru_add_drain() and friends?

Maybe we need to start a new thread so that others see it?

