Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751204AbVKJTuJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751204AbVKJTuJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 14:50:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751212AbVKJTuJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 14:50:09 -0500
Received: from smtp.osdl.org ([65.172.181.4]:3036 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751204AbVKJTuH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 14:50:07 -0500
Date: Thu, 10 Nov 2005 11:49:50 -0800
From: Andrew Morton <akpm@osdl.org>
To: Hugh Dickins <hugh@veritas.com>
Cc: mingo@elte.hu, linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [PATCH 01/15] mm: poison struct page for ptlock
Message-Id: <20051110114950.03a5946b.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.61.0511101323540.7464@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0511100139550.5814@goblin.wat.veritas.com>
	<Pine.LNX.4.61.0511100142160.5814@goblin.wat.veritas.com>
	<20051109181022.71c347d4.akpm@osdl.org>
	<Pine.LNX.4.61.0511100215150.6138@goblin.wat.veritas.com>
	<20051109185645.39329151.akpm@osdl.org>
	<20051110120624.GB32672@elte.hu>
	<Pine.LNX.4.61.0511101233530.6896@goblin.wat.veritas.com>
	<20051110045144.40751a42.akpm@osdl.org>
	<Pine.LNX.4.61.0511101323540.7464@goblin.wat.veritas.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins <hugh@veritas.com> wrote:
>
>  On Thu, 10 Nov 2005, Andrew Morton wrote:
>  > Hugh Dickins <hugh@veritas.com> wrote:
>  > > On Thu, 10 Nov 2005, Ingo Molnar wrote:
>  > > > 
>  > > > yuck. What is the real problem btw? AFAICS there's enough space for a 
>  > > > 2-word spinlock in struct page for pagetables.
>  > > 
>  > > Yes.  There is no real problem.  But my patch offends good taste.
>  > 
>  > Isn't it going to overrun page.lru with CONFIG_DEBUG_SPINLOCK?
> 
>  No.

!no, methinks.

On 32-bit architectures with CONFIG_PREEMPT, CONFIG_DEBUG_SPINLOCK,
CONFIG_NR_CPUS >= CONFIG_SPLIT_PTLOCK_CPUS we have a 32-byte page, a
20-byte spinlock and offsetof(page, private) == 12.

IOW we're assuming that no 32-bit architectures will obtain pagetables from
slab?
