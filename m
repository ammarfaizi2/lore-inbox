Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263615AbTDGT3V (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 15:29:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263614AbTDGT3T (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 15:29:19 -0400
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:19885 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S263612AbTDGT3L (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 7 Apr 2003 15:29:11 -0400
Date: Mon, 7 Apr 2003 21:40:39 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
Subject: Re: [ANNOUNCE] New kernel tree for embedded linux
Message-ID: <20030407194039.GF8178@wohnheim.fh-wedel.de>
References: <20030407171037.GB8178@wohnheim.fh-wedel.de.suse.lists.linux.kernel> <p73r88exh3r.fsf@oldwotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <p73r88exh3r.fsf@oldwotan.suse.de>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

X-posted to mtd. A lot of embedded people lurk there.

On Mon, 7 April 2003 21:06:16 +0200, Andi Kleen wrote:
> Jörn Engel <joern@wohnheim.fh-wedel.de> writes:
> 
> > The RATIONALE is that on a ppc with some flash, memory, network and
> > nothing much else, I don't feel like parsing MS-DOS partitions,
> > offering IPX networking etc., but that junk is still included in
> > 2.[45].current - unconditionally. And there is more...
> 
> Both dos partitions and IPX are already CONFIG_* options. As "conditional" 
> as you can get. 

DOS is always included, unless you are on a very short list (amiga,
atari, mac, sgi_this, sgi_that). Not a complicated fix, I agree.

You are correct about IPX, but 802.3 is always included, afaics never
used and the first comment in the code sais, only used by IPX. Again,
quite simple.

Some more partitioning code that only applies to spinning discs of
some sort (ide, scsi) or code that emulates spinning discs is always
included. No config option.

The list goes on, but these were the lowest hanging fruits I could
see.

> If you want to reduce memory bloat I would start with shrinking the
> dynamic sized hashtables. That will likely give you several hundred KB
> depending on the memory size, much more than you could get from
> code size reductions.

Ok, I will look into this. Do you have a quick pointer or two to start
with?

> Another obvious candidate for memory reduction would be mem_map
> (struct page). If you accept some total memory size limit (256MB
> with 4k pages) you could replace next_hash and pprev_hash with an
> 16bit index into mem_map and save 8 bytes per 4k of memory. Possible even 
> fold count into flags and save another 4 bytes per 4k of memory
> For 256MB of memory this would be 768k. That's more than a stripped
> down kernel has code in total.

1. Things matter less, if you already have 256MB. My focus is on
2-32MB machines, both flash and memory, where O(1) saving do make a
difference.
2. My kernels have little less than 2M uncompressed or 700k
compressed. The platform is not *that* embedded, bit things should
still go down.

3. Thanks for the pointer. I'll look into that.

> Probably more could be saved by attacking other bloated data structures
> in the kernel.
> 
> Really there are many targets that have bigger potential pay off 
> than just code shrinking.

Yes, I agree. See ps:.

> If you want to shrink code:
> 
> The TCP/IP stack could be also put on a diet. You likely don't need
> an backbone router class routing table manager in your embedded
> system. The code is already modularized enough that it could be 
> replaced with a simple "client" implementation using linked 
> lists for routing tables with minor changes.
> Unfortunately developing it is still quite some work.

Good hint. Thank you!

Another one is serial.c. In an ltp test run, plus serial console, some
90% were unused. And the code gave me some shivers. Volunteers?

Jörn

PS: The *real* rationale behind this is my view of embedded
development:
1. Take what's availlable.
2. Make things work.
3. Ship to customer.
4. nothing

Most other developers send patches and collaborate somehow. For
embedded this rarely happens. (It does a little, not all is black.)

So I wanted to create a focal point for the embedded developers and
see if I get something back for my work. I had to start with
something, three simple patches is not much. But if my hopes become
reality, it will grow. And I really suspect that a lot of the patches
done in step 2 could be generalized.

Your hints were already more valuable than my work investments so far.
Thank you!

-- 
My second remark is that our intellectual powers are rather geared to
master static relations and that our powers to visualize processes
evolving in time are relatively poorly developed.
-- Edsger W. Dijkstra
