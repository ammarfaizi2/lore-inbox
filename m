Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283626AbRK3Lc0>; Fri, 30 Nov 2001 06:32:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283622AbRK3LcQ>; Fri, 30 Nov 2001 06:32:16 -0500
Received: from dsl-213-023-038-163.arcor-ip.net ([213.23.38.163]:13583 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S283625AbRK3LcE>;
	Fri, 30 Nov 2001 06:32:04 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Linus Torvalds <torvalds@transmeta.com>,
        Jeff Garzik <jgarzik@mandrakesoft.com>
Subject: Re: Block I/O Enchancements, 2.5.1-pre2
Date: Fri, 30 Nov 2001 03:19:09 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Jens Axboe <axboe@suse.de>, <linux-kernel@vger.kernel.org>,
        <jmerkey@timpanogas.org>
In-Reply-To: <Pine.LNX.4.33.0111271933100.1195-100000@penguin.transmeta.com>
In-Reply-To: <Pine.LNX.4.33.0111271933100.1195-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E169dGg-0000iO-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On November 28, 2001 04:38 am, Linus Torvalds wrote:
> We will probably _not_ get 64-bit page index numbers, though. I don't want
> to make the page structure bigger/slower for very little gain. So the page
> cache is probably going to be limited to about 44 bits (45+ if people
> start doing large pages, which is probably worth it). So there would still
> be partition/file limits on the order of 16-64 TB in the next few years.

The Ext2+ crowd is actively working on preparing for the world of larger 
blocks, so that 64KB blocks will be entirely practical.  This will get us to 
1/4 Petabyte, still with 32 bit block pointers internally.  The main problem 
that has to be solved is internal fragmentation.

Going beyond 64KB blocks with mimimal changes is possible too, basically just 
working around the 16 bit pointers in directory blocks.  However, it's not 
clear it's a pressing need.

> (In a longer timeframe, assuming RAM keeps getting cheaper and cheaper,
> and 64-bit computing starts hppening on PC's, a few years down the line we
> can re-visit this - that particular transition is not going to be too
> painful).
>
> And yes, I realize that you can already build big arrays and use LVM etc
> to make them be more than 16TB. I just do not think it's a problem yet,
> and I'd rather cater to "normal" people than to peopel who can't bother
> to partition their data at all.

Right, there's still a lot more scalability to be squeezed out of good old 32 
bits.  If we do run out of something it's likely to be the 32 bits of inodes, 
after all, who can get by on a mere 4 billion files these days?

--
Daniel
