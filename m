Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262705AbTCTWp0>; Thu, 20 Mar 2003 17:45:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262673AbTCTWoT>; Thu, 20 Mar 2003 17:44:19 -0500
Received: from packet.digeo.com ([12.110.80.53]:8368 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S262663AbTCTWnp>;
	Thu, 20 Mar 2003 17:43:45 -0500
Date: Thu, 20 Mar 2003 16:59:41 -0800
From: Andrew Morton <akpm@digeo.com>
To: Dave Jones <davej@codemonkey.org.uk>
Cc: green@namesys.com, linux-kernel@vger.kernel.org
Subject: Re: reiserfs oops [2.5.65]
Message-Id: <20030320165941.0d19d09d.akpm@digeo.com>
In-Reply-To: <20030320132409.GA19042@suse.de>
References: <20030319141048.GA19361@suse.de>
	<20030320112559.A12732@namesys.com>
	<20030320132409.GA19042@suse.de>
X-Mailer: Sylpheed version 0.8.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 20 Mar 2003 22:54:24.0959 (UTC) FILETIME=[A755E4F0:01C2EF33]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones <davej@codemonkey.org.uk> wrote:
>
> There's lots of "slab error in cache_alloc_debugcheck_after()"
> warnings. cache reiser_inode_cache memory after object was overwritten
> 
> Some call traces.
>  check_poison_obj <- kmem_cache_alloc <- reierfs_alloc_inode <-
>  reiserfs_alloc_inode <- alloc_inode <- get_new_inode <-
>  reiserfs_init_locked <- reiserfs_find_actor <- reiserfs_iget <-
>  reiserfs_find_actor <- reiserfs_init_locked_inode <- reiserfs_lookup <-
>  real_lookup <- do_lookup <- link_path_walk <- kmem_cache_alloc <-
>  __user_walk <- vfs_lstat <- sys_lstat64 <- syscall_call
> 
> Slab corruption: start=c70c7044, expend=c70c7213 problemat=c70c7044
> Last user: [<c0280dcb>](reiserfs_alloc_inode+0x1b/0x30)
> Data: (lots of hex)

Alas, the "(lots of hex)" is important - it lets us determine which member of
struct reiserfs_inode was actually altered.

> I'll give that box a run of memtest to rule out memory corruption
> problems. I'll also hook up a serial terminal tonight to catch tomorrow
> nights 'activity' in full 8-)

Good, thanks.

It would be nice if we had a more robust way of capturing all this info,
especially the oops-while-running-X lossage.  Dump-to-floppy or something.
