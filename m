Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277649AbRJIADX>; Mon, 8 Oct 2001 20:03:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277644AbRJIADP>; Mon, 8 Oct 2001 20:03:15 -0400
Received: from t2.redhat.com ([199.183.24.243]:9457 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S277649AbRJIADA>; Mon, 8 Oct 2001 20:03:00 -0400
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <Pine.LNX.4.33.0110081643230.1064-100000@penguin.transmeta.com> 
In-Reply-To: <Pine.LNX.4.33.0110081643230.1064-100000@penguin.transmeta.com> 
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Peter Rival <frival@zk3.dec.com>, paulus@samba.org,
        "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
        jay.estabrook@compaq.com, rth@twiddle.net
Subject: Re: [PATCH] change name of rep_nop 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 09 Oct 2001 01:03:22 +0100
Message-ID: <15753.1002585802@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


torvalds@transmeta.com said:
> There's no way we should implement "simon_says".
> There's a difference between stupiud hardware changing memory from
> under us through mapping tricks, and cache coherency in general.

True. Although for simplicity's sake I wasn't talking about the mapping 
tricks, this was just for writing/erasing flash chips without doing any 
paging - it you're mapping different chips into the same hole you need the 
same cache-flush tricks even for read-only chips.

> What you want is the "memory_went_away_from_us()" kind of cache flush,
> which has nothing at all to do with cache coherency. And it should be
> explicitly and clearly named THAT

As you wish. How about:

void memory_went_away_from_us(void);
 and
void memory_range_went_away_from_us(unsigned long start, unsigned long len);

Where 'start' is an ioremap cookie.

> and you should not blame the fact that x86 is always 100% cache coherent
> and that the normal cache coherency routines should _never_ be anything
> but a nop.

Indeed. That's eminently sane - it was just the nomenclature and the 
documentation which was less so.

> Also note that wbinvd is known to corrupted the caches and lead to
> lockups on certain x86 cores. You need to be a _lot_ more careful than
> just doing it indiscriminately from a driver.

Yeah - but x86 isn't a particularly interesting architecture in this
context. If you can't selectively flush a range, you'll probably find that
you haven't gained enough from being able to do burst reads to offset the
cost of the complete cache flushes.

--
dwmw2


