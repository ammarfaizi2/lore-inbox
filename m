Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263886AbTIICaU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 22:30:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263666AbTIICaU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 22:30:20 -0400
Received: from dp.samba.org ([66.70.73.150]:64223 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S263886AbTIICaO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 22:30:14 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Hugh Dickins <hugh@veritas.com>
Cc: Ulrich Drepper <drepper@redhat.com>, Jamie Lokier <jamie@shareable.org>,
       Andrew Morton <akpm@osdl.org>, Stephen Hemminger <shemminger@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Re: today's futex changes 
In-reply-to: Your message of "Mon, 08 Sep 2003 18:33:04 +0100."
             <Pine.LNX.4.44.0309081746180.7008-100000@localhost.localdomain> 
Date: Tue, 09 Sep 2003 11:37:08 +1000
Message-Id: <20030909023011.CD7122C22F@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.4.44.0309081746180.7008-100000@localhost.localdomain> you write:
> Most of it (the futex_wait tweaks) looked fine to me -
> though I look forward to the first report of that BUG().

Me too.  But at least we'll *get* a report if someone does spurious
wakeups.

> Part 2, requiring VM_WRITE and removing the comment on VM_MAYSHARE,
> seems a regression to me.  Perhaps I misinterpreted Linus' action in
> taking Jamie's patch: I took that to mean he relented a little on his
> hardline position about VM_SHARED, and now accepts that in this context
> VM_MAYSHARE is more appropriate (easier to document).  I know I argued
> that readonly futices are pointless, but I thought Jamie gave a good
> picture of how a readonly view could still be used.  I'd rather that
> part were a separate patch, so Linus can merge or not as he wishes.

Sure, I jumboed them together for feedback from you guys.

All users I am currently aware of won't care either way.  Current
test-5 is:

				Sees Changes		Sees FUTEX_WAKE
			   from another MAP_SHARED   from another MAP_SHARED

MAP_PRIVATE read-only:		Y			N
MAP_PRIVATE read-write:		Y*			N
MAP_SHARED read-only:		Y			Y
MAP_SHARED read-write:		Y			Y

[* Only until page is written to, after which COW splits them ]

Previously, the FUTEX_WAKE column was identical to the first column.
Now, IMHO, this new semantic is more sensible, but I don't really
mind.

But I don't recall anything about believable use of RO futexes: Jamie?

Cheers,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
