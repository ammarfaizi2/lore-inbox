Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262214AbUCABNw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Feb 2004 20:13:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262216AbUCABNv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Feb 2004 20:13:51 -0500
Received: from fw.osdl.org ([65.172.181.6]:5821 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262214AbUCABNr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Feb 2004 20:13:47 -0500
Date: Sun, 29 Feb 2004 17:14:52 -0800
From: Andrew Morton <akpm@osdl.org>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: linux-kernel@vger.kernel.org, Nikita@Namesys.COM
Subject: Re: 2.6.4-rc1-mm1
Message-Id: <20040229171452.2e209835.akpm@osdl.org>
In-Reply-To: <40428B95.1000600@cyberone.com.au>
References: <20040229140617.64645e80.akpm@osdl.org>
	<40428B95.1000600@cyberone.com.au>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin <piggin@cyberone.com.au> wrote:
>
> I had one addition which is to use a "refill_counter" for inactive
>  list scanning as well so the scanning is batched up now that we don't
>  round up the amount to be done. No observed benefits, but I imagine
>  it would lower the acquisition frequency of the lru locks in some
>  cases?

Might do, yes.

Also I think you did some work on the inactive-vs-active list balancing?  I
have spent precisely zero time looking at or working on that since
2.5.nothing and it's entirely possible that it is doing something
inappropriate.

>  Should I start testing again, or are you still doing more to vmscan?

Now would be a good time.  The only thing I'm likely to look at in the next
several days is accounting for the slab fragmentation.  My current thinking
is to solve that by making slab account for the number of objects and the
number of pages, and to use that in shrink_dcache_memory(), so it doesn't
touch vmscan.c at all.

>  Nikita's dont-rotate-active-list.patch looks to be the only major
>  casualty. I found this patch pretty important, so I will definitely
>  like to demonstrate its benefits. One question remains, would you
>  accept the patch in its current form?

We should bring that back for testing, please.  I need to sit down and
think a bit more about test suites which replicate workloads which we care
about before making any decisions.

One point I would make is that if a workload is only achieving 5% CPU
anyway, we shouldn't optimise for it.  Sure, it's nice to be able to get it
up to 7% but it is much more important to get the 50% CPU workload up to
70%.  The 5% problem is a fiscal one, not an engineering one ;)

