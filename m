Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262286AbUDAFFu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 00:05:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262274AbUDAFFu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 00:05:50 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:49367 "EHLO
	MTVMIME02.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S262286AbUDAFFp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 00:05:45 -0500
Date: Thu, 1 Apr 2004 06:05:47 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrea Arcangeli <andrea@suse.de>
cc: Andrew Morton <akpm@osdl.org>, <vrajesh@umich.edu>,
       <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: Re: [RFC][PATCH 1/3] radix priority search tree - objrmap complexity
    fix
In-Reply-To: <20040401020126.GW2143@dualathlon.random>
Message-ID: <Pine.LNX.4.44.0404010549540.28566-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Apr 2004, Andrea Arcangeli wrote:
> On Wed, Mar 31, 2004 at 05:51:13PM -0800, Andrew Morton wrote:
> > rw_swap_page_sync() is a general-purpose library function and we shouldn't
> > be making assumptions about the type of page which the caller happens to be
> > feeding us.
> 
> that is a specialized backdoor to do I/O on _private_ pages, it's not a
> general-purpose library function for doing anonymous pages

I'm not against anal checks (except personally :), but I'm very much
with Andrea on this: rw_swap_page_sync is horrid, but does manage to
do a particular job.  The header page is great fun: sys_swapon and
mkswap read and write it by a totally different route, I shudder
(especially when it's a swapfile with blocksize less than pagesize).
It would be nice to make it more general and correct, but that's
not something you should get stuck on right now.

Hugh

