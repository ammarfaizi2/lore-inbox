Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314422AbSFNXj6>; Fri, 14 Jun 2002 19:39:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314690AbSFNXj5>; Fri, 14 Jun 2002 19:39:57 -0400
Received: from h-64-105-136-45.SNVACAID.covad.net ([64.105.136.45]:1684 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S314422AbSFNXj5>; Fri, 14 Jun 2002 19:39:57 -0400
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Fri, 14 Jun 2002 16:39:52 -0700
Message-Id: <200206142339.QAA27000@adam.yggdrasil.com>
To: akpm@zip.com.au
Subject: Re: bio_chain: proposed solution for bio_alloc failure and large IO simplification
Cc: axboe@suse.de, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@zip.com.au> wrote:
>I have not yet seen a BIO allocation failure in testing.  This
>would indicate that either the BIO pool is too large, or I'm 
>running the wrong tests.  Either way, I don't think we have
>demonstrated any otherwise-unsolvable problems with BIO allocation.

	You need to prove that this can never happen once the
device is initialized, not just that no 2.5 user has reported it
yet.

>What bugs me about your approach is this:  I have been gradually
>nudging the kernel's IO paths away from enormously-long per-page
>call paths and per-page locking into the direction of a sequence
>of short little loops, each of which does the same stuff against
>a bunch of pages.

	You need to reread the last paragraph of my previous post.
I have added some capitalization to help:

>>	I think I would be happy enough with your approach, but, just
>>to eliminate possibilities of memory allocation failure, I think I
>>want to still have some kind of bio_chain, perhaps without the merge
>>hinting, BUT WITH A PARAMETER TO ALLOW FOR ALLOCATING A BIO UP TO THE
>>SIZE OF OLDBIO, like so:
>>
>>struct bio *bio_chain(struct bio *oldbio, int gfp_mask,
>>		       int nvecs /* <= oldbio->bi_max */);

	This would not interfere with your plans try to do things
in n page chunks.

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."
