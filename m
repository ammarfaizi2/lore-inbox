Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131023AbQLaBdc>; Sat, 30 Dec 2000 20:33:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130643AbQLaBdM>; Sat, 30 Dec 2000 20:33:12 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:61525 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S129348AbQLaBdF>; Sat, 30 Dec 2000 20:33:05 -0500
Date: Sun, 31 Dec 2000 02:02:34 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: "Eric W. Biederman" <ebiederman@uswest.net>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Alexander Viro <viro@math.psu.edu>,
        Daniel Phillips <phillips@innominate.de>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Generic deferred file writing
Message-ID: <20001231020234.A15179@athlon.random>
In-Reply-To: <Pine.LNX.4.10.10012301214210.1017-100000@penguin.transmeta.com> <m1u27lpo1g.fsf@frodo.biederman.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1u27lpo1g.fsf@frodo.biederman.org>; from ebiederman@uswest.net on Sat, Dec 30, 2000 at 03:00:43PM -0700
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 30, 2000 at 03:00:43PM -0700, Eric W. Biederman wrote:
> To get ENOSPC handling 99% correct all we need to do is decrement a counter,
> that remembers how many disks blocks are free.  If we need a better

Yes, we need to add one field to the in-core superblock to do this accounting.

> estimate than just the data blocks it should not be hard to add an
> extra callback to the filesystem.  

Yes, I was thinking at this callback too. Such a callback is nearly the only
support we need from the filesystem to provide allocate on flush. Allocate on
flush is a pagecache issue, not really a filesystem issue. When a filesystem
doesn't implement such callback we can simply get_block(create) at pagecache
creation time as usual.

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
