Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317862AbSIEQsO>; Thu, 5 Sep 2002 12:48:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317864AbSIEQsO>; Thu, 5 Sep 2002 12:48:14 -0400
Received: from [195.223.140.120] ([195.223.140.120]:25951 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S317862AbSIEQsN>; Thu, 5 Sep 2002 12:48:13 -0400
Date: Thu, 5 Sep 2002 18:53:07 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.20pre5aa1
Message-ID: <20020905165307.GC1254@dualathlon.random>
References: <20020904233528.GA1238@dualathlon.random> <20020905134414.A1784@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020905134414.A1784@infradead.org>
User-Agent: Mutt/1.3.27i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 05, 2002 at 01:44:14PM +0100, Christoph Hellwig wrote:
> > Only in 2.4.20pre5aa1: 00_prepare-write-fixes-3-1
> > 
> > 	Also check the i_size is in sync with the last block we allocated in
> > 	the metadata, it won't be updated in the commit_write if prepare_write
> > 	is failing.
> 
> When testing -aa + my xfs update without the 9* series. this gave an compile
> error.  Any chance you could move it after 96_inode_read_write-atomic-4?

correct, thanks.

btw, even if xfs is applied before the inode_read_write-atomic,  please
make sure xfs will learn using the i_size_read when out of the semaphore
and i_size_write too. I know the locking is different there but I doubt
you're just managing the i_size without races. So it's up to you, either
move xfs patches after inode_read_Write-atomic, or make a separate
race-fix against the xfs codebase at the 70 level. It's not urgent btw,
the inode_read_write doesn't break anything yet (or I couldn't deal with
the flood of errors in every i_size read/write in all the fs out there),
so you won't notice it, but it gives you a chance to fix the races in
the "important" production filesystems. The pagecache/vfs layer should
be safe now, so most fs should be just safe with it. If the fixes will
came later as an incremental patch to apply at the end after a first xfs
update, that's fine with me.

Andrea
