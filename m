Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261530AbTAaQBe>; Fri, 31 Jan 2003 11:01:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261581AbTAaQBe>; Fri, 31 Jan 2003 11:01:34 -0500
Received: from [195.223.140.107] ([195.223.140.107]:3200 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S261530AbTAaQBd>;
	Fri, 31 Jan 2003 11:01:33 -0500
Date: Fri, 31 Jan 2003 17:11:02 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.21pre4aa1
Message-ID: <20030131161102.GE8395@dualathlon.random>
References: <20030131014020.GA8395@dualathlon.random> <20030131105643.B18876@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030131105643.B18876@infradead.org>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 31, 2003 at 10:56:43AM +0000, Christoph Hellwig wrote:
> On Fri, Jan 31, 2003 at 02:40:20AM +0100, Andrea Arcangeli wrote:
> > Only in 2.4.21pre3aa1: 00_getcwd-err-1
> > Only in 2.4.21pre4aa1: 00_getcwd-err-2
> > 
> > 	Part of it merged in mainline.
> 
> A different, cleaner version has been merged in mainline.  00_getcwd-err-2
> just adds unreachable code.

Ok agreed, it's a noop, I'll drop it. It won't hurt in the meantime.

> 
> > Only in 2.4.21pre4aa1: 9996_kiobuf-slab-1
> > 
> > 	Keep the kiobuf + bhs cache in the slab rather than in the file
> > 	structure, so it scales also while sharing the same file from two
> > 	different filedescriptors at the same time (like with threads or
> > 	after forks). From Jun Nakajima.
> 
> The patch is ugly as hell.  I'll dig up the patch I did with similar

I don't think it's so ugly, infact it's very clever compared to the
previous code, the big hit for the kiobuf is the bh allocation and this
solves it moving the bh into the slab too.

> functionality but a much nicer style and a sysctl-controllable cut-off

sysctl-controllable? I don't like it. This one should perform well
always.

> point for keeping the bhs around in the constructed kiobuf objects.

Feel free to provide a replacement but I don't see how you can make it
that much better as you claim.

The only unclean bit is the initialized field probably, but that's not a
significant cost and it's probably the simpler way to deal with the
ctor failures.

Andrea
