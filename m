Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129137AbRBPOSd>; Fri, 16 Feb 2001 09:18:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129180AbRBPOSO>; Fri, 16 Feb 2001 09:18:14 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:6216 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S129137AbRBPOSE>; Fri, 16 Feb 2001 09:18:04 -0500
Date: Fri, 16 Feb 2001 15:17:37 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Sasi Peter <sape@iq.rulez.org>
Cc: Godfrey Livingstone <godfrey@hattaway-associates.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Ingo's RAID patch for 2.2.18 final?
Message-ID: <20010216151737.D14430@inspiron.random>
In-Reply-To: <200101241505.QAA01045@iq.rulez.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200101241505.QAA01045@iq.rulez.org>; from sape@iq.rulez.org on Wed, Jan 24, 2001 at 04:05:12PM +0100
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 24, 2001 at 04:05:12PM +0100, Sasi Peter wrote:
> > This isn't obvious. Your working may not fit in cache and so the kernel
> > understand it's worthless to swapout stuff to make space to a polluted
> > cache.
> 
> But your understanding agrees on that the larger chunks for each stream 
> we read into cache, the more efficient for this kind of RAID disk 
> structure the read is, thus basically the more cache we have, the more 
> bandwidth we can serve. (disks give more data in the same time with 
> fewer long reads than with several shorter ones)

The size of the I/O requests doesn't grow linearly with with the size of the
cache, as far as you have some mbyte of cache you will also be able to sumbit
full sized requests to disk (512K per req on 2.4). In your workload you just
had enough memory for the readahead.

In general if your working set doesn't fit in cache, the size of the cache is
unrelated to the bandwith you get out of your RAID, infact if your working set
doesn't fit in cache you should not pass through the cache at all to get the
best performance and to save CPU cycles and L1 dcache and L2 cache (O_DIRECT).

> So might it have been an accidental behaviour of the previous kernels 
> to swap out pages in favor of caching under high I/O pressure, but it 
> was certainly a benefical behaviour.

I trust you this is the case for your workload, but make sure to not assume
that because there's less cache and no swap you're running slower, you may be
running _much_ faster instead ;).

> What should I test with? (2.4.0/1pre?)

latest pre patch is ok.

Andrea
