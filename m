Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319063AbSH2Byx>; Wed, 28 Aug 2002 21:54:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319067AbSH2Byx>; Wed, 28 Aug 2002 21:54:53 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:12817 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S319063AbSH2Byw>;
	Wed, 28 Aug 2002 21:54:52 -0400
Message-ID: <3D6D82A3.A3A0C7F0@zip.com.au>
Date: Wed, 28 Aug 2002 19:10:43 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Rik van Riel <riel@conectiva.com.br>
CC: William Lee Irwin III <wli@holomorphy.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch] adjustments to dirty memory thresholds
References: <3D6D477C.F5116BA7@zip.com.au> <Pine.LNX.4.44L.0208282124550.1857-100000@imladris.surriel.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel wrote:
> 
> On Wed, 28 Aug 2002, Andrew Morton wrote:
> 
> > But sigh.  Pointlessly scanning zillions of dirty pages and doing
> > nothing with them is dumb.  So much better to go for a FIFO snooze on a
> > per-zone waitqueue, be woken when some memory has been cleansed.
> 
> But not per-zone, since many (most?) allocations can be satisfied
> from multiple zones.  Guess what 2.4-rmap has had for ages ?

Per-classzone ;)

> Interested in a port for 2.5 on top of 2.5.32-mm2 ? ;)
> 
> [I'll mercilessly increase your patch queue since it doesn't show
> any sign of ever shrinking anyway]

Lack of patches is not a huge problem at present ;).  It's getting them
tested for performance, stability and general does-good-thingsness
which is the rate limiting step.

The next really significant design change in the queue is slablru,
and we'll need to let that sit in partial isolation for a while to
make sure that it's doing what we want it to do.

But yes, I'm interested in a port of the code, and in the description
of the problems which it solves, and how it solves them.  But what is
even more valuable than the code is a report of its before-and-after
effectiveness under a broad range of loads on a broad range of 
hardware.  That's the most time-consuming part...
