Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268983AbRHCMpb>; Fri, 3 Aug 2001 08:45:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269001AbRHCMpW>; Fri, 3 Aug 2001 08:45:22 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:26890 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S268983AbRHCMpQ>; Fri, 3 Aug 2001 08:45:16 -0400
Date: Fri, 3 Aug 2001 14:45:53 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Gerd Knorr <kraxel@bytesex.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: changes to kiobuf support in 2.4.(?)4
Message-ID: <20010803144553.L13067@athlon.random>
In-Reply-To: <10108012254.ZM192062@classic.engr.sgi.com> <20010802084259.H29065@athlon.random> <slrn9mi3g9.36p.kraxel@bytesex.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <slrn9mi3g9.36p.kraxel@bytesex.org>; from kraxel@bytesex.org on Thu, Aug 02, 2001 at 08:23:37AM +0000
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 02, 2001 at 08:23:37AM +0000, Gerd Knorr wrote:
> >  The reason of the large allocation and to put the bh inside the kiobuf
> >  is that if we do a small allocation then we end with a zillion of
> >  allocations of the bh and freeing of the bh at every I/O!! (not even at
> >  every read/write syscall, much more frequently)
> 
> That is true for block device I/O only.  Current bttv versions are using
> kiobufs to lock down user pages for DMA.  But I don't need the bh's to
> transfer the video frames ...

I guess you use map_user_kiobuf to provide zerocopy to read/write too
(not just to user-mapped ram allocated by bttv), right?

If you allocate the kiobuf not in any fast path the vmalloc and big
allocation won't be a real issue even now, however I agree it's ok to
split the bh/block array allocation out of the kiobuf to make it lighter
(but still it won't be a light thing).

Andrea
