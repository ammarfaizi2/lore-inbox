Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270271AbRIIOw4>; Sun, 9 Sep 2001 10:52:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270280AbRIIOwp>; Sun, 9 Sep 2001 10:52:45 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:39986 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S270271AbRIIOwh>; Sun, 9 Sep 2001 10:52:37 -0400
Date: Sun, 9 Sep 2001 16:53:21 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexander Viro <viro@math.psu.edu>
Subject: Re: linux-2.4.10-pre5
Message-ID: <20010909165321.U11329@athlon.random>
In-Reply-To: <Pine.LNX.4.33.0109082115270.1161-100000@penguin.transmeta.com> <Pine.LNX.4.33L.0109090909001.21049-100000@duckman.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33L.0109090909001.21049-100000@duckman.distro.conectiva>; from riel@conectiva.com.br on Sun, Sep 09, 2001 at 09:09:53AM -0300
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 09, 2001 at 09:09:53AM -0300, Rik van Riel wrote:
> On Sat, 8 Sep 2001, Linus Torvalds wrote:
> 
> > It's only filesystems that have modified buffers without marking them
> > dirty (by virtue of having pointers to buffers and delaying the dirtying
> > until later) that are broken by the "try to make sure all buffers are
> > up-to-date by reading them in" approach.
> 
> Think of the inode and dentry caches.  I guess we need
> some way to invalidate those.

I recall invalidate_device for that reason before starting the update
(this is indipendent from the blkdev-pagecache patch though, the problem
with the higher level caches applies to mainline as well at the last
blkdev close).

That's meant to give a better chance to the ro-mounted fs to notice the
modifications done by userspace. Probably invalidate_device should also
recall shrink_dcache_sb before running invalidate_inodes though...

Andrea
