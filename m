Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129468AbRCADPU>; Wed, 28 Feb 2001 22:15:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129469AbRCADPO>; Wed, 28 Feb 2001 22:15:14 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:16394 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129468AbRCADPC>; Wed, 28 Feb 2001 22:15:02 -0500
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: NBD Cleanup patch and bugfix in ll_rw_blk.c
Date: 28 Feb 2001 19:14:35 -0800
Organization: Transmeta Corporation
Message-ID: <97keqr$6l3$1@penguin.transmeta.com>
In-Reply-To: <200102282127.VAA20600@gw.chygwyn.com> <Pine.LNX.4.10.10102281525420.6380-100000@penguin.transmeta.com> <20010301010751.Y21518@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20010301010751.Y21518@suse.de>, Jens Axboe  <axboe@suse.de> wrote:
>
>I think most of the "we want to disable plugging" behaviour stems
>from the way task queues behave. Once somebody starts a tq_disk
>run, the list is fried and walked one by one. Both old loop
>and nbd drop the io_request_lock and block, possibly waiting
>for I/O to be done (at least the loop case, don't know about
>ndb). But this I/O won't be done just because the target plug every
>now and then just happens to be queued behind the nbd/loop one and a new
>tq_disk run won't start it.

Ugh. 

How about loop/ndb intercepting the damn requests at the "elevator"
layer - that way you see every one of them, and the actual request
function might as well just be a no-op?

		Linus
