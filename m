Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264194AbRFLFSE>; Tue, 12 Jun 2001 01:18:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264195AbRFLFRy>; Tue, 12 Jun 2001 01:17:54 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:38016 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S264181AbRFLFRe>;
	Tue, 12 Jun 2001 01:17:34 -0400
Date: Tue, 12 Jun 2001 01:17:08 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [CFT][PATCH] superblock handling changes
In-Reply-To: <Pine.LNX.4.21.0106120003080.6617-100000@freak.distro.conectiva>
Message-ID: <Pine.GSO.4.21.0106120112520.28165-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 12 Jun 2001, Marcelo Tosatti wrote:

> 
> 
> On Tue, 12 Jun 2001, Alexander Viro wrote:
> 
> > 	Folks, the patch below the fixed and combined variant of
> > the last series of patches sent to Linus.
> 
> Al, 
> 
> Since you are working on that code, would you mind to add some comments
> about IO completion guarantees (also why we don't guarantee fsync() to
> work as it should :)) there ?

I'm _not_ working on that side of things. Let's not add that into the
mix, OK? If you look at inode.c changes you'll see that the only thing
they expect from __sync_one() is to retake inode_lock before moving the
inode from the locked list. Other than that patch doesn't know and
doesn't care about fsync() semantics and implementation.

We have enough fun on the superblock side of the business. Let's keep
the fsync() stuff separate - they are pretty much orthogonal to each
other.

Right now I don't want to open that can of worms. Sorry.

