Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261456AbTBSVHm>; Wed, 19 Feb 2003 16:07:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261463AbTBSVHm>; Wed, 19 Feb 2003 16:07:42 -0500
Received: from rth.ninka.net ([216.101.162.244]:2465 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id <S261456AbTBSVHl>;
	Wed, 19 Feb 2003 16:07:41 -0500
Subject: Re: [PATCH] add new DMA_ADDR_T_SIZE define
From: "David S. Miller" <davem@redhat.com>
To: Ion Badulescu <ionut@badula.org>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0302191050290.29393-100000@guppy.limebrokerage.com>
References: <Pine.LNX.4.44.0302191050290.29393-100000@guppy.limebrokerage.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 19 Feb 2003 14:01:58 -0800
Message-Id: <1045692118.14268.3.camel@rth.ninka.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-02-19 at 08:26, Ion Badulescu wrote:
> This patch adds a new preprocessor define called DMA_ADDR_T_SIZE for all 
> architectures, for the benefit of those drivers who care about its size 
> (and yes, starfire is one of them).

I don't think you are making things any better by adding
a new ifdef to all the drivers.

> 2. always cast it to u64, which adds unnecessary overhead to 32-bit 
> platforms.

Not to HIGHMEM ones.  And frankly, trying to super-optimize a driver
because it has two different descriptor format is a mess you as a driver
author choose to get involved in.

Nearly all cards today are 64-bit DMA address descriptors only.
So if anything, this new ifdef will get less and less used over
time.

> 3. use run-time checks all over the place, of the 
> "sizeof(dma_addr_t)==sizeof(u64)" kind, which adds unnecessary overhead to 
> all platforms.

The compiler optimizes this completely away, it becomes
a compile time test and the unused code block and the test
never make it into the assembler.

So this argument is bogus, as is the define.


