Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317158AbSEXTE1>; Fri, 24 May 2002 15:04:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317163AbSEXTE0>; Fri, 24 May 2002 15:04:26 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:24830 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S317158AbSEXTE0>;
	Fri, 24 May 2002 15:04:26 -0400
Date: Fri, 24 May 2002 15:04:26 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Andrea Arcangeli <andrea@suse.de>
cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: negative dentries wasting ram
In-Reply-To: <20020524185811.GF15703@dualathlon.random>
Message-ID: <Pine.GSO.4.21.0205241502000.9792-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 24 May 2002, Andrea Arcangeli wrote:

> > I might buy that argument if we didn't also leave around _unreferenced_
> > inodes for minutes in the icache.  And _that_ is much stronger source of
> 
> I don't see it, at the last iput of an inode with i_nlink == 0 the inode
> is freed immediatly, not like the dcache that is left floating around as
> a negative one with no useful caching effects for most workloads.

Right.  Now look at the inodes with i_nlink != 0.  And realize that they'd
already gone through the aging in dcache - if they get to the point of
final iput(), they have no references remaining.  And _after_ that they
happily stay in icache for minutes.

