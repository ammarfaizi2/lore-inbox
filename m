Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314394AbSEFMKw>; Mon, 6 May 2002 08:10:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314395AbSEFMKv>; Mon, 6 May 2002 08:10:51 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:49936 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S314394AbSEFMKv>;
	Mon, 6 May 2002 08:10:51 -0400
Date: Mon, 6 May 2002 14:10:42 +0200
From: Jens Axboe <axboe@suse.de>
To: Anton Altaparmakov <aia21@cantab.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: tcq problem details Re: vanilla 2.5.13 severe file system corruption experienced follozing e2fsck ...
Message-ID: <20020506121042.GP820@suse.de>
In-Reply-To: <5.1.0.14.2.20020506093027.00aca720@pop.cus.cam.ac.uk> <5.1.0.14.2.20020505200138.00b2d660@pop.cus.cam.ac.uk> <20020505183451.98763.qmail@web14102.mail.yahoo.com> <5.1.0.14.2.20020505200138.00b2d660@pop.cus.cam.ac.uk> <5.1.0.14.2.20020506093027.00aca720@pop.cus.cam.ac.uk> <5.1.0.14.2.20020506105723.04138980@pop.cus.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 06 2002, Anton Altaparmakov wrote:
> Jens,
> 
> I didn't get a panic in the limited testing I did just now on 2.5.14 for 
> ntfs however I do get soemthing odd. Even when the box is fully idle 
> proc/ide/blah/tcq shows this:
> 
> TCQ currently on:       yes
> Max queue depth:        32
> Max achieved depth:     14
> Max depth since last:   1
> Current depth:          0
> Active tags:            [ 1, 3, 4, 6, 9, 11, 12, 14, 17, 19, 20, 22, 25, 
> 27, 28, 29, 30, 31, ]
> Queue:                  released [ 1390 ] - started [ 3986 ]
> pending request and queue count mismatch (counted: 18)
> DMA status:             not running
> 
> Some times the number of active tags is higher, seems to vary...
> 
> /me ignorant: this looks wrong. Why are there active tags when no activity? 
> If a am right and this is a problem then perhaps tags are "leaking" some 
> how?

Agrh, that's a silly bug in blk_queue_init_tags(). Could you replace the
memset() of tags->tag_index in there with something ala:

	for (i = 0; i < depth; i++)
		tags->tag_index[i] = NULL;

and see if that solves it?

-- 
Jens Axboe

