Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129855AbRCTGiO>; Tue, 20 Mar 2001 01:38:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130013AbRCTGhy>; Tue, 20 Mar 2001 01:37:54 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:53514 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129740AbRCTGhq>; Tue, 20 Mar 2001 01:37:46 -0500
Date: Mon, 19 Mar 2001 22:36:41 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
cc: Rik van Riel <riel@conectiva.com.br>, Mike Galbraith <mikeg@wen-online.de>,
        <linux-mm@kvack.org>, lkml <linux-kernel@vger.kernel.org>,
        Manfred Spraul <manfred@colorfullife.com>,
        MOLNAR Ingo <mingo@chiara.elte.hu>
Subject: Re: 3rd version of R/W mmap_sem patch available
In-Reply-To: <Pine.LNX.4.21.0103200125480.8873-100000@freak.distro.conectiva>
Message-ID: <Pine.LNX.4.31.0103192233230.1056-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 20 Mar 2001, Marcelo Tosatti wrote:
>
> I'll put pre5 in and try to reproduce the problem (I hitted it while
> running pgbench + shmtest).

I found a case where pre5 will forget to unlock the page_table_lock (in
copy_page_range()), and one place where I had missed the lock altogether
(in ioremap()), so I'll make a pre6 (neither is a problem on UP, though,
so pre5 is not unusable - even on SMP it works really well until you hit
the case where it forgets to unlock ;).

Although I'd prefer to see somebody check out the other architectures, to
do the (pretty trivial) changes to make them support properly threaded
page faults. I'd hate to have two pre-patches without any input from other
architectures..

		Linus

