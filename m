Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267612AbRGNKyM>; Sat, 14 Jul 2001 06:54:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267620AbRGNKyC>; Sat, 14 Jul 2001 06:54:02 -0400
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:16084 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S267612AbRGNKxt>; Sat, 14 Jul 2001 06:53:49 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Alexander Viro <viro@math.psu.edu>
Date: Sat, 14 Jul 2001 20:53:23 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15184.9379.88029.737764@notabene.cse.unsw.edu.au>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Abramo Bagnara <abramo@alsa-project.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        nfs-devel@linux.kernel.org, nfs@lists.sourceforge.net
Subject: Re: [NFS] [PATCH] Bug in NFS - should init be allowed to set umask???
In-Reply-To: message from Alexander Viro on Saturday July 14
In-Reply-To: <15183.53052.826318.795664@notabene.cse.unsw.edu.au>
	<Pine.GSO.4.21.0107140126330.19749-100000@weyl.math.psu.edu>
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday July 14, viro@math.psu.edu wrote:
> 
> 
> On Sat, 14 Jul 2001, Neil Brown wrote:
> 
> > On Friday July 13, torvalds@transmeta.com wrote:
> > > 
> > > On Sat, 14 Jul 2001, Neil Brown wrote:
> > > >
> > > > I've found a 4th option.  We make it so that fs->umask does not affect
> > > > nfsd
> > > 
> > > Me likee.
> > > 
> > > Applied. I'd only like to double-check that you made sure you changed all
> > > callers?
> > 
> > There is just the call to vfs_mknod in net/unix/af_unix.c that I
> > mentioned.  I'm not sure what to do about that one.
> > 
> > A
> >     find -name '*.[ch]' | xargs egrep 'vfs_(mkdir|mknod|create)'
> 
> RTFM grep(1). \< is your friend...

But then you don't get to see and inspect random samplings of the
kernel, and thereby increase your general knowledge.
The false-positive of devfs_mknod gives a remarkable (if inacurate)
inside into the relationship between vfs and de-vfs :-)

Similarly searching for "umask" finds lots of matches for cpumask and
so it a steping stone into learning more about SMP infrastructure....
:-)

It's call "stratified sampling" and can be a more effective way to
sample a large body of data than put random sampling.

> 
> >   2 matches in net/unix/af_unix.c  one is a comment, the other is the
> >                                    one in question
> > 
> > To be maximally conservative, you might want to apply this patch,
> > just in case it is important.
> 
> It is. Ability to connect == write permissions on AF_UNIX socket. So
> umask matters.

I certainly appreciate that permissions on an AF_UNIX socket matter,
but wondered why they were set to "sock->inode->i_mode" rather than
simply 0666.  Maybe - I thought - sock->inode->i_mode already has the
umask applied in some way, and so re-appling it was not necessary.
Where-from comes the mode that is in sock->inode->i_mode ?

NeilBrown
