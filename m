Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273968AbRISMgv>; Wed, 19 Sep 2001 08:36:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274040AbRISMgm>; Wed, 19 Sep 2001 08:36:42 -0400
Received: from bacchus.veritas.com ([204.177.156.37]:3218 "EHLO
	bacchus-int.veritas.com") by vger.kernel.org with ESMTP
	id <S273968AbRISMg1>; Wed, 19 Sep 2001 08:36:27 -0400
Date: Wed, 19 Sep 2001 13:37:48 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
To: Andrew Morton <akpm@zip.com.au>
cc: Andrea Arcangeli <andrea@suse.de>,
        Stephan von Krawczynski <skraw@ithnet.com>, jogi@planetzork.ping.de,
        linux-kernel@vger.kernel.org
Subject: Re: 2.4.10-pre11: alsaplayer skiping during kernel build (-pre10
 did  not)
In-Reply-To: <3BA7A853.4EC44195@zip.com.au>
Message-ID: <Pine.LNX.4.21.0109191330270.1489-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Sep 2001, Andrew Morton wrote:
> 
> With the above fixed, the main source of latency is
> /proc/meminfo->si_swapinfo(). It's about five milliseconds per gig
> of swap, which isn't too bad.  But it's directly invokable by
> userspace (ie: /usr/bin/top) and really should be made less dumb.

Don't worry about this one, fix is included in patch I posted last
Saturday, and will be rebasing, breaking up and submitting to Linus
in a couple(?) of days.  Basically, Zach Brown's patch to use
nr_swap_pages and total_swap_pages, but in rare case of concurrent
swapoff, does need to scan that swap_map (with appropriate locking)
to give sensible numbers without strange negatives at that time.

Hugh

