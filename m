Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317873AbSFNC0V>; Thu, 13 Jun 2002 22:26:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317874AbSFNC0U>; Thu, 13 Jun 2002 22:26:20 -0400
Received: from h24-67-14-151.cg.shawcable.net ([24.67.14.151]:13297 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S317873AbSFNC0S>; Thu, 13 Jun 2002 22:26:18 -0400
From: Andreas Dilger <adilger@clusterfs.com>
Date: Thu, 13 Jun 2002 20:24:38 -0600
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: linux-kernel@vger.kernel.org, akpm@zip.com.au, axboe@suse.de
Subject: Re: bio_chain: proposed solution for bio_alloc failure and large IO simplification
Message-ID: <20020614022438.GR682@clusterfs.com>
Mail-Followup-To: "Adam J. Richter" <adam@yggdrasil.com>,
	linux-kernel@vger.kernel.org, akpm@zip.com.au, axboe@suse.de
In-Reply-To: <200206140156.SAA02512@baldur.yggdrasil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jun 13, 2002  18:56 -0700, Adam J. Richter wrote:
> 	2. bio_chain will set some kind of hint that newbio is
> probably contiguous with oldbio.  So, if oldbio is still on the
> device queue when newbio is eventually submitted, the merge code
> will first check the request that oldbio is in for merging.  So,
> the merging in that case will be O(1).

I really like this part of it.  I always disliked the fact that you
might have a large request at one layer that had to be split up for
submission, only to be re-merged later.  The fact that it could do
the merge in O(1) would be a good thing.

> 	Under this scheme, code that wants to build up big bio's
> can be much simpler, because it does not have to think about
> q->max_phys_segments or q->max_hw_segments (it just has to make sure
> that each request is smaller than q->max_sectors).

The recent discussions in this area have also been unsatisfying, and
this proposal works nicely to remove any knowledge of block device
specific limitations from the submitter.

If you are going to OLS this summer, there is a BOF related to
this "splitting BIO requests in the block layer" or something like
that.

Cheers, Andreas
--
Andreas Dilger
http://www-mddsp.enel.ucalgary.ca/People/adilger/
http://sourceforge.net/projects/ext2resize/

