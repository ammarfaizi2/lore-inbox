Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130643AbQLaDFM>; Sat, 30 Dec 2000 22:05:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131023AbQLaDFC>; Sat, 30 Dec 2000 22:05:02 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:12124 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S130643AbQLaDEt>; Sat, 30 Dec 2000 22:04:49 -0500
Date: Sun, 31 Dec 2000 03:34:19 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Alexander Viro <viro@math.psu.edu>
Cc: "Eric W. Biederman" <ebiederman@uswest.net>,
        Linus Torvalds <torvalds@transmeta.com>,
        Daniel Phillips <phillips@innominate.de>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Generic deferred file writing
Message-ID: <20001231033419.A17728@athlon.random>
In-Reply-To: <20001231020234.A15179@athlon.random> <Pine.GSO.4.21.0012302027540.4082-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.21.0012302027540.4082-100000@weyl.math.psu.edu>; from viro@math.psu.edu on Sat, Dec 30, 2000 at 08:50:52PM -0500
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 30, 2000 at 08:50:52PM -0500, Alexander Viro wrote:
> And its meaning for 2/3 of filesystems would be?

It should stay in the private part of the in-core superblock of course.

> I _doubt_ it. If it is a pagecache issue it should apply to NFS. It should
> apply to ramfs. It should apply to helluva lot of filesystems that are not
> block-based. Pagecache doesn't (and shouldn't) know about blocks.

With pagecache I meant the library of pagecache methods in buffer.c. Even
if they are recalled by the lowlevel filesystem code and they can be
overridden by lowlevel filesystem code, they aren't lowlevel filesystem code
but they're infact common code.  We can implement another version of them that
instead of knowing about get_block, also know about another filesystem
callback and when possible it only reserve the space for a delayed allocation
later triggered (in parallel) by future kupdate. They will know about this new
callback in the same way the current standard pagecache library methods knows
about get_block_t. Filesystems implementing this callback will be able to use
those new pagecache library methods.

> it should use functions that do not expect such argument. That's it. No
> need to invent new methods or shoehorn all block filesystems into the same
> scheme.

Of course.

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
