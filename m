Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131737AbRCUUGb>; Wed, 21 Mar 2001 15:06:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131747AbRCUUGV>; Wed, 21 Mar 2001 15:06:21 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:46608 "HELO
	postfix.conectiva.com.br") by vger.kernel.org with SMTP
	id <S131737AbRCUUGI>; Wed, 21 Mar 2001 15:06:08 -0500
Date: Wed, 21 Mar 2001 16:54:48 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
To: Jan Harkes <jaharkes@cs.cmu.edu>
Cc: Josh Grebe <squash@primary.net>, linux-kernel@vger.kernel.org,
        Manfred Spraul <manfred@colorfullife.com>
Subject: Re: Question about memory usage in 2.4 vs 2.2
In-Reply-To: <20010321141626.A3621@cs.cmu.edu>
Message-ID: <Pine.LNX.4.21.0103211652270.9056-100000@imladris.rielhome.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Mar 2001, Jan Harkes wrote:

> I've been thinking about this a bit and one possible solution would be
> to significantly lower the cost of prune_icache by removing the
> sync_all_inodes and only let it prune inodes that do not have any
> mappings associated with them. Then it might become possible to call
> it more frequently, like every time we hit do_try_free_pages.

Marcelo and me have been looking at this issue too, and have
come to almost the same conclusion as you, with one small
change.

We -need- to have a way to trigger the writeout of dirty
inodes under memory pressure. Imagine doing 'chown -R' on
a huge tree on a low-memory box; you'd end up with zillions
of dirty inodes in memory with no way to free them.

Now if prune_icache would write all the dirty inodes without
data pages to disk automatically, we'd have this issue fixed
and we'll be able to make a much more efficient prune_icache.

Anybody willing to give it a shot ?

regards,

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com.br/

