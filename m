Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316775AbSFQHHm>; Mon, 17 Jun 2002 03:07:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316826AbSFQHGo>; Mon, 17 Jun 2002 03:06:44 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:51726 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S316835AbSFQHFY>;
	Mon, 17 Jun 2002 03:05:24 -0400
Message-ID: <3D0D8B23.CE7F1590@zip.com.au>
Date: Mon, 17 Jun 2002 00:09:23 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: "Adam J. Richter" <adam@yggdrasil.com>, linux-kernel@vger.kernel.org
Subject: Re: bio_chain: proposed solution for bio_alloc failure and large IO 
 simplification
References: <200206151030.DAA01140@adam.yggdrasil.com> <3D0B9A74.5872B63B@zip.com.au> <20020617063645.GP1359@suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> 
> ...
> > What I did, and what I'd suggest as a convention is:
> >
> > During BIO assembly, bi_vcnt indicates the maximum number of
> > bvecs which the BIO can hold. And bi_idx indexes the next-free
> > bvec within the BIO.
> 
> Hmm I don't like that too much. For reference, bi_vcnt from the block
> layer is the number of bio_vecs in the bio. And bi_idx is the index into
> the 'current' bio_vec. To tie that in with the above, how about just
> changing bi_max to be a real number. Internal bio can still find the
> pool from that, and private bios can just fill it out.

But then bi_max is the _actual_ size of the BIO, and not the
size which the caller requested.

umm, err, actually, that suits me just fine ;)  We could leave
bi_size as-is and just implement

	unsigned bio_nr_bvecs(struct bio *bio);

But that may not work for privately allocated BIOs.  "bios not
coming from bio_alloc()"?

What _are_ these private BIOs, anyway?  Is any in-kernel code
constructing them at present?

-
