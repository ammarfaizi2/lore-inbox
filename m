Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268510AbTCAFW6>; Sat, 1 Mar 2003 00:22:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268511AbTCAFW6>; Sat, 1 Mar 2003 00:22:58 -0500
Received: from packet.digeo.com ([12.110.80.53]:25528 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S268510AbTCAFW5>;
	Sat, 1 Mar 2003 00:22:57 -0500
Date: Fri, 28 Feb 2003 21:33:20 -0800
From: Andrew Morton <akpm@digeo.com>
To: Dawson Engler <engler@csl.stanford.edu>
Cc: linux-kernel@vger.kernel.org, mc@cs.stanford.edu
Subject: Re: [CHECKER] a few race conditions
Message-Id: <20030228213320.6d2da213.akpm@digeo.com>
In-Reply-To: <200303010455.h214tpO11048@csl.stanford.edu>
References: <200303010455.h214tpO11048@csl.stanford.edu>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 01 Mar 2003 05:33:13.0271 (UTC) FILETIME=[0D758C70:01C2DFB4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dawson Engler <engler@csl.stanford.edu> wrote:
>
> BUG FALSE pair: lock=<dcache_lock:spinlock_t:0>, var=<struct inode.i_dentry>
>   2 errors out of 5 uses:
>      /u2/engler/mc/oses/linux/linux-2.5.53/fs/dcache.c:284:d_prune_aliases: ERROR: var <struct inode.i_dentry> not protected by <dcache_lock:spinlock_t:0>(pop=5, s=3) [locked=0]
> 
>         i think this actually is a race: other places check it.
> 
> void d_prune_aliases(struct inode *inode)
> {
>         struct list_head *tmp, *head = &inode->i_dentry;
> restart:
>         spin_lock(&dcache_lock);

This is OK.  Local variable `head' is being set up to point at a member
inside the inode, but we're not dereferencing that pointer outside the lock. 
The address of inode->i_dentry is constant across this function.
