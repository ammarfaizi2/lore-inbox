Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280495AbRLEPUB>; Wed, 5 Dec 2001 10:20:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283155AbRLEPTv>; Wed, 5 Dec 2001 10:19:51 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:54984 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S283663AbRLEPTm>;
	Wed, 5 Dec 2001 10:19:42 -0500
Date: Wed, 5 Dec 2001 10:19:39 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Martin Dalecki <dalecki@evision-ventures.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Deep look into VFS
In-Reply-To: <3C0E1CFD.1E2265FB@evision-ventures.com>
Message-ID: <Pine.GSO.4.21.0112051009290.22944-100000@binet.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 5 Dec 2001, Martin Dalecki wrote:

> Unless I'm compleatly misguided the lock on the superblock
> should entierly prevent the race described inside the header comment
> and we should be able to delete clear_inode from this function.

Huh?  We drop that lock before the return from this function.  So if you
move clear_inode() after the return, you lose that protections.

What's more, you can't more that lock_super()/unlock_super() into iput()
itself - you need it _not_ taken in the beginning of ext2_delete_inode()
and you don't want it for quite a few filesystems.

Nothing VFS-specific here, just a bog-standard "you lose protection of
semaphore once you call up()"...

> PS. Deleting clear_inode() would help to simplify the
> delete_inode parameters quite a significant bit, as
> well as deleting the tail union in struct inode - that's the goal.

Again, huh?

