Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316455AbSEUAPc>; Mon, 20 May 2002 20:15:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316458AbSEUAPb>; Mon, 20 May 2002 20:15:31 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:41164 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S316455AbSEUAPa>;
	Mon, 20 May 2002 20:15:30 -0400
Date: Mon, 20 May 2002 17:14:24 -0700
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Andrea Arcangeli <andrea@suse.de>, Rik van Riel <riel@conectiva.com.br>
cc: Andrew Morton <akpm@zip.com.au>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Bug with shared memory.
Message-ID: <262840000.1021940064@flay>
In-Reply-To: <20020520234622.GL21806@dualathlon.random>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> For the memclass_related_bhs() fix in -aa, that's in the testing TODO
> list of Martin (on the multi giga machines), he also nicely proposed to
> compare it to the other throw-away-all-bh-regardless patch from Andrew
> (that I actually didn't seen floating around yet but it's clear how it
> works, it's a subset of memclass_related_bhs). However the right way to
> test the memclass_related_bhs vs throw-away-all-bh, is to run a rewrite
> test that fits in cache, so write,fsync,write,fsync,write,fsync. specweb
> or any other read-only test will obviously perform exactly the same both
> ways (actually theoretically a bit cpu-faster in throw-away-all-bh
> because it doesn't check the bh list).

The only thing that worries me in theory about your approach for this
Andrea is fragmentation - if we try to shrink only when we're low on
memory, isn't there a danger that one buffer_head per page of slab
cache will be in use, and thus no pages are freeable (obviously this
is extreme, but I can certainly see a situation with lots of partially used
pages)? 

With Andrew's approach, keeping things freed as we go, we should
reuse the partially allocated slab pages, which would seem (to me)
to result in less fragmentation?

Thanks,

M.

