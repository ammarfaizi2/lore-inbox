Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129443AbRC2XAS>; Thu, 29 Mar 2001 18:00:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129495AbRC2XAJ>; Thu, 29 Mar 2001 18:00:09 -0500
Received: from gateway.sequent.com ([192.148.1.10]:57831 "EHLO
	gateway.sequent.com") by vger.kernel.org with ESMTP
	id <S129443AbRC2W7x>; Thu, 29 Mar 2001 17:59:53 -0500
Date: Thu, 29 Mar 2001 14:57:26 -0800 (PST)
From: Brian Beattie <bbeattie@sequent.com>
To: Andreas Dilger <adilger@turbolinux.com>
cc: Xavier Ordoquy <xordoquy@aurora-linux.com>, linux-kernel@vger.kernel.org
Subject: Re: Bug in the file attributes ?
In-Reply-To: <200103291844.f2TIiSK09176@webber.adilger.int>
Message-ID: <Pine.PTX.4.10.10103291446300.17109-100000@eng2.sequent.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Mar 2001, Andreas Dilger wrote:

> Xavier Ordoquy writes:
> > I just made a manipulation that disturbs me. So I'm asking whether it's a
> > bug or a features.
> > 
> > user> su
> > root> echo "test" > test
> > root> ls -l
> > -rw-r--r--   1 root     root            5 Mar 29 19:14 test
> > root> exit
> > user> rm test
> > rm: remove write-protected file `test'? y
> > user> ls test
> > ls: test: No such file or directory
> > 
> > This is in the user home directory.
> > Since the file is read only for the user, it should not be able to remove
> > it. Moreover, the user can't write to test.
> 
> This is definitely not a bug.  Deleting a file (under *nix) does not
> "modify" the file at all, it is modifying the directory where the file
> resides.

To be correct and pedantic, in a traditional Unix type filesystem, one
does not remove a file...one dereferences it, i.e. "unlink", as part of
this process garbage collection is performed which checks the reference
count. If the inode's reference count is zero, the inode and data blocks
are returned to their respective free lists.  All the rm command does, is
to remove the directory entry and decrement the reference count :).  This
is why Unix has a rm (remove link) as opposed to a del (delete file)
command.

Brian...just being pedantic :-^

Brian Beattie
bbeattie@sequent.com
503.578.5899  Des2-3C-5

