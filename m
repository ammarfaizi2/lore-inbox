Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282372AbRK2ENA>; Wed, 28 Nov 2001 23:13:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282371AbRK2EMv>; Wed, 28 Nov 2001 23:12:51 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:30347 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S282377AbRK2EMh>;
	Wed, 28 Nov 2001 23:12:37 -0500
Date: Wed, 28 Nov 2001 23:12:22 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: rwhron@earthlink.net
cc: linux-kernel@vger.kernel.org, ltp-list@lists.sourceforge.net
Subject: Re: fsync02 test hangs 2.5.1-pre3 + patch
In-Reply-To: <20011128220329.A2718@earthlink.net>
Message-ID: <Pine.GSO.4.21.0111282303190.9271-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 28 Nov 2001 rwhron@earthlink.net wrote:

> On Wed, Nov 28, 2001 at 09:32:43PM -0500, Alexander Viro wrote:
> > Umm...  With which patch?  Sorry for being dense, but I see no patches
> 
> Oops.
> 
> [PATCH] fix for drivers/char/pc_keyb.c in 2.5.1-pre3
> 
> 2.5.1-pre3 would not compile without Alan's patch for pc_keyb.c, etc.
> 
> I also noticed the logfile LTP "runalltests" was writing to has binary 
> data and snippets of kernel code in it.  (Normally it would all be text).
> 
> This was on a reiserfs system, btw.

Interesting...  I see two candidates in -pre3 - either fs/super.c cleanups
are fscked and something leaves superblock or superblock list locked
(either would have such effect, but that would have to happen at mount
or umount time and thing would lock up much earlier) or bio.c+ll_rw_blk.c+...
changes are acting up.

Obvious tests:
	a) 2.5.1-pre2
	b) 2.5.1-pre2 + fs/super.c from 2.5.1-pre3
	c) 2.5.1-pre3 + fs/super.c from 2.5.1-pre2
(fs/super.c changes are independent from everything else).

Another possibility is silent fs corruption from 2.5.0/2.4.15 - if you
ran these kernels you really ought to do fsck -f (or whatever is used
to force recovery of reiserfs).

