Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261440AbTCTNNS>; Thu, 20 Mar 2003 08:13:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261441AbTCTNNS>; Thu, 20 Mar 2003 08:13:18 -0500
Received: from deviant.impure.org.uk ([195.82.120.238]:62600 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id <S261440AbTCTNNR>; Thu, 20 Mar 2003 08:13:17 -0500
Date: Thu, 20 Mar 2003 13:24:09 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Oleg Drokin <green@namesys.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: reiserfs oops [2.5.65]
Message-ID: <20030320132409.GA19042@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Oleg Drokin <green@namesys.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <20030319141048.GA19361@suse.de> <20030320112559.A12732@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030320112559.A12732@namesys.com>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 20, 2003 at 11:25:59AM +0300, Oleg Drokin wrote:

 > Hm, very interesting. Thank you.
 > I've seen this once too, but on kernel patched with lots of unrelated and
 > possibly memory corrupting stuff.
 > I will look at it more closely.
 > BTW, it oopsed not in find. Is your box SMP?

Same box committed seppuku overnight, this time in a different way.

There's lots of "slab error in cache_alloc_debugcheck_after()"
warnings. cache reiser_inode_cache memory after object was overwritten

Some call traces.
 check_poison_obj <- kmem_cache_alloc <- reierfs_alloc_inode <-
 reiserfs_alloc_inode <- alloc_inode <- get_new_inode <-
 reiserfs_init_locked <- reiserfs_find_actor <- reiserfs_iget <-
 reiserfs_find_actor <- reiserfs_init_locked_inode <- reiserfs_lookup <-
 real_lookup <- do_lookup <- link_path_walk <- kmem_cache_alloc <-
 __user_walk <- vfs_lstat <- sys_lstat64 <- syscall_call

Slab corruption: start=c70c7044, expend=c70c7213 problemat=c70c7044
Last user: [<c0280dcb>](reiserfs_alloc_inode+0x1b/0x30)
Data: (lots of hex)

I'll give that box a run of memtest to rule out memory corruption
problems. I'll also hook up a serial terminal tonight to catch tomorrow
nights 'activity' in full 8-)

		Dave

