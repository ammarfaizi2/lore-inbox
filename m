Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272549AbRJJBS1>; Tue, 9 Oct 2001 21:18:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271995AbRJJBSR>; Tue, 9 Oct 2001 21:18:17 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:39698 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S272549AbRJJBSI>; Tue, 9 Oct 2001 21:18:08 -0400
Date: Wed, 10 Oct 2001 03:18:03 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: safemode <safemode@speakeasy.net>
Cc: Robert Love <rml@ufl.edu>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.10-ac10-preempt lmbench output.
Message-ID: <20011010031803.F8384@athlon.random>
In-Reply-To: <20011010003636Z271005-760+23005@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011010003636Z271005-760+23005@vger.kernel.org>; from safemode@speakeasy.net on Tue, Oct 09, 2001 at 08:36:56PM -0400
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 09, 2001 at 08:36:56PM -0400, safemode wrote:
> mp3 player to skip, though.   That probably wont be fixed intil 2.5, since 
> you need to have preemption in the vm and the rest of the kernel.  

xmms skips during I/O should have nothing to do with preemption.

As Alan noted for the ring of dma fragments to expire you need a
scheduler latency of the order of seconds, now (assuming the ll points
in read/write paths) when we've bad latencies under writes it's of the
order of 10msec and it can be turned down further by putting preemption
checks in the buffer lru lists write paths.

The reason xmms skips I believe is because the vm is doing write
throttling. I've at least one idea on how to fix it but it has nothing
to do with preemption in the VM or whatever else scheduler related
thing.

So I wouldn't expect to fix any playback skips where buffering is
possible by using the preemptive patch etc.. It's nearly impossible that
it makes any difference.

The preemptive patch can matter only if you're doing real time signal
processing where any kind of buffering isn't possible.

Andrea
