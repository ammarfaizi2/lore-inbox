Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282399AbRKXIFc>; Sat, 24 Nov 2001 03:05:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282401AbRKXIFW>; Sat, 24 Nov 2001 03:05:22 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:43962 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S282399AbRKXIFF>;
	Sat, 24 Nov 2001 03:05:05 -0500
Date: Sat, 24 Nov 2001 03:05:02 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Andrea Arcangeli <andrea@suse.de>
cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
        Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: 2.4.15-pre9 breakage (inode.c)
In-Reply-To: <20011124084455.B1419@athlon.random>
Message-ID: <Pine.GSO.4.21.0111240247300.4000-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 24 Nov 2001, Andrea Arcangeli wrote:

> > Notice that it fixes _all_ problems with stale inodes, with only one rule
> > for fs code - "don't call iput() when ->clear_inode() doesn't work".  Your
> > variant requires funnier things - "if at some point ->clear_inode()
> > may stop working make sure to call invalidate_inodes()" in addition to
> > the rule above.
> 
> the rule I add is "if ->clear_inode is really needed, just don't clear
> s_op before returning null from read_super" and that requirement looks
> fine.

It's not that simple.  You may need the per-superblock data structures for
->clear_inode() to work.

In any case, it _is_ additional rule for no good reason.  "inode may stay
in icache after iput() only when fs is up and running" is a warranty that
is trivial to provide and that removes a source of hard-to-debug screwups
in fs code.

