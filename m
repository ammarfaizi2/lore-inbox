Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268376AbTCCGHc>; Mon, 3 Mar 2003 01:07:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268377AbTCCGHc>; Mon, 3 Mar 2003 01:07:32 -0500
Received: from packet.digeo.com ([12.110.80.53]:49631 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S268376AbTCCGHb>;
	Mon, 3 Mar 2003 01:07:31 -0500
Date: Sun, 2 Mar 2003 22:18:06 -0800
From: Andrew Morton <akpm@digeo.com>
To: Dawson Engler <engler@csl.stanford.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [CHECKER] potential deadlocks
Message-Id: <20030302221806.59836766.akpm@digeo.com>
In-Reply-To: <200303030605.h2365oK08706@csl.stanford.edu>
References: <20030302212500.72fe9b87.akpm@digeo.com>
	<200303030605.h2365oK08706@csl.stanford.edu>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 03 Mar 2003 06:17:51.0656 (UTC) FILETIME=[9EBA2A80:01C2E14C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dawson Engler <engler@csl.stanford.edu> wrote:
>
> BTW, are there known deadlocks (harmless or otherwise)?  Debugging
> the checker is a bit hard since false negatives are silent...

Known deadlocks tend to get fixed.  But I am surprised that you did not
encounter more of them.

btw, the filesystem transaction operations can be treated as sleeping locks. 
So for ext3, journal_start()/journal_stop() may, for lock-ranking purposes,
be treated in the same way as taking and releasing a per-superblock
semaphore.  Other filesystems probably have similar restrictions.

Other such "hidden" sleeping locks are lock_sock() and wait_on_inode().  The
latter is rather messy because there is no clear API function which sets
I_LOCK.

And pte_chain_lock() is a custom spinlock.


