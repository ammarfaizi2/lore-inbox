Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135498AbRDSBCS>; Wed, 18 Apr 2001 21:02:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135499AbRDSBB6>; Wed, 18 Apr 2001 21:01:58 -0400
Received: from fjordland.nl.linux.org ([131.211.28.101]:17670 "EHLO
	fjordland.nl.linux.org") by vger.kernel.org with ESMTP
	id <S135498AbRDSBBi>; Wed, 18 Apr 2001 21:01:38 -0400
From: Daniel Phillips <phillips@nl.linux.org>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][CFT] ext2 directories in pagecache
Cc: viro@math.psu.edu
Message-Id: <20010419010122Z92249-1659+6@humbolt.nl.linux.org>
Date: Thu, 19 Apr 2001 03:01:12 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Al Viro wrote:
> Folks, IMO ext2-dir-patch got to the stable stage. Currently
> it's against 2.4.4-pre2, but it should apply to anything starting with
> 2.4.2 or so.
> 
> 	Ted, could you review it for potential inclusion into 2.4 once
> it gets enough testing? It's ext2-only (the only change outside of
> ext2 is exporting waitfor_one_page()), it doesn't change fs layout,
> it seriously simplifies ext2/dir.c and ext2/namei.c and it gives better
> VM behaviour.
> 
> 	Patch is on ftp.math.psu.edu/pub/viro/ext2-dir-patch.gz
> 
> 	Folks, please give it a good beating - it works here, but I'd
> really like it to get wide testing. Help would be very welcome.

I'm pretty familiar with this code since I hacked on it pretty extensively
last  month and it does what it tries to do pretty well.  However it relies
heavily on the assumption that directory blocks can be grouped into page-sized
units.  This assumption doesn't hold in my directory indexing code, and I
don't see any clean way to extend the approach you use in this patch to my
index design.

On the other hand, there is an alternative approach, suggested to me by
Stephen Tweedie, that will run just as fast as this code and have a lot less
cruft in it, namely - perform buffer operations on the underlying buffers in
the page cache.  Now perhaps we should discuss that idea and see if it goes
anywhere.

Aside from the part that's tied to the page cache, your patch is generally a
whole lot nicer to read that the original, and I have already incorporated
parts of it in my directory index patch.

--
Daniel
