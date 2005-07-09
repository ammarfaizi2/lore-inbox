Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262928AbVGHX7B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262928AbVGHX7B (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 19:59:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262969AbVGHX7B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 19:59:01 -0400
Received: from gold.veritas.com ([143.127.12.110]:39101 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S262928AbVGHX7A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 19:59:00 -0400
Date: Sat, 9 Jul 2005 01:00:21 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH 00/13] some swapfile patches
Message-ID: <Pine.LNX.4.61.0507090057340.13391@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 08 Jul 2005 23:58:59.0757 (UTC) FILETIME=[024CE5D0:01C58419]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here comes a series of 13 swap patches, mainly to mm/swapfile.c, based
on 2.6.13-rc2-mm1 but applying also to 2.6.13-rc2.  I don't think any
of them are important enough for 2.6.13, though the first half are
straightforward.  The main thrust is to scan the swap_map lockless,
to stop the infamous latency in get_swap_page.  But they keep to the
familiar swap allocation algorithm, so no change to macro-latency.

 Documentation/vm/locking |   15 -
 include/linux/swap.h     |   22 --
 kernel/power/swsusp.c    |   12 -
 mm/filemap.c             |    7 
 mm/rmap.c                |    3 
 mm/swapfile.c            |  410 +++++++++++++++++++++++++----------------------
 6 files changed, 246 insertions(+), 223 deletions(-)

Strictly, arch/m68k/atari/stram.c should also be in that list.
But CONFIG_STRAM_SWAP is under CONFIG_BROKEN, and its reference to
swap_vfsmnt implies it hasn't been built since 2.5.1.  Time again to
cajole the m68k people into removing that code - if the mtd driver
doesn't already satisfy their need in a much better way, it cannot
be far off (need? hardly, if unbuilt in 3.5 years).

Hugh
