Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135729AbRAJPEQ>; Wed, 10 Jan 2001 10:04:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135312AbRAJPD7>; Wed, 10 Jan 2001 10:03:59 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:52812 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S135729AbRAJPDy>; Wed, 10 Jan 2001 10:03:54 -0500
Date: Wed, 10 Jan 2001 16:03:59 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>,
        linux-kernel@vger.kernel.org, Alexander Viro <viro@math.psu.edu>
Subject: Re: `rmdir .` doesn't work in 2.4
Message-ID: <20010110160359.E19503@athlon.random>
In-Reply-To: <200101091341.HAA52016@tomcat.admin.navo.hpc.mil> <20010109150635.C8824@athlon.random> <20010110144735.E10633@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010110144735.E10633@redhat.com>; from sct@redhat.com on Wed, Jan 10, 2001 at 02:47:35PM +0000
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 10, 2001 at 02:47:35PM +0000, Stephen C. Tweedie wrote:
> Hi,
> 
> On Tue, Jan 09, 2001 at 03:06:35PM +0100, Andrea Arcangeli wrote:
> > On Tue, Jan 09, 2001 at 07:41:21AM -0600, Jesse Pollard wrote:
> > > Not exactly valid, since a file could be created in that "pinned" directory
> > > after the rmdir...
> > 
> > In 2.2.x no file can be created in the pinned directory after the rmdir.
> 
> In 2.2, at least some of that protection was in ext2 itself.  POSIX
> mandates that a deleted directory has no dirents, so readdir() must
> not return even "." or "..".  ext2 achieved this by truncating the dir
> to size==0, and by refusing to add dirents to the resulting completely
> empty directory.
> 
> Do we have enough protection to ensure this for other filesystems?

Note that this has nothing to do with `rmdir .`. You will run into the
mentioned issue just now with '''rmdir "`pwd`"'''. I've not checked
the other fses but I would put such support into the VFS rather than in ext2
(vfs can do that for you, if you do that the lowlevel fs will never get a
readdir for a delete dentry).

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
