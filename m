Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312579AbSDAUBG>; Mon, 1 Apr 2002 15:01:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312581AbSDAUA6>; Mon, 1 Apr 2002 15:00:58 -0500
Received: from www.wen-online.de ([212.223.88.39]:8467 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S312579AbSDAUAs>;
	Mon, 1 Apr 2002 15:00:48 -0500
Date: Mon, 1 Apr 2002 21:02:43 +0200 (CEST)
From: Mike Galbraith <mikeg@wen-online.de>
To: Andrea Arcangeli <andrea@suse.de>
cc: Andrew Morton <akpm@zip.com.au>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: -aa VM splitup
In-Reply-To: <20020401200202.Q1331@dualathlon.random>
Message-ID: <Pine.LNX.4.10.10204012036030.283-100000@mikeg.wen-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Apr 2002, Andrea Arcangeli wrote:

> comparing 2.4 with 2.5 is a bit unfair, can you try 2.4.19pre5aa1
> first? Note that you didn't applied all the vm patches, infact I've no
> idea how they apply to 2.5 in the first place (I assume they applied
> cleanly).

Sure, I'll give 2.4.19pre5aa1 a go.  The patches didn't go in clean,
but the changes made since the split weren't too big to easily plug
them in.  (I only applied the patches which looked interesting for my
little UP box)

I was comparing the old 2.4 kernel to 2.5 because of a loss in write
throughput which I've been tracking for a while, and hoped to get back
via aa after reading some bits.

> Also it would be interesting to know how much memory you have in use
> before starting the benchmark, it maybe you're triggering some swap

Mostly empty, but that doesn't matter much.. see below.

> because the VM understand lots of your mappings are unused and that
> so you're swapping out during the I/O benchmark because of that. the
> anon pages in the lru are meant exactly for that purpose. If you want a
> vm that never ever swaps during an I/O benchmark all mapped pages should
> not be considered by the vm until we run out of unmapped pages, it's
> quite equivalent to raising vm_mapped_ratio to 10000, you can try with
> vm_mapped_ratio set to 10000 too infact.

I don't mind if my box swaps a bit when stressed.  In fact, I like it
to go find bored pages and get them out of the way :)

It's the buffer.c changes (the ones I'm most interested in:) that are
causing my disk woes.  They look like they're in right, but are causing
bad (synchronous) IO behavior for some reason.  I have tomorrow yet to
figure it out.

	-Mike

