Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291512AbSBHJ6v>; Fri, 8 Feb 2002 04:58:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291519AbSBHJ6e>; Fri, 8 Feb 2002 04:58:34 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:59407 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S291512AbSBHJ6W>;
	Fri, 8 Feb 2002 04:58:22 -0500
Message-ID: <3C63A10E.D5DF604A@zip.com.au>
Date: Fri, 08 Feb 2002 01:57:34 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18-pre7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Rik van Riel <riel@conectiva.com.br>,
        William Lee Irwin III <wli@holomorphy.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch] get_request starvation fix
In-Reply-To: <3C639060.A68A42CA@zip.com.au>,
		<3C639060.A68A42CA@zip.com.au> <20020208095739.J4942@suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> 
> On Fri, Feb 08 2002, Andrew Morton wrote:
> > Here's a patch which addresses the get_request starvation problem.
> 
> [snip]
> 
> Agrh, if only I knew you were working on this too :/. Oh well, from a
> first-read the patch looks good.

Seems that with FIFO fairness, /bin/sync now also livelocks.  And
it's pretty easy to see why.  There's nothing to make
write_unlocked_buffers() terminate.

We'll worry about that tomorrow.  I may just make it give up
after writing (2 * nr_buffers_type[BUF_DIRTY]) buffers.

The patch works well with read-latency2 (and it didn't throw
rejects).  Smooth and fast.  It's going to take some time and
testing to settle everything in.


-
