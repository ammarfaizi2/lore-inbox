Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261746AbUKIWnD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261746AbUKIWnD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 17:43:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261747AbUKIWnD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 17:43:03 -0500
Received: from fw.osdl.org ([65.172.181.6]:37054 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261746AbUKIWmI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 17:42:08 -0500
Date: Tue, 9 Nov 2004 14:46:07 -0800
From: Andrew Morton <akpm@osdl.org>
To: Lukas Hejtmanek <xhejtman@mail.muni.cz>
Cc: marcelo.tosatti@cyclades.com, zaphodb@zaphods.net,
       linux-kernel@vger.kernel.org, piggin@cyberone.com.au
Subject: Re: Kernel 2.6.9 Multiple Page Allocation Failures
Message-Id: <20041109144607.2950a41a.akpm@osdl.org>
In-Reply-To: <20041109223558.GR1309@mail.muni.cz>
References: <20041103222447.GD28163@zaphods.net>
	<20041104121722.GB8537@logos.cnet>
	<20041104181856.GE28163@zaphods.net>
	<20041109164113.GD7632@logos.cnet>
	<20041109223558.GR1309@mail.muni.cz>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lukas Hejtmanek <xhejtman@mail.muni.cz> wrote:
>
> Hi all,
> 
> On Tue, Nov 09, 2004 at 02:41:13PM -0200, Marcelo Tosatti wrote:
> > Stefan, Lukas, 
> > 
> > Can you please run your workload which cause 0-order page allocation 
> > failures with the following patch, pretty please? 
> > 
> > We will have more information on the free areas state when the allocation 
> > fails.
> > 
> > Andrew, please apply it to the next -mm, will you?
> 
> here is the trace:
>  klogd: page allocation failure. order:0, mode: 0x20
>   [__alloc_pages+441/862] __alloc_pages+0x1b9/0x363
>   [__get_free_pages+42/63] __get_free_pages+0x25/0x3f
>   [kmem_getpages+37/201] kmem_getpages+0x21/0xc9
>   [cache_grow+175/333] cache_grow+0xab/0x14d
>   [cache_alloc_refill+376/537] cache_alloc_refill+0x174/0x219
>   [__kmalloc+137/140] __kmalloc+0x85/0x8c
>   [alloc_skb+75/224] alloc_skb+0x47/0xe0
>   [e1000_alloc_rx_buffers+72/227] e1000_alloc_rx_buffers+0x44/0xe3
>   [e1000_clean_rx_irq+402/1095] e1000_clean_rx_irq+0x18e/0x447
>   [e1000_clean+85/202] e1000_clean+0x51/0xca

What kernel is in use here?

There was a problem related to e1000 and TSO which was leading to these
over-aggressive atomic allocations.  That was fixed (within ./net/)
post-2.6.9.

