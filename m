Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314835AbSFOH4C>; Sat, 15 Jun 2002 03:56:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315119AbSFOH4B>; Sat, 15 Jun 2002 03:56:01 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:17600 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S314835AbSFOHz7>;
	Sat, 15 Jun 2002 03:55:59 -0400
Date: Sat, 15 Jun 2002 09:55:51 +0200
From: Jens Axboe <axboe@suse.de>
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: akpm@zip.com.au, linux-kernel@vger.kernel.org
Subject: Re: bio_chain: proposed solution for bio_alloc failure and large IO simplification
Message-ID: <20020615075551.GB1359@suse.de>
In-Reply-To: <200206142339.QAA27000@adam.yggdrasil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 14 2002, Adam J. Richter wrote:
> Andrew Morton <akpm@zip.com.au> wrote:
> >I have not yet seen a BIO allocation failure in testing.  This
> >would indicate that either the BIO pool is too large, or I'm 
> >running the wrong tests.  Either way, I don't think we have
> >demonstrated any otherwise-unsolvable problems with BIO allocation.
> 
> 	You need to prove that this can never happen once the
> device is initialized, not just that no 2.5 user has reported it
> yet.

The I/O path allocations all use GFP_NOIO (or GFP_NOFS), which all have
__GFP_WAIT set. So the bio allocations will try normal allocation first,
then fall back to the bio pool. If the bio pool is also empty, we will
block waiting for entries to be freed there. So there never will be a
failure.

-- 
Jens Axboe

