Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268846AbRHBHpB>; Thu, 2 Aug 2001 03:45:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268847AbRHBHov>; Thu, 2 Aug 2001 03:44:51 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:21818 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S268846AbRHBHof>; Thu, 2 Aug 2001 03:44:35 -0400
Date: Thu, 2 Aug 2001 09:45:17 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Jeremy Higdon <jeremy@classic.engr.sgi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: changes to kiobuf support in 2.4.(?)4
Message-ID: <20010802094517.I29065@athlon.random>
In-Reply-To: <10108012254.ZM192062@classic.engr.sgi.com> <20010802084259.H29065@athlon.random> <andrea@suse.de> <10108020031.ZM229058@classic.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10108020031.ZM229058@classic.engr.sgi.com>; from jeremy@classic.engr.sgi.com on Thu, Aug 02, 2001 at 12:31:52AM -0700
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 02, 2001 at 12:31:52AM -0700, Jeremy Higdon wrote:
> By "mmap callback", you're referring to the mmap entry in the file_operations
> structure?

yes.

> I am doing direct I/O.  I'm using the kiobuf to hold the page addresses
> of the user's data buffer, but I'm calling directly into my driver
> after doing the map_user_kiobuf() (I have a read/write request, a file
> offset, a byte count, and a set of pages to DMA into/out of, and that
> gets directly translated into a SCSI command).
> 
> It turns out that the old kmem_cache_alloc was very lightweight, so I
> could get away with doing it once per I/O request, so I would indeed
> profit by going back to a light weight kiobuf, or at least an optional
> allocation of the bh and blocks arrays (perhaps turn them into pointers
> to arrays?).

I see your problem and it's a valid point indeed. But could you actually
allocate the kiobuf in the file->f_iobuf pointer? I mean: could you
allocate it at open/close too?  That would be the way I prefer since you
would need to allocate the bh anyways later (but with a flood of
alloc/free). So if you could move the kiobufs allocation out of the fast
path you would get a benefit too I believe.

Andrea
