Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262629AbRE3FuE>; Wed, 30 May 2001 01:50:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262622AbRE3FtQ>; Wed, 30 May 2001 01:49:16 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:39114 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S262619AbRE3Fs4>;
	Wed, 30 May 2001 01:48:56 -0400
Date: Wed, 30 May 2001 01:45:00 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Andreas Dilger <adilger@turbolinux.com>
cc: Dawson Engler <engler@csl.stanford.edu>, linux-kernel@vger.kernel.org,
        mc@cs.stanford.edu, daniel.pirkl@email.cz,
        Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linus Torvalds <torvalds@transmeta.com>,
        "Theodore Y. Ts'o" <tytso@MIT.EDU>
Subject: Re: [CHECKER] 84 bugs in 2.4.4/2.4.4-ac8 where NULL pointers are
 deref'd
In-Reply-To: <200105300517.f4U5HDh1020959@webber.adilger.int>
Message-ID: <Pine.GSO.4.21.0105300134520.12645-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 29 May 2001, Andreas Dilger wrote:

> For ext2 it is pretty much the same, except ext2_delete_entry() called
> ext2_check_dir_entry() with a NULL input (for some reason), but it could
> easily supply a valid input value.  All callers to ext2_delete_entry()
> dereference the dir parameter before calling ext2_delete_entry().  All
> other paths dereference dir before ext2_check_dir_entry() is called.

Wrong fix. It
	a) doesn't close all potential problems (think what happens if you
run too close to the end of buffer)
	b) doesn't fix anything that could be triggered - ext2_delete_entry()
can happen only if you've already done lookup. I.e. no problems had been
found in that block back when we were finding the entry.
	c) makes ugly code uglier.
	d) real fix exists and got a lot of testing over that last 5 months.

Folks, I think that directories-in-pagecache patch is worth applying in 2.4.
It is local to fs/ext2, it simplifies a lot of code and it got a decent
testing.

Variant against 2.4.5 is what I'm running right now (and it stayed unchanged
since early March). Patch is on ftp.math.psu.edu/pub/viro/ext2-dir-patch-S5.gz
Please, consider applying it.
								Al

