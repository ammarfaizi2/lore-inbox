Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318242AbSHKJTW>; Sun, 11 Aug 2002 05:19:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318244AbSHKJTW>; Sun, 11 Aug 2002 05:19:22 -0400
Received: from ns.suse.de ([213.95.15.193]:34057 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S318242AbSHKJTV>;
	Sun, 11 Aug 2002 05:19:21 -0400
To: Andrew Morton <akpm@zip.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch 13/21] deferred and batched addition of faulted-in pages to the   LRU
References: <3D5614B2.EFD25A8D@zip.com.au.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 11 Aug 2002 11:23:08 +0200
In-Reply-To: Andrew Morton's message of "11 Aug 2002 09:42:00 +0200"
Message-ID: <p73wuqxiwar.fsf@oldwotan.suse.de>
X-Mailer: Gnus v5.7/Emacs 20.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@zip.com.au> writes:
>   */
> -void lru_cache_add(struct page * page)
> +static struct pagevec lru_add_pvecs[NR_CPUS];
> +
> +void lru_cache_add(struct page *page)
> +{
> +	struct pagevec *pvec = &lru_add_pvecs[get_cpu()];

This should probably use the linux/percpu.h macros. 
This way it could be more efficient on some architectures and also avoid
potential false sharing.

-Andi
