Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317477AbSFDKid>; Tue, 4 Jun 2002 06:38:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317476AbSFDKic>; Tue, 4 Jun 2002 06:38:32 -0400
Received: from ns.suse.de ([213.95.15.193]:5 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S317475AbSFDKib>;
	Tue, 4 Jun 2002 06:38:31 -0400
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Caching files in nfsd was Re: [patch 12/16] fix race between writeback and unlink
In-Reply-To: <1023142233.31475.23.camel@tiny.suse.lists.linux.kernel> <Pine.LNX.4.44.0206031514110.868-100000@home.transmeta.com.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 04 Jun 2002 12:38:25 +0200
Message-ID: <p73r8jncori.fsf_-_@oldwotan.suse.de>
X-Mailer: Gnus v5.7/Emacs 20.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@transmeta.com> writes:

> I _think_ that right now nfsd doesn't cache file opens (only inodes), so
> this could be a performance issue for nfsd, but it might be possible to
> change how nfsd acts. And it would be a _lot_ cleaner to do it at the file
> level.

Yes.

Fixing this would also help XFS (which I hope will be merged in 2.5 as
it works very well for a lot of people). It manages its extent
preallocation per file and flushes extents on closes. Currently it has
to maintain an ugly private nfs reference cache to avoid flushing an
extent after every NFS write operation (and killing write performance
this way)

Also letting nfsd know about the filemap.c readahead window information in 
struct file (that is what it currently caches in the racache) is really ugly
and a kind of layering violation...

I guess it is not too uncommon for other file systems too to hold state 
per open file.

-Andi
