Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262520AbTESPFx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 11:05:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262523AbTESPFx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 11:05:53 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:59909 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S262520AbTESPFw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 11:05:52 -0400
Date: Mon, 19 May 2003 08:18:19 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Ingo Molnar <mingo@elte.hu>
cc: Christoph Hellwig <hch@infradead.org>, <linux-kernel@vger.kernel.org>,
       Rusty Russell <rusty@rustcorp.com.au>,
       Ulrich Drepper <drepper@redhat.com>
Subject: Re: [patch] futex API cleanups, futex-api-cleanup-2.5.69-A2
In-Reply-To: <Pine.LNX.4.44.0305191351570.9877-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0305190814300.16317-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 19 May 2003, Ingo Molnar wrote:
> 
>  - start the phasing out of FUTEX_FD. This i believe is quite unclean and
>    unrobust, because it attaches a new concept (futexes) to a very old
>    (polling) concept. We want futex support in kernel-AIO, not in the
>    polling APIs. AFAIK only NGPT uses FUTEX_FD.

This sounds like a bad idea. 

Expecting "select()" and "poll()" to go away, and calling them "unclean
and unrobust" is just silly and stupid. There are a hell of a lot more 
programs using select-loops out there than there are AIO versions, and I'd 
argue that AIO is likely to be the much more "unrobust" solution, and 
probably doesn't even scale any better than using epoll.

In fact, it's hard to see any real advantages of aio over a sane polling
loop, as long as the polling doesn't have some O(n) overhead (in other
words, as long as you use epoll).

So stop pushing your own agenda and broken morals down other peoples 
throats, and re-do this patch properly.

		Linus


