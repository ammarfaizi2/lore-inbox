Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267577AbRGNFdc>; Sat, 14 Jul 2001 01:33:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267578AbRGNFdW>; Sat, 14 Jul 2001 01:33:22 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:11478 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S267577AbRGNFdM>;
	Sat, 14 Jul 2001 01:33:12 -0400
Date: Sat, 14 Jul 2001 01:33:06 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Neil Brown <neilb@cse.unsw.edu.au>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Abramo Bagnara <abramo@alsa-project.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        nfs-devel@linux.kernel.org, nfs@lists.sourceforge.net
Subject: Re: [NFS] [PATCH] Bug in NFS - should init be allowed to set umask???
In-Reply-To: <15183.53052.826318.795664@notabene.cse.unsw.edu.au>
Message-ID: <Pine.GSO.4.21.0107140126330.19749-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 14 Jul 2001, Neil Brown wrote:

> On Friday July 13, torvalds@transmeta.com wrote:
> > 
> > On Sat, 14 Jul 2001, Neil Brown wrote:
> > >
> > > I've found a 4th option.  We make it so that fs->umask does not affect
> > > nfsd
> > 
> > Me likee.
> > 
> > Applied. I'd only like to double-check that you made sure you changed all
> > callers?
> 
> There is just the call to vfs_mknod in net/unix/af_unix.c that I
> mentioned.  I'm not sure what to do about that one.
> 
> A
>     find -name '*.[ch]' | xargs egrep 'vfs_(mkdir|mknod|create)'

RTFM grep(1). \< is your friend...

>   2 matches in net/unix/af_unix.c  one is a comment, the other is the
>                                    one in question
> 
> To be maximally conservative, you might want to apply this patch,
> just in case it is important.

It is. Ability to connect == write permissions on AF_UNIX socket. So
umask matters.

