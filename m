Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262279AbUKQLgp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262279AbUKQLgp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 06:36:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262280AbUKQLgp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 06:36:45 -0500
Received: from tarjoilu.luukku.com ([194.215.205.232]:25227 "EHLO
	tarjoilu.luukku.com") by vger.kernel.org with ESMTP id S262279AbUKQLgd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 06:36:33 -0500
Message-ID: <419B383C.CE11D38C@users.sourceforge.net>
Date: Wed, 17 Nov 2004 13:38:36 +0200
From: Jari Ruusu <jariruusu@users.sourceforge.net>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.22aa1r7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Sami Farin <7atbggg02@sneakemail.com>
Cc: linux-kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: vm-pageout-throttling.patch: hanging in 
 throttle_vm_writeout/blk_congestion_wait
References: <20041115012620.GA5750@m.safari.iki.fi> <Pine.LNX.4.44.0411152140030.4171-100000@localhost.localdomain> <20041115223709.GD6654@m.safari.iki.fi>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sami Farin wrote:
> On Mon, Nov 15, 2004 at 09:56:29PM +0000, Hugh Dickins wrote:
> > On Mon, 15 Nov 2004, Sami Farin wrote:
> > >
> > > this time I had some swapspace on /dev/loop1 (file-backed, reiserfs,
> > > loop-AES-2.2d)...  I think (!) it caused this deadlock.
> >
> > That's not at all surprising.  See the swap_extent work Andrew did
> > for 2.5 (in mm/swapfile.c), by which swap to a swapfile now avoids
> > the filesystem altogether (except while swapon prepares the map of
> > disk blocks).  By swapping to a loop device over a file, you're
> > sneaking past his work, and putting the filesystem back under swap.
> 
> Aha...  interesting.
> 
> > It is begging for deadlocks: I'm not saying it couldn't be got to
> > work, and of course it would be nice to boast that there's no such
> > issue; but there are so many better places to invest such effort...
> 
> So, this was a known issue and it's hard to fix?  I didn't know that.
> 
> I know it's a "nicer" idea to use some partition for the swap
> instead of a file on reiserfs, but I created too small swap partitions
> originally and I can't(/bother?) resize the other partitions.
> And sometimes some memhog forces me to add even more swap.

Quote from loop-AES' README file:
"
7.1. Example 1 - Encrypting swap on 2.4 and newer kernels
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Device backed (partition backed) loop is capable of encrypting swap on 2.4
and newer kernels. File backed loops can't be used for swap.
"

That "file backed loops can't be used for swap" warning has been there in
that README file since September 2001.

-- 
Jari Ruusu  1024R/3A220F51 5B 4B F9 BB D3 3F 52 E9  DB 1D EB E3 24 0E A9 DD
