Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267351AbSLLATx>; Wed, 11 Dec 2002 19:19:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267364AbSLLATx>; Wed, 11 Dec 2002 19:19:53 -0500
Received: from packet.digeo.com ([12.110.80.53]:55784 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S267351AbSLLATw>;
	Wed, 11 Dec 2002 19:19:52 -0500
Message-ID: <3DF7D7F4.4347430E@digeo.com>
Date: Wed, 11 Dec 2002 16:27:32 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.46 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Patrick R. McManus" <mcmanus@ducksong.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Memory Measurements and Lots of Files and Inodes
References: <20021211235258.GA10857@ducksong.com> <3DF7D3BE.59F4B212@digeo.com> <20021212002110.GA27532@ducksong.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 12 Dec 2002 00:27:33.0225 (UTC) FILETIME=[434E5D90:01C2A175]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Patrick R. McManus" wrote:
> 
> ...
> > If you could share your test apps that would help a lot.
> 
> sure! this is the "lots of files" program.

Yep, negative dentries:

      dentry_cache:   149092KB   149092KB  100.0 
  ext3_inode_cache:     3425KB    10102KB   33.90
   radix_tree_node:      594KB     1612KB   36.88
       buffer_head:      543KB     1264KB   42.99


You can monitor these via /proc/slabinfo, or using Bill's bloatmeter
script from http://www.zip.com.au/~akpm/linux/patches/stuff/

> ...
> 
> > On your machine it'll be "all of swap plus all of physical memory
> > minus whatever malloc'ed memory you're using now minus 8-12 megabytes".
> > There isn't much memory which cannot be reclaimed unless you have a
> > huge machine or you're doing odd things.
> 
> this is useful advice, thanks. Basically what the new procps does?

I don't know what procps does.

But your fill-up-all-memory program will certainly do the trick.
Run it, create a huge swapstorm (or get oom-killed if there's no
swap) and then see what `free' says.  That's as much memory as the
kernel will ever give you.
