Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279797AbRKAV37>; Thu, 1 Nov 2001 16:29:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279790AbRKAV3s>; Thu, 1 Nov 2001 16:29:48 -0500
Received: from roc-24-169-102-121.rochester.rr.com ([24.169.102.121]:30337
	"EHLO roc-24-169-102-121.rochester.rr.com") by vger.kernel.org
	with ESMTP id <S279796AbRKAV3d>; Thu, 1 Nov 2001 16:29:33 -0500
Date: Thu, 01 Nov 2001 16:28:44 -0500
From: Chris Mason <mason@suse.com>
To: Andrew Morton <akpm@zip.com.au>, Neil Brown <neilb@cse.unsw.edu.au>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrea Arcangeli <andrea@suse.de>
Subject: Re: 2.4.14-pre6
Message-ID: <334750000.1004650124@tiny>
In-Reply-To: <3BE1B6CD.7DA43A6C@zip.com.au>
In-Reply-To: message from Linus Torvalds on Wednesday October
 31,	<Pine.LNX.4.33.0110310809200.32460-100000@penguin.transmeta.com>
 <15329.8658.642254.284398@notabene.cse.unsw.edu.au>
 <3BE1B6CD.7DA43A6C@zip.com.au>
X-Mailer: Mulberry/2.1.0 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thursday, November 01, 2001 12:55:41 PM -0800 Andrew Morton
<akpm@zip.com.au> wrote:

> Oh.  I have a gripe concerning prune_icache().  The design
> idea behind keventd is that it's a "process context bottom
> half handler".  It's used for things like cardbus hotplug
> interrupt handlers, handling tty hangups, etc.  It should
> probably run SCHED_FIFO.
> 
> Using keventd to synchronously flush large amounts of 
> data out to disk constitutes gross abuse - it's being blocked
> from performing its designed duties for many seconds.  Can we
> please not do that?  We already have kswapd, kupdate, bdflush,
> which should be sufficient.

One of the worst parts of prune_icache was that if a journaled
FS needed to log dirty inodes, kswapd would wait on the log, who was
probably waiting on kswapd.  Thus the dirty_inode call, which I'd like to
get rid of.

I don't think kupdate or bdflush are suitable to flush the dirty inodes,
kupdate shouldn't do memory pressure and bdflush shouldn't wait on the log.
So how about a new kinoded?

-chris

