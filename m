Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280950AbRKGUVA>; Wed, 7 Nov 2001 15:21:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280824AbRKGUUv>; Wed, 7 Nov 2001 15:20:51 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:42254 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S280950AbRKGUUm>; Wed, 7 Nov 2001 15:20:42 -0500
Message-ID: <3BE99650.70AF640E@zip.com.au>
Date: Wed, 07 Nov 2001 12:15:12 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.14-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Anton Altaparmakov <aia21@cam.ac.uk>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Roy Sigurd Karlsbakk <roy@karlsbakk.net>, linux-kernel@vger.kernel.org
Subject: Re: ext3 vs resiserfs vs xfs
In-Reply-To: <E161Y87-00052r-00@the-village.bc.nu>,
		<5.1.0.14.2.20011107183639.0285a7e0@pop.cus.cam.ac.uk> <5.1.0.14.2.20011107193045.02b07f78@pop.cus.cam.ac.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anton Altaparmakov wrote:
> 
> At 19:12 07/11/2001, Alan Cox wrote:
> > > when coming back up it fscked (I didn't touch anything - didn't even
> > notice
> > > any 5 second thing but I wasn't looking at this screen) and it found two
> > > lost inodes (I got two entries in lost and found). So it still needs to
> > > fsck by the looks of it?
> >
> >That sounds like you used your own kernel with it and had ext2 mounting
> >the root fs (remember its back compatible)
> 
> Yes, that makes a lot of sense. After the reset I went into my own kernel
> with both ext2 and ext3 compiled into it. However, before the reboot, I was
> still in the RH kernel (99% sure it was so, but my memory might be
> deceiving me).
> 
> Is there any Right Way(TM) to fix this situation considering I want to have
> both ext2 and ext3 in my kernels (apart from the obvious of changing the
> order fs are called during root mount in the kernel)?
> 

There's a fair bit of material on this at

	http://www.uow.edu.au/~andrewm/linux/ext3/ext3-usage.html

executive summary:

	- use latest util-linux and e2fsprogs
	- Make the root fs have fstype `ext3' in /etc/fstab
	- Make the others `auto'
	- Alternatively, use "ext3,ext2" in fstab.

The problem is that various tools (mount, fsck, df, others?)
make various assumptions about what to do when certain
filesystem types are encountered in fstab.  It's been a bit
painful.

-
