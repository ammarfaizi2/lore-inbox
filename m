Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262398AbUDKQKJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Apr 2004 12:10:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262399AbUDKQKJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Apr 2004 12:10:09 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:29224 "EHLO
	MTVMIME01.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S262398AbUDKQKB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Apr 2004 12:10:01 -0400
Date: Sun, 11 Apr 2004 17:09:57 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: "Martin J. Bligh" <mbligh@aracnet.com>
cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Rajesh Venkatasubramanian <vrajesh@umich.edu>
Subject: Re: [PATCH] anobjrmap 9 priority mjb tree
In-Reply-To: <5220000.1081551411@[10.10.2.4]>
Message-ID: <Pine.LNX.4.44.0404111650410.2008-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Apr 2004, Martin J. Bligh wrote:
> >> This slows down kernel compile a little, but worse, it slows down SDET
> >> by about 25% (on the 16x). I think you did something horrible to sem
> >> contention ... presumably i_shared_sem, which SDET was fighting with
> >> as it was anyway ;-(
> >> 
> >> Diffprofile shows:
> >> 
> >>     122626    15.7% total
> >>      44129   790.0% __down
> >>      20988     4.1% default_idle
> 
> I applied Andrew's high sophisticated proprietary semtrace technology.

Thanks a lot, Martin, this seems pretty important.

So, i_shared_sem, as you supposed.

Do you still have the two profiles input to diffprofile?
I wonder if they'd have clues to help us understand it better.

Any chance of you doing the same comparison between 2.6.5-aa5 
2.6.5-aa5 minus prio-tree?  (Well, needn't be -aa5, whatever comes to
hand.  Looks like "patch -p1 -R < prio-tree" mostly works, just some
rejects in mm/mmap.c itself, let me know if I can help out on that.)

If -aa is okay, I hope so, then it's surely some stupidity from me.

We're not at all surprised that vma linking and unlinking should take
rather longer; but the rise in __down, __wake_up, finish_task_switch
is horrifying.  Or is that how it usually looks, when a semaphore is
well contended - thundering herd?

Hugh

