Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274082AbRI3UQR>; Sun, 30 Sep 2001 16:16:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274095AbRI3UQH>; Sun, 30 Sep 2001 16:16:07 -0400
Received: from ECE.CMU.EDU ([128.2.136.200]:5518 "EHLO ece.cmu.edu")
	by vger.kernel.org with ESMTP id <S274082AbRI3UQC>;
	Sun, 30 Sep 2001 16:16:02 -0400
Date: Sun, 30 Sep 2001 16:16:20 -0400 (EDT)
From: Nilmoni Deb <ndeb@ece.cmu.edu>
To: "Eric W. Biederman" <ebiederm@xmission.com>
cc: Jim Meyering <jim@meyering.net>, viro@math.psu.edu, bug-fileutils@gnu.org,
        Remy.Card@linux.org, linux-kernel@vger.kernel.org
Subject: Re: fs/ext2/namei.c: dir link/unlink bug? [Re: mv changes dir timestamp
In-Reply-To: <m1g0944ib9.fsf@frodo.biederman.org>
Message-ID: <Pine.LNX.3.96L.1010930151001.4952F-100000@d-alg.ece.cmu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 30 Sep 2001, Eric W. Biederman wrote:

> Jim Meyering <jim@meyering.net> writes:
> 
> > Nilmoni Deb <ndeb@ece.cmu.edu> wrote:
> > > When I move a directory its time stamp gets changed.
> > > I am using mv version 4.1 (with mandrake-8.1).
> > 
> > Thanks a lot for reporting that!
> > This appears to be a bug not in GNU mv, nor even in GNU libc, but
> > rather in the underlying implementation in the kernel ext2 file system
> > support.  The offending change seems to have come in with a rewrite
> > of fs/ext2/namei.c that happened sometime between 2.4.4 and 2.4.9.
> > 
> > That file begins with this new comment:
> > 
> >  * Rewrite to pagecache. Almost all code had been changed, so blame me
> >  * if the things go wrong. Please, send bug reports to viro@math.psu.edu
> > 
> > This demonstrates that the problem affects ext2, but not tmpfs
> > using a 2.4.10 kernel (notice that the timestamp doesn't change
> > in /t, but does in the ext2 /tmp):
> 
> This actually looks like a fix.  Ext2 keeps a directory entry named
> .. in the directory so it knows what the parent directory is.
> So to rename a directory besides it must unlink(..) and the link(..) inside
> the directory being moved, at least logically.  In the case you gave
> as the parent directory didn't change it could be optimized out, but
> it probably isn't worth it. 
> 
> I know this is different but why is this a problem?

We are used to the preservation of time stamps during a dir move
(both inside and outside its parent dir) in other working kernels such as
2.2.x and 2.4.2 and 2.4.3. After all, dir time-stamp lets us know when
directory contents have been last changed. In fact even "cp -p" allows
the user to preserve the time stamp during dir copy. With the current
implementation of mv the user will not have the option of preserving the
time-stamp during a dir move. In any case, if we want to change the time
stamp of a dir we always have the option of using touch.

thanks
- Nil

> 
> Eric
> 
> 
> 
> 
> 

