Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131050AbRBPTQh>; Fri, 16 Feb 2001 14:16:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131046AbRBPTQ1>; Fri, 16 Feb 2001 14:16:27 -0500
Received: from mercury.ultramaster.com ([208.222.81.163]:58539 "EHLO
	mercury.ultramaster.com") by vger.kernel.org with ESMTP
	id <S130152AbRBPTQM>; Fri, 16 Feb 2001 14:16:12 -0500
Message-ID: <3A8D4D0F.5EB9BDB1@dm.ultramaster.com>
Date: Fri, 16 Feb 2001 10:53:51 -0500
From: David Mansfield <lkml@dm.ultramaster.com>
Organization: Ultramaster Group LLC
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
CC: Sasi Peter <sape@iq.rulez.org>,
        Godfrey Livingstone <godfrey@hattaway-associates.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Ingo's RAID patch for 2.2.18 final?
In-Reply-To: <200101241505.QAA01045@iq.rulez.org> <20010216151737.D14430@inspiron.random>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:
> 
> On Wed, Jan 24, 2001 at 04:05:12PM +0100, Sasi Peter wrote:
> > > This isn't obvious. Your working may not fit in cache and so the kernel
> > > understand it's worthless to swapout stuff to make space to a polluted
> > > cache.
> >
> > But your understanding agrees on that the larger chunks for each stream
> > we read into cache, the more efficient for this kind of RAID disk
> > structure the read is, thus basically the more cache we have, the more
> > bandwidth we can serve. (disks give more data in the same time with
> > fewer long reads than with several shorter ones)
> 
> The size of the I/O requests doesn't grow linearly with with the size of the
> cache, as far as you have some mbyte of cache you will also be able to sumbit
> full sized requests to disk (512K per req on 2.4). In your workload you just
> had enough memory for the readahead.
> 
> In general if your working set doesn't fit in cache, the size of the cache is
> unrelated to the bandwith you get out of your RAID, infact if your working set
> doesn't fit in cache you should not pass through the cache at all to get the
> best performance and to save CPU cycles and L1 dcache and L2 cache (O_DIRECT).
> 

This may be a bit OT, but when you say O_DIRECT, that implies that you
can pass that flag to open(2) and it will bypass the page cache, and
read directly into user-space buffers (zero-copy IO)?  Does this also
bypass the read-ahead mechanisms in the kernel?  Does it imply O_SYNC?

Lots of questions... no answers.  Sigh.

David

-- 
David Mansfield                                           (718) 963-2020
david@ultramaster.com
Ultramaster Group, LLC                               www.ultramaster.com
