Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313125AbSEAQKH>; Wed, 1 May 2002 12:10:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313138AbSEAQKH>; Wed, 1 May 2002 12:10:07 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:7693 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S313125AbSEAQKG>; Wed, 1 May 2002 12:10:06 -0400
Date: Wed, 1 May 2002 09:08:54 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Jens Axboe <axboe@suse.de>
cc: Martin Dalecki <dalecki@evision-ventures.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] reworked IDE/general tagged command queueing
In-Reply-To: <20020501123705.GI837@suse.de>
Message-ID: <Pine.LNX.4.44.0205010900050.4589-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 1 May 2002, Jens Axboe wrote:
>
> I've rewritten parts of the IDE TCQ stuff to be, well, a lot better in
> my oppinion. I had to accept that the ata_request and rq->special usage
> sucked, it was just one big mess.

Looks good.

I would have one more comment - it would be wonderful if somebody else who
was using tagged commands were to try to use this interface too, just to
verify that it doesn't have any major problems.

I'll be happy to merge the generic tag stuff even without that (on the
assumption that whatever deficiencies can be fixed later anyway), but it
would be wonderful to have some kind of validation of the genericity.

In particular, on an IDE TCQ device we expect the queue depth to be fixed,
but the SCSI subsystem considers queue depth to be only approximate
(because the drive internally might split a command or something, I don't
know). So I wonder how well this interface would interact with the
QUEUE_FULL handling that the SCSI layer does.

Maybe it doesn't matter, and maybe some blk_queue_invalidate_tags() magic
could do the right thing, but I'd like to get some kind of idea of whether
others can use it well..

(If not the SCSI layer, maybe somebody could look at DAC960 or cciss and
see whether they would seem to like the tag interface).

		Linus

