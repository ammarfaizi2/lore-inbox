Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313160AbSC1OVr>; Thu, 28 Mar 2002 09:21:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313163AbSC1OVh>; Thu, 28 Mar 2002 09:21:37 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:47600 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S313162AbSC1OVe>;
	Thu, 28 Mar 2002 09:21:34 -0500
Date: Thu, 28 Mar 2002 09:21:26 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Andrew Morton <akpm@zip.com.au>
cc: lkml <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [patch] ext2_fill_super breakage
In-Reply-To: <3CA2C68E.5B8C4176@zip.com.au>
Message-ID: <Pine.GSO.4.21.0203280918190.24447-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 27 Mar 2002, Andrew Morton wrote:

> In 2.5.7 there is a thinko in the allocation and initialisation
> of the fs-private superblock for ext2.  It's passing the wrong type
> to the sizeof operator (which of course gives the wrong size)
> when allocating and clearing the memory. 
 
> Lesson for the day: this is one of the reasons why this idiom:
> 
> 	some_type *p;
> 
> 	p = malloc(sizeof(*p));
> 	...
> 	memset(p, 0, sizeof(*p));
> 
> is preferable to
> 
> 	some_type *p;
> 
> 	p = malloc(sizeof(some_type));
> 	...
> 	memset(p, 0, sizeof(some_type));

... however, there is a lot of reasons why the former is preferable.
For one thing, the latter is hell on any search.  Moreover, I would
argue that memset() on a structure is not a good idea - better do
the explicit initialization.

