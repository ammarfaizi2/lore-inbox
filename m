Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263740AbRFHONH>; Fri, 8 Jun 2001 10:13:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263745AbRFHOM5>; Fri, 8 Jun 2001 10:12:57 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:16397 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S263740AbRFHOMq>;
	Fri, 8 Jun 2001 10:12:46 -0400
Date: Fri, 8 Jun 2001 16:12:45 +0200
From: Jens Axboe <axboe@suse.de>
To: Louis Lam <lsauchun@hotmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Question on Loop and PPDD devices
Message-ID: <20010608161245.D506@suse.de>
In-Reply-To: <F220D8GIOlHmt9QmQMm0001b386@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <F220D8GIOlHmt9QmQMm0001b386@hotmail.com>; from lsauchun@hotmail.com on Fri, Jun 08, 2001 at 09:50:38PM +0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 08 2001, Louis Lam wrote:
> Hi,
> 
> I'm quite new to kernel development, please advice....
> 
> Got some questions about Loop and PPDD Devices.
> 
> *For 2.2 kernels, there are loop-specific modifications in ll_rw_block.c, in 
> make_request(), where the max_req is divided by two. Comments read: loop 
> uses two requests, 1 for loop and the other for real device.
> 
> Q1. How is it exactly using two requests?

FS generates request, received by loop. loop reads/writes the buffer on
the real device, that uses another request.

> Q2. Requests are made to the loop device and when will it generate another 
> request to the real device?

Yes

> Q3. Does the loop device have its own request queue? Or is it using the same 
> request queue as the actual device it is associated with?

No -- in 2.4 it does, all queues have their own request freelist.
However the way that loop works in 2.4, it doesn't allocate/use any
requests at all.

> Q4. What is the relationship between loop device driver and the actual disc 
> driver? How/When is data actually written/read from the disk?

Well data is read/written to loop, which then generates a matching
request for the target device.

> Q4. Where can I gather more information on the principles behind the how 
> loop devices work? Any particular person who might be able to help?

The source is right there, under your nose.

> *I'm Using ppdd to encrypt my swap data, it is very similar to the loop 
> device. Currently as suggested by the instructions, I'm using a swap file in 
> an encrypted partition. I'm trying to port it to the 2.2.14-5.0(Redhat 6.2 
> Kernel)and noticed that when I try to run something like "make -j 3" , there 
> are errors in decryption. This did not happen on a standard 2.2.13 kernel. 
> Sometimes it deadlocks as well(quite intermittent, but usually when I just 
> changed the swap space to the encrypted file).
> 
> Q6: What should I be looking for in order to port it to that kernel? 
> Understand there are changes to buffer.c and various other files related to 
> block I/O, and possibly some to memory management as well.

Just dive in, learn as you go along. Or look at loop + crypto patches.

-- 
Jens Axboe

