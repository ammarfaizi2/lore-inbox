Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135896AbRDZTW0>; Thu, 26 Apr 2001 15:22:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135897AbRDZTWQ>; Thu, 26 Apr 2001 15:22:16 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:55610 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S135896AbRDZTV7>; Thu, 26 Apr 2001 15:21:59 -0400
Date: Thu, 26 Apr 2001 21:15:57 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Alexander Viro <viro@math.psu.edu>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] SMP race in ext2 - metadata corruption.
Message-ID: <20010426211557.Z819@athlon.random>
In-Reply-To: <20010426201236.W819@athlon.random> <Pine.LNX.4.21.0104261141280.4480-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0104261141280.4480-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Thu, Apr 26, 2001 at 11:49:14AM -0700
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 26, 2001 at 11:49:14AM -0700, Linus Torvalds wrote:
> 
> On Thu, Apr 26, 2001 at 11:45:47AM -0400, Alexander Viro wrote:
> >
> >	Ext2 does getblk+wait_on_buffer for new metadata blocks before
> > filling them with zeroes. While that is enough for single-processor,
> > on SMP we have the following race:
> > 
> > getblk gives us unlocked, non-uptodate bh
> > wait_on_buffer() does nothing
> > 					read from device locks it and starts IO
> 
> I see the race, but I don't see how you can actually trigger it.
> 
> Exactly _who_ does the "read from device" part? Somebody doing a

/sbin/dump

> the wait-on-buffer is not strictly necessary: it's probably there to make

maybe not but I need to check some more bit to be sure.

Andrea
