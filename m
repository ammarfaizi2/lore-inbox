Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268304AbRG3Vj5>; Mon, 30 Jul 2001 17:39:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268326AbRG3Vjv>; Mon, 30 Jul 2001 17:39:51 -0400
Received: from weta.f00f.org ([203.167.249.89]:29830 "HELO weta.f00f.org")
	by vger.kernel.org with SMTP id <S268304AbRG3VjB>;
	Mon, 30 Jul 2001 17:39:01 -0400
Date: Tue, 31 Jul 2001 09:39:25 +1200
From: Chris Wedgwood <cw@f00f.org>
To: Chris Mason <mason@suse.com>
Cc: Lawrence Greenfield <leg+@andrew.cmu.edu>,
        Rik van Riel <riel@conectiva.com.br>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
        "Patrick J. LoPresti" <patl@cag.lcs.mit.edu>
Subject: Re: ext3-2.4-0.9.4
Message-ID: <20010731093925.A6318@weta.f00f.org>
In-Reply-To: <464190000.996515944@tiny>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <464190000.996515944@tiny>
User-Agent: Mutt/1.3.18i
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Mon, Jul 30, 2001 at 01:59:04PM -0400, Chris Mason wrote:

    Well, the idea is to get it done in the VFS layer.  reiserfs, ext3, and
    probably the other journaled filesystems could keep track of the last
    transacation and inode was involved with, making the softupdate style
    fsync(file) to commit a rename easy.

But, right now, the VFS layer doesn't know about magic attributes
(such as ext2/3 +S).  The VFS would have to be taught about these and
some other things to support both asynchronous and synchronous
metadata updates (and presumably other smarts too).  The trouble is
these attributes themselves and how they are stored is fs specific, we
could always mandate that as of 2.5.x all filesystems _can_ support
some kind of extended API and defined a minimalist set of attributes
for all filesystems and then allow specific filesystems to have their
own.  Arguably if people are going to force ACLs upon the world, then
a common API would be nice across XFS, resierfs4, JFFS, etc.  (NTFS
can use an API specific to the FS itself as NTFS ACLs are much more
complex and different looking beasts that those from early POSIX
drafts).

For journalling filesystems, it would be really nice if setting an
attribute was all that was required to make rename(2) atomic (or at
the very least to make sure that if the rename system call returns,
the data has been written to non-volatile storage).



  --cw


