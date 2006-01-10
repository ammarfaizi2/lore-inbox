Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932069AbWAJGYe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932069AbWAJGYe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 01:24:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932074AbWAJGYd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 01:24:33 -0500
Received: from 217-133-42-200.b2b.tiscali.it ([217.133.42.200]:1109 "EHLO
	opteron.random") by vger.kernel.org with ESMTP id S932069AbWAJGYd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 01:24:33 -0500
Date: Tue, 10 Jan 2006 07:24:25 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, hugh@veritas.com
Subject: Re: smp race fix between invalidate_inode_pages* and do_no_page
Message-ID: <20060110062425.GA15897@opteron.random>
References: <20051213193735.GE3092@opteron.random> <20051213130227.2efac51e.akpm@osdl.org> <20051213211441.GH3092@opteron.random> <20051216135147.GV5270@opteron.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051216135147.GV5270@opteron.random>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 16, 2005 at 02:51:47PM +0100, Andrea Arcangeli wrote:
> There was a minor buglet in the previous patch an update is here:
> 
> 	http://www.kernel.org/pub/linux/kernel/people/andrea/patches/v2.6/2.6.15-rc5/seqschedlock-2

JFYI: I got a few hours ago positive confirmation of the fix from the
customer that was capable of reproducing this. I guess this is good
enough for production use (it's at the very least certainly better than
the previous code and it's guaranteed not to hurt the scalability of the
fast path in smp, so it's the least intrusive fix I could imagine).

So we can start to think if we should using this new primitive I
created, and if to replace the yield() with a proper waitqueue (and
how). Or if to take the risk of hitting a bit of scalability in the
nopage page faults of processes, by rewriting the fix with a
find_lock_page in the do_no_page handler, that would avoid the need of
my new locking primitive.

Comments welcome thanks!
