Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129663AbQLRTMG>; Mon, 18 Dec 2000 14:12:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130017AbQLRTLr>; Mon, 18 Dec 2000 14:11:47 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:33541 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S129663AbQLRTLk>;
	Mon, 18 Dec 2000 14:11:40 -0500
Date: Mon, 18 Dec 2000 19:40:50 +0100
From: Jens Axboe <axboe@suse.de>
To: Mark Hemment <markhe@veritas.com>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Linus elevator
Message-ID: <20001218194050.A1186@suse.de>
In-Reply-To: <Pine.LNX.4.21.0012181750350.22851-100000@alloc>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0012181750350.22851-100000@alloc>; from markhe@veritas.com on Mon, Dec 18, 2000 at 06:13:53PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 18 2000, Mark Hemment wrote:
> Hi,
> 
>   Looking at the second loop in elevator_linus_merge(), it is possible for
> requests to have their elevator_sequence go negative.  This can cause a
> v long latency before the request is finally serviced.
> 
>   Say, for example, a request (in the queue) is jumped in the first loop
> in elevator_linus_merge() as "cmd != rw", even though its 
> elevator_sequence is zero.  If it is found that the new request will
> merge, the walking back over requests which were jumped makes no test for
> an already zeroed elevator_sequence.  Hence it zero values can occur.
> 
>   With high default values for read/wite_latency, this hardly ever occurs.
> 
>   A simple fix for this is to test for zero before decrementing (patch
> below) in the second loop.

The merge part was original deliberate, as not to account successful
merges as much as a new request added (and thus an implied seek). But
you did uncover a problem, btw this is also fixed in the blk-12 patch
that also does better accounting to avoid indefinite starvation.

>   Alternatively, should testing in the first loop be modified?

To stay with the original design, yes.

-- 
* Jens Axboe <axboe@suse.de>
* SuSE Labs
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
