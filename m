Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267127AbRGXHpK>; Tue, 24 Jul 2001 03:45:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267060AbRGXHpA>; Tue, 24 Jul 2001 03:45:00 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:10001 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S267054AbRGXHom>;
	Tue, 24 Jul 2001 03:44:42 -0400
Date: Tue, 24 Jul 2001 09:44:37 +0200
From: Jens Axboe <axboe@suse.de>
To: "Peter T. Breuer" <ptb@it.uc3m.es>
Cc: linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: what's the semaphore in requests for?
Message-ID: <20010724094437.I4221@suse.de>
In-Reply-To: <200107232339.f6NNdXB30979@oboe.it.uc3m.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200107232339.f6NNdXB30979@oboe.it.uc3m.es>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Tue, Jul 24 2001, Peter T. Breuer wrote:
> What's the semaphore field in requests for?  Are driver writers supposed
> to be using it?

Drivers can use it if they want completion to be signalled for a request
(see end_that_request_last). However, see 2.4.7 where it's not ->waiting
and the interface changed.

> The block driver is largely in userspace. All the kernel half does
> is transfer requests to a local queue (with the io lock still held, of
> course). The userspace daemon cycles continously doing ioctls that
> copy the requests (bh by bh) into userspace, where its treated via
> some networking calls, then return an ack via another ioctl. 
> 
> The drivers local queue is protected by a semaphore.  The thing that
> puzzles me is that the bug shows only when copying to a disk device,
> not to /dev/null, through userspace! Is it that the lifetime of a
> request is much longer than expected?

Well all the explanations in the world doesn't help much -- show the
code.

-- 
Jens Axboe

