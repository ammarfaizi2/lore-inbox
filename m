Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129406AbRBTRLt>; Tue, 20 Feb 2001 12:11:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130114AbRBTRLj>; Tue, 20 Feb 2001 12:11:39 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:19985 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129406AbRBTRLZ>; Tue, 20 Feb 2001 12:11:25 -0500
Date: Tue, 20 Feb 2001 09:11:04 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andrea Arcangeli <andrea@suse.de>
cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: __lock_page calls run_task_queue(&tq_disk) unecessarily?
In-Reply-To: <20010220170000.J26544@athlon.random>
Message-ID: <Pine.LNX.4.10.10102200909350.30652-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 20 Feb 2001, Andrea Arcangeli wrote:
> 
> Looks perfect. I'd also remove the `continue' from __lock_page, it's wake-one
> so it should get the wakeup only when it's time to lock the page down.

NO!

Even if it is wake-one, others may have claimed it before. There can be
new users coming in and doing a "trylock()" etc.

NEVER *EVER* think that "exclusive wait-queue" implies some sort of
critical region protection. An exlcusive wait-queue is _not_ a lock. It's
only an optimization heuristic.

		Linus

