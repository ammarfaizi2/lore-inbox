Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315830AbSEJIM3>; Fri, 10 May 2002 04:12:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315832AbSEJIM2>; Fri, 10 May 2002 04:12:28 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:9482 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S315830AbSEJIM1>; Fri, 10 May 2002 04:12:27 -0400
Date: Fri, 10 May 2002 10:12:58 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@zip.com.au>
Cc: Lincoln Dale <ltd@cisco.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: O_DIRECT performance impact on 2.4.18 (was: Re: [PATCH] 2.5.14IDE 56)
Message-ID: <20020510101258.M8428@dualathlon.random>
In-Reply-To: <3CDAC4EB.FC4FE5CF@zip.com.au> <5.1.0.14.2.20020510155122.02d97910@mira-sjcm-3.cisco.com> <3CDB7387.F309D519@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 10, 2002 at 12:15:19AM -0700, Andrew Morton wrote:
> Lincoln Dale wrote:
> > 
> > At 11:50 AM 9/05/2002 -0700, Andrew Morton wrote:
> > > >          /dev/md0 raid-0 with O_DIRECT:          91847kbyte/sec (2781usec
> > > >          /dev/md0
> > > raid-0:                                129455kbyte/sec (1978usec
> > > >          /dev/md0 raid-0 with O_NOCOPY:  195868kbyte/sec (1297usec
> > >
> > >hmm.  Why is O_DIRECT always the slowest?  (and it would presumably do
> > >even worse with an 8k transfer size).
> > 
> > i just reproduced the test to validate the data.  i'm using 8kbyte blocks here.
> > on kernel is 2.4.18, O_DIRECT is still the slowest.
> 
> 8k would rather disadvantage O_DIRECT.  It can't do readahead and it
> can't to write-behind.  It'll be forced to do tons of tiny I/Os.

yes, that's the main factor. Suggested read/write buffer size with
O_DIRECT are of the order of 512k at least (that's the high limit for a
single scsi dma request in 2.4), and 1M even better so you I/O pipeline
some more in the ll_rw_block layer.

Andrea
