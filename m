Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277246AbRKFBv2>; Mon, 5 Nov 2001 20:51:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277514AbRKFBvR>; Mon, 5 Nov 2001 20:51:17 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:18536 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S277246AbRKFBvI>; Mon, 5 Nov 2001 20:51:08 -0500
Date: Tue, 6 Nov 2001 02:50:56 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: David Dyck <dcd@tc.fluke.com>, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@suse.de>, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: 2.4.14 doesn't compile: deactivate_page not defined in loop.c
Message-ID: <20011106025056.D31912@athlon.random>
In-Reply-To: <Pine.LNX.4.33.0111051654140.4708-100000@dd.tc.fluke.com> <20011105173517.A22095@figure1.int.wirex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <20011105173517.A22095@figure1.int.wirex.com>; from chris@wirex.com on Mon, Nov 05, 2001 at 05:35:17PM -0800
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 05, 2001 at 05:35:17PM -0800, Chris Wright wrote:
> * David Dyck (dcd@tc.fluke.com) wrote:
> > 
> > 
> > drivers/block/block.o: In function `lo_send':
> > drivers/block/block.o(.text+0x8ad9): undefined reference to `deactivate_page'
> > drivers/block/block.o(.text+0x8b19): undefined reference to `deactivate_page'
> > 
> > 
> > a grep from deactivate_page only shows up in  linux/drivers/block/loop.c
> 
> appears that deactivate_page was removed (see patch-2.4.14).  the patch
> below Works For Me with limited testing (mount loop back, write,
> unmount, remount, stuff i wrote is still there ;-).  YMMV.

no idea why deactivate_page disappeared, it made sense to deactivate the
lower level cache, it doesn't worth to keep two caches with duplicate
information, the higher level cache is faster so we'd better get rid of
the lowlevel cache ASAP, hence the deactivate_page in loop.c.

Andrea
