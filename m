Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263039AbUJ1SWt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263039AbUJ1SWt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 14:22:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263046AbUJ1SWs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 14:22:48 -0400
Received: from [66.35.79.110] ([66.35.79.110]:30600 "EHLO www.hockin.org")
	by vger.kernel.org with ESMTP id S263039AbUJ1SVL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 14:21:11 -0400
Date: Thu, 28 Oct 2004 11:21:09 -0700
From: Tim Hockin <thockin@hockin.org>
To: linux-kernel@vger.kernel.org
Subject: Re: Max groups one can be a member of linux/sched.h and NGROUPS_SMALL
Message-ID: <20041028182109.GA29258@hockin.org>
References: <20041028180230.GD10255@digitasaru.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041028180230.GD10255@digitasaru.net>
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 28, 2004 at 01:02:30PM -0500, Joseph Pingenot wrote:
> #define NGROUPS_SMALL           32
> #define NGROUPS_PER_BLOCK       ((int)(PAGE_SIZE / sizeof(gid_t)))
> struct group_info {
>         int ngroups;
>         atomic_t usage;
>         gid_t small_block[NGROUPS_SMALL];
>         int nblocks;
>         gid_t *blocks[0];
> };

> So, it appears to hold 32 gids, but what is this blocks bit?  Is 32 the max
>   number of groups one can be a member of?

By default, every task has enough room for 32 gids.  If you need more than
32, it uses a dynamically allocated 2-d array, stored in blocks.  Always
use the GROUP_AT() macro, and you can treat it like a 1-d array.  I think
there is a hardlimit of 64k groups, but that is simply a #define that can
be changed.  You can have as many groups as you need, dynamically
allocated per-task, with CoW between tasks.  Sorted and bsearch()ed.
