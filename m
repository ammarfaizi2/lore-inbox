Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263919AbTIIEEH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 00:04:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263933AbTIIEEH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 00:04:07 -0400
Received: from dp.samba.org ([66.70.73.150]:46788 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S263919AbTIIEEF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 00:04:05 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Jamie Lokier <jamie@shareable.org>, Rusty Russell <rusty@rustcorp.com.au>,
       Hugh Dickins <hugh@veritas.com>, Ulrich Drepper <drepper@redhat.com>,
       Andrew Morton <akpm@osdl.org>, Stephen Hemminger <shemminger@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Make futex waiters take an mm or inode reference 
In-reply-to: Your message of "Mon, 08 Sep 2003 11:52:07 MST."
             <Pine.LNX.4.44.0309081144390.3202-100000@home.osdl.org> 
Date: Tue, 09 Sep 2003 14:02:15 +1000
Message-Id: <20030909040403.B97352C0F0@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.4.44.0309081144390.3202-100000@home.osdl.org> you write:
> So is there any reason to really having "private.mm" AT ALL? From what I
> can tell, it is not actually ever used (all "mm" users are "current->mm"),
> so I don't see the point of incrementing a count for it either.
> 
> Or did I miss something?

Yes.  Firstly, you can't do "wake one" if the one you wake might be
some completely unrelated process which happens to use the same
address.  Secondly, I implemented fair futexes by relying on the
return value of FUTEX_WAKE to indicate how many people were woken: you
set the futex to a magic value, call FUTEX_WAKE(1), and if it returns
1, you've "passed" the futex directly, otherwise you unlock the futex
like normal.  This is surprisingly useful for implementing
"drop_futex_if_someone_is_waiting()" in cleanup threads etc.

Sorry,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
