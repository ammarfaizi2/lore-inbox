Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261184AbUKVWvS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261184AbUKVWvS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 17:51:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261179AbUKVWs7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 17:48:59 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:450 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261177AbUKVWsg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 17:48:36 -0500
Date: Mon, 22 Nov 2004 14:48:22 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: Andrew Morton <akpm@osdl.org>
cc: hugh@veritas.com, torvalds@osdl.org, benh@kernel.crashing.org,
       nickpiggin@yahoo.com.au, linux-mm@kvack.org, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: deferred rss update instead of sloppy rss
In-Reply-To: <20041122144507.484a7627.akpm@osdl.org>
Message-ID: <Pine.LNX.4.58.0411221444410.22895@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.44.0411221457240.2970-100000@localhost.localdomain>
 <Pine.LNX.4.58.0411221343410.22895@schroedinger.engr.sgi.com>
 <20041122141148.1e6ef125.akpm@osdl.org> <Pine.LNX.4.58.0411221408540.22895@schroedinger.engr.sgi.com>
 <20041122144507.484a7627.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Nov 2004, Andrew Morton wrote:

> > The page fault code only increments rss. For larger transactions that
> > increase / decrease rss significantly the page_table_lock is taken and
> > mm->rss is updated directly. So no
> > gross inaccuracies can result.
>
> Sure.  Take a million successive pagefaults and mm->rss is grossly
> inaccurate.  Hence my suggestion that it be spilled into mm->rss
> periodically.

It is spilled into mm->rss periodically. That is the whole point of the
patch.

The timer tick occurs every 1 ms. The maximum pagefault frequency that I
have  seen is 500000 faults /second. The max deviation is therefore
less than 500 (could be greater if page table lock / mmap_sem always held
when the tick occurs).
