Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312526AbSDFQaP>; Sat, 6 Apr 2002 11:30:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312544AbSDFQaP>; Sat, 6 Apr 2002 11:30:15 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:7951 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S312526AbSDFQaO>; Sat, 6 Apr 2002 11:30:14 -0500
Date: Sat, 6 Apr 2002 08:29:57 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alexander Viro <viro@math.psu.edu>
cc: Dave Hansen <haveblue@us.ibm.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [WTF] ->setattr() locking changes
In-Reply-To: <Pine.GSO.4.21.0204060034240.28391-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.33.0204060818440.16963-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 6 Apr 2002, Alexander Viro wrote:
>
> 	a) where the hell is update to Documentation/filesystems/* ?
> 	b) Dave, meet grep.  grep, meet Dave.  Have a happy relationship...

Al, don't blame Dave, blame me. I told Dave to use i_sem instead of a 
special semaphore, just because it seems to be the right thing.

> _Please_, grep before doing global changes.  Trivial search for
> notify_change() would show several calls under ->i_sem.  E.g. one
> in fs/nfsd/vfs.c.  Or in hpfs_unlink().

Hmm.. I don't think the fs/nfsd/vfs.c case is "obviously" under i_sem.  
Certainly not from grepping. Where?

The hpfs/namei.c one definitely needs the removal of the up/down, though. 
Altghough for the life of me I don't see why the filesystem _does_ that at 
all, since it should have been done by the upper layers already, no?

Oh, and Andrew pointed out that in the ext3 case the BKL was forgotten.

		Linus

