Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282412AbRKXJ5H>; Sat, 24 Nov 2001 04:57:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282410AbRKXJ4z>; Sat, 24 Nov 2001 04:56:55 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:22230 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S282409AbRKXJ4o>;
	Sat, 24 Nov 2001 04:56:44 -0500
Date: Sat, 24 Nov 2001 04:56:41 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Andrea Arcangeli <andrea@suse.de>
cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
        Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: 2.4.15-pre9 breakage (inode.c)
In-Reply-To: <20011124103854.I1419@athlon.random>
Message-ID: <Pine.GSO.4.21.0111240445520.4000-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 24 Nov 2001, Andrea Arcangeli wrote:

> I think long term (2.5) the right way is to replace all the iput in the
> slow fail paths with a iput_not_mounted, that will avoid both the iput
> clobbering and the MS_ACTIVE tracking. The differentiation should be

Egads...  Andrea, think for a bloody minute.  What's the point of adding
a new helper that would share a lot of code with the iput() _and_ would
bring additional calling rules?  We get
	* more code in inode.c
	* more code duplications
	* a lot of opportunities to fsck up in fs code
	* redundant invalidate_inodes() calls in fs/super.c existing just
to catch these fsckups.
	* some filesystems getting out with only iput(), some needing new
helper.
	* cut'n'paste programming getting one more source of bugs to
introduce.

And it's not even the case when filesystems could use that distinction in
any sane way...

