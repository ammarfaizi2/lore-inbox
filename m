Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263294AbREWWZp>; Wed, 23 May 2001 18:25:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263295AbREWWZZ>; Wed, 23 May 2001 18:25:25 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:53528 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S263294AbREWWZP>; Wed, 23 May 2001 18:25:15 -0400
Date: Thu, 24 May 2001 00:24:52 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Alexander Viro <viro@math.psu.edu>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        "Stephen C. Tweedie" <sct@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: DVD blockdevice buffers
Message-ID: <20010524002452.B764@athlon.random>
In-Reply-To: <20010524000933.A764@athlon.random> <Pine.GSO.4.21.0105231812210.20269-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.21.0105231812210.20269-100000@weyl.math.psu.edu>; from viro@math.psu.edu on Wed, May 23, 2001 at 06:13:13PM -0400
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 23, 2001 at 06:13:13PM -0400, Alexander Viro wrote:
> Uh-oh... After you solved what?

The superblock is pinned by the kernel in buffercache while you fsck a
ro mounted ext2, so I must somehow uptodate this superblock in the
buffercache before collecting away the pagecache containing more recent
info from fsck. It's all done lazily, I just thought not to break the
assumption that an idling buffercache will never become not uptodate
under you anytime because it seems not too painful to implement compared
to changing the fs, it puts the check in a slow path and it doesn't
break the API with the buffercache (so I don't need to change all the fs
to check if the superblock is still uptodate before marking it dirty).

Andrea
