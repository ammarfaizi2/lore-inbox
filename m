Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129511AbRAKRFh>; Thu, 11 Jan 2001 12:05:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129595AbRAKRFT>; Thu, 11 Jan 2001 12:05:19 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:59405 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S129744AbRAKRFE>;
	Thu, 11 Jan 2001 12:05:04 -0500
Date: Thu, 11 Jan 2001 18:04:43 +0100
From: Jens Axboe <axboe@suse.de>
To: Andre Hedrick <andre@linux-ide.org>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: KIOBUFS ??
Message-ID: <20010111180443.I640@suse.de>
In-Reply-To: <Pine.LNX.4.10.10101100008160.23071-100000@master.linux-ide.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.10.10101100008160.23071-100000@master.linux-ide.org>; from andre@linux-ide.org on Wed, Jan 10, 2001 at 12:28:18AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 10 2001, Andre Hedrick wrote:
> 
> LT,
> 
> Will this maddness insure that the granularity of the request will be
> dependent to the k_dev_t?  Specifically, can one make KIOBUFS do the
> sizing of buffer to match the ideal or specified size limits imposed by a
> given block device?  Otherwise I will need to design an sub-request layer
> to reduce the pain of restarting the entire request because of the huge
> DMA-PRD-Chain that has no clue how to report error location and allow a
> restart from NxPRD's before the error.

Take a look at the XFS tree. I wrote IDE kiobuf support for that, and
it simply doesn't take the request the queue before it has been
completed (which may take many start-ups for a huge request). But unless
you can make the prd table bigger (which doesn't make much sense anyway),
I don't see any harm in setting up sg for each iteration.

-- 
* Jens Axboe <axboe@suse.de>
* SuSE Labs
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
