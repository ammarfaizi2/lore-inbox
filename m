Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266443AbTBTS2q>; Thu, 20 Feb 2003 13:28:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266540AbTBTS2q>; Thu, 20 Feb 2003 13:28:46 -0500
Received: from packet.digeo.com ([12.110.80.53]:58513 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S266443AbTBTS2o>;
	Thu, 20 Feb 2003 13:28:44 -0500
Date: Thu, 20 Feb 2003 10:40:17 -0800
From: Andrew Morton <akpm@digeo.com>
To: Hugh Dickins <hugh@veritas.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] umount versus iprune
Message-Id: <20030220104017.7f1981be.akpm@digeo.com>
In-Reply-To: <Pine.LNX.4.44.0302201337110.1623-100000@localhost.localdomain>
References: <Pine.LNX.4.44.0302201337110.1623-100000@localhost.localdomain>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 20 Feb 2003 18:38:43.0986 (UTC) FILETIME=[4BD62F20:01C2D90F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins <hugh@veritas.com> wrote:
>
> When prune_icache coincides with unmounting, invalidate_inodes notices
> the inode it's working on as busy but doesn't wait: Self-destruct in 5
> seconds message, and later iput oopses on freed super_block.
> 
> Neither end is a fast path, so patch below just adds iprune_sem for
> exclusion: if you've got a neater solution, great - I shied away from
> games with i_state, and extending use of shrinker_sem felt like abuse.
> 

Sounds reasonable.  The semaphore will block kswapd, but the reason kswapd
is being blocked is so that someone else can free tons of memory, so shrug.

Is 2.4 affected?


