Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266435AbUBLOkc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Feb 2004 09:40:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266445AbUBLOkc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Feb 2004 09:40:32 -0500
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:33731 "EHLO
	hemi.commfireservices.com") by vger.kernel.org with ESMTP
	id S266435AbUBLOkb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Feb 2004 09:40:31 -0500
Date: Thu, 12 Feb 2004 09:40:09 -0500 (EST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Andrew Morton <akpm@osdl.org>
Cc: Anton Blanchard <anton@samba.org>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: 2.6.3-rc2-mm1
In-Reply-To: <20040212040910.3de346d4.akpm@osdl.org>
Message-ID: <Pine.LNX.4.58.0402120937460.32441@montezuma.fsmlabs.com>
References: <20040212015710.3b0dee67.akpm@osdl.org> <20040212031322.742b29e7.akpm@osdl.org>
 <20040212115718.GF25922@krispykreme> <20040212040910.3de346d4.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Feb 2004, Andrew Morton wrote:

> Anton Blanchard <anton@samba.org> wrote:
> >
> >
> > > This kernel and also 2.6.3-rc1-mm1 have a nasty bug which causes
> > > current->preempt_count to be decremented by one on each hard IRQ.  It
> > > manifests as a BUG() in the slab code early in boot.
> > >
> > > Disabling CONFIG_DEBUG_SPINLOCK_SLEEP will fix this up.  Do not use this
> > > feature on ia32, for it is bust.
> >
> > A few questions spring to mind. Like who wrote that dodgy patch?
>
> The dog wrote my homework?

I've not managed to trigger this one

CONFIG_DEBUG_KERNEL=y
CONFIG_DEBUG_STACKOVERFLOW=y
# CONFIG_DEBUG_SLAB is not set
CONFIG_DEBUG_IOVIRT=y
CONFIG_DEBUG_SPINLOCK=y
CONFIG_DEBUG_PAGEALLOC=y
CONFIG_DEBUG_HIGHMEM=y
CONFIG_DEBUG_INFO=y
CONFIG_DEBUG_SPINLOCK_SLEEP=y

> > And any ideas how said person (who will remain nameless) broke ia32?
>
> Not really.  I spent a couple of hours debugging the darn thing, then gave
> up and used binary search to find the offending patch.
>
> <looks>
>
> include/asm-i386/hardirq.h:IRQ_EXIT_OFFSET needs treatment, I bet.
