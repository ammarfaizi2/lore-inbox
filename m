Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750793AbVJWWXg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750793AbVJWWXg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Oct 2005 18:23:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750796AbVJWWXg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Oct 2005 18:23:36 -0400
Received: from smtp.osdl.org ([65.172.181.4]:176 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750793AbVJWWXf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Oct 2005 18:23:35 -0400
Date: Sun, 23 Oct 2005 15:22:45 -0700
From: Andrew Morton <akpm@osdl.org>
To: hugh@veritas.com, clameter@sgi.com, rmk@arm.linux.org.uk, matthew@wil.cx,
       jdike@addtoit.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/9] mm: split page table lock
Message-Id: <20051023152245.4d1dc812.akpm@osdl.org>
In-Reply-To: <20051023142712.6c736dd3.akpm@osdl.org>
References: <Pine.LNX.4.61.0510221716380.18047@goblin.wat.veritas.com>
	<Pine.LNX.4.61.0510221727060.18047@goblin.wat.veritas.com>
	<20051023142712.6c736dd3.akpm@osdl.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> wrote:
>
>  Hugh Dickins <hugh@veritas.com> wrote:
>  >
>  > In this implementation, the spinlock is tucked inside the struct page of
>  >  the page table page: with a BUILD_BUG_ON in case it overflows - which it
>  >  would in the case of 32-bit PA-RISC with spinlock debugging enabled.
> 
>  eh?   It's going to overflow an unsigned long on x86 too:

Ah, I think I see what you've done: assume that .index, .lru and .virtual
are unused on pagetable pages, so we can just overwrite them.

ick.  I think I prefer the union, although it'll make struct page bigger
for CONFIG_PREEMPT+CONFIG_SMP+NR_CPUS>=4.    hmm.


