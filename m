Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262302AbTCYWfX>; Tue, 25 Mar 2003 17:35:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262586AbTCYWfX>; Tue, 25 Mar 2003 17:35:23 -0500
Received: from packet.digeo.com ([12.110.80.53]:43215 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S262302AbTCYWfX>;
	Tue, 25 Mar 2003 17:35:23 -0500
Date: Tue, 25 Mar 2003 16:50:59 -0800
From: Andrew Morton <akpm@digeo.com>
To: Hugh Dickins <hugh@veritas.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] swap 10/13 tmpfs atomics
Message-Id: <20030325165059.4b677f27.akpm@digeo.com>
In-Reply-To: <Pine.LNX.4.44.0303252219570.12636-100000@localhost.localdomain>
References: <Pine.LNX.4.44.0303252209070.12636-100000@localhost.localdomain>
	<Pine.LNX.4.44.0303252219570.12636-100000@localhost.localdomain>
X-Mailer: Sylpheed version 0.8.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 25 Mar 2003 22:46:26.0298 (UTC) FILETIME=[5E18C5A0:01C2F320]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins <hugh@veritas.com> wrote:
>
> move_from_swap_cache and add_to_page_cache_lru are using GFP_ATOMIC,
> which can easily fail in an intermittent way.  Rude if shmem_getpage
> then fails with -ENOMEM: cond_resched to let kswapd in, and repeat.

I think the preferred way of waiting for the IO system and kswapd to catch up
is blk_congestion_wait().  Because it waits for the "right" amount of time.

I'll make that change.

And yes, the name is silly: "what if it's not block-backed"?  It hasn't
caused any problems yet, but maybe one day we'll need to find a way for
network-backed filesystems to deliver a wakeup to sleepers there.

