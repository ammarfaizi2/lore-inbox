Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282284AbRKWTur>; Fri, 23 Nov 2001 14:50:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282279AbRKWTtv>; Fri, 23 Nov 2001 14:49:51 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:49143
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S282296AbRKWTtR>; Fri, 23 Nov 2001 14:49:17 -0500
Date: Fri, 23 Nov 2001 11:49:11 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Allan Sandfeld <linux@sneulv.dk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.4.15-pre6 / EXT3 / ls shows '.journal' on root-fs.
Message-ID: <20011123114911.B17332@mikef-linux.matchmail.com>
Mail-Followup-To: Allan Sandfeld <linux@sneulv.dk>,
	linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0111200328550.842-100000@behemoth.ts.ray.fi> <E16608e-0001CL-00@localhost> <20011120121947.V1308@lynx.no> <E166pXF-0000mm-00@Princess>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E166pXF-0000mm-00@Princess>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 22, 2001 at 09:48:37AM +0100, Allan Sandfeld wrote:
> On Tuesday 20 November 2001 20:19, Andreas Dilger wrote:
> > On Nov 19, 2001  17:55 -0800, Ryan Cumming wrote:
> > > On November 19, 2001 17:37, you wrote:
> > > > Even so, I'm wondering wether this removal is standardad
> > > > procedure for hiding it once and for all or not?
> >
> > Very definitely NOT.  It _may_ work until the filesystem is unmounted,
> > because the kernel will keep the file "open" so that the inode is not
> > freed, but the next time you try to mount the filesystem it will
> > complain about the journal being a bad inode.
> >
> > > On my system, the journal appears to have a perfectly normal inode number
> > > for a root entry (#22), which makes me think that it's just a normal file
> > > as far as the core filesystem code is concerned.
> >
> > Correct.  Normal, except that if you (as root) really work hard to fool
> > with it, you can potentially cause problems.  Don't do that.  The problems
> > are 99.99% harmless - can't mount as ext3, e2fsck will complain, maybe you
> > can't boot your system, if it is the root fs.  If you really work at it,
> > maybe you can corrupt your fs, but that would take serious effort plus a
> > crash.
> >
> I just tried this... :)
> 
> First corrupted .journal is reported, then "journal deleted, mounting as 
> ext2-only" followed by a forced e2fsck.
> 
> Thats what I call a well handled error...

Did you also have ext2 linked into your kernel (ie, not as a module)?

If you did, then if you kernel didn't have ext2 it probably would've stopped
right there because ext3 won't mount without a journal.

Mike
