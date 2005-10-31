Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932301AbVJaPxc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932301AbVJaPxc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 10:53:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932289AbVJaPxc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 10:53:32 -0500
Received: from smtp.osdl.org ([65.172.181.4]:61130 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932282AbVJaPxb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 10:53:31 -0500
Date: Mon, 31 Oct 2005 07:53:20 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Jens Axboe <axboe@suse.de>
cc: Tejun Heo <htejun@gmail.com>, Arnaldo Carvalho de Melo <acme@mandriva.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH][noop-iosched] don't reuse a freed request
In-Reply-To: <20051031082354.GO19267@suse.de>
Message-ID: <Pine.LNX.4.64.0510310746340.27915@g5.osdl.org>
References: <20051031023024.GC5632@mandriva.com> <20051031074022.GN19267@suse.de>
 <4365D01D.2040406@gmail.com> <20051031082354.GO19267@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 31 Oct 2005, Jens Axboe wrote:
> 
> So either we disable merging for noop by setting REQ_NOMERGE in
> elevator_noop_add_request(), or we add a noop_list and do the
> dispatching like in the other io schedulers. I'd prefer the latter,
> merging is still beneficial for noop (and it has always done it).
> 
> For now, we should add the former.
> 
> Signed-off-by: Jens Axboe <axboe@suse.de>

Btw, Jens, I appreciate seeing the discussion history when applying a 
patch, but at the same time I do _not_ want to use it as a commit message, 
it's just too confusing and worthless in that context. 

And yet, your final comments don't much make sense without the background, 
so I can't just use them either.

So, I rewrote the explanation. Which is fine, but I wish people who sent 
patches would think more about what message they want to have in the 
commit logs, so that (a) Lazy-Linus doesn't have to write his own message 
and (b) so that the message is correct when Lazy-and-Stupid-Linus 
sometimes doesn't necessarily see/understand all the problems it fixes.

Btw, the email-patch-sending protocol still allows for putting all the 
ugly history in for my (and the mailing lists) pleasure: that's what the 
"---" marker after the explanation is for. So you can _both_ have a nice 
clean commit message _and_ give more of a historical background for the 
patch.

Anyway, in this case, the commit message ended up looking like this::

commit 581c1b14394aee60aff46ea67d05483261ed6527
Author: Jens Axboe <axboe@suse.de>
Date:   Mon Oct 31 09:23:54 2005 +0100

    [PATCH] noop-iosched: avoid corrupted request merging

    Tejun Heo notes:

       "I'm currently debugging this.  The problem is that we are using the
        generic dispatch queue directly in the noop sched and merging is NOT
        allowed on dispatch queues but generic handling of last_merge tries
        to merge requests.  I'm still trying to verify this, so I'll be back
        with results soon."

    In the meantime, disable merging for noop by setting REQ_NOMERGE in
    elevator_noop_add_request().

    Eventually, we should add a noop_list and do the dispatching like in the
    other io schedulers.  Merging is still beneficial for noop (and it has
    always done it).

    Signed-off-by: Jens Axboe <axboe@suse.de>
    Signed-off-by: Linus Torvalds <torvalds@osdl.org>

which is basically your email cleaned up and compressed into a readable 
commit message.

			Linus
