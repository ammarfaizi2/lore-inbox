Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315528AbSFOUYt>; Sat, 15 Jun 2002 16:24:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315529AbSFOUYs>; Sat, 15 Jun 2002 16:24:48 -0400
Received: from h-64-105-136-45.SNVACAID.covad.net ([64.105.136.45]:24738 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S315528AbSFOUYs>; Sat, 15 Jun 2002 16:24:48 -0400
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Sat, 15 Jun 2002 13:24:43 -0700
Message-Id: <200206152024.NAA02772@adam.yggdrasil.com>
To: akpm@zip.com.au
Subject: Re: bio_chain: proposed solution for bio_alloc failure and large IO simplification
Cc: axboe@suse.de, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>         Can't I make a macro to do a table lookup from bio->bi_max?

>Not really.  If I do

>	bio_alloc(GFP_KERNEL, 27);

>then I'll get a 32-slot bvec.  But presumably, I don't
>want to put more than 27 pages into it.

	If you called bio_alloc with a smaller number, that would
just be the result of a small IO that you knew could not generate
more iovecs than that.  So, that scenario will not happen.

	If that scenario did happen, by the way, it would still
be safe.  If you cannot handle the larger request for some reason
that is not apparent to q->one_more_bvec, then you would make
your own one_more_bvec routine (probably a wrapper).

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."
