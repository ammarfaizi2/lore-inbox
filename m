Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276764AbRJHCVF>; Sun, 7 Oct 2001 22:21:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276765AbRJHCUp>; Sun, 7 Oct 2001 22:20:45 -0400
Received: from rj.sgi.com ([204.94.215.100]:58260 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S276764AbRJHCUo>;
	Sun, 7 Oct 2001 22:20:44 -0400
Date: Mon, 8 Oct 2001 13:19:18 +1100
From: Nathan Scott <nathans@sgi.com>
To: Alexander Viro <viro@math.psu.edu>, Jan Kara <jack@ucw.cz>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, linux-xfs@oss.sgi.com
Subject: Re: Quotactl change
Message-ID: <20011008131918.Y472533@wobbly.melbourne.sgi.com>
In-Reply-To: <20011006150731.C30450@atrey.karlin.mff.cuni.cz> <Pine.GSO.4.21.0110061417260.6465-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.4.21.0110061417260.6465-100000@weyl.math.psu.edu>; from viro@math.psu.edu on Sat, Oct 06, 2001 at 02:25:06PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi Al,

On Sat, Oct 06, 2001 at 02:25:06PM -0400, Alexander Viro wrote:
> On Sat, Oct 06, 2001 at 03:07:32PM +0200, Jan Kara wrote:
> >   I'm sending you a change for quotactl interface which Nathan
> > Scott proposed for XFS. Actually it's his patch with just a few
> > changes from me.
> >   It allows quotactl() to be overidden by a filesystem and so XFS
> > can do it's tricks with quota without patching dquot.c. Sideeffect
> > of this change is a cleanup in quotactl() interface :).
> 
> [snip]
> 
> 	Umm...  So you've just given to each fs driver a syscall with
> completely unspecified arguments?  I _really_ doubt that it's a good
> idea, especially since each instance will have to copy structures
> to/from userland.
> 
> 	Please, put switch by the first argument and copy_{to,from}_user()
> into the syscall itself.  Yes, it means more methods, but it helps to avoid
> large PITA couple of years down the road.
> 

OK, if that's for the best, I'll rework it.  I thought it would
be cleaner to do it that other way, because it meant not having
any knowledge of the filesystem-specific quota data structures
and operations up at this higher (vfs) level.  Since ioctl is
available as a generic copy in/out facility already, I'm not
sure why any filesystem would abuse quotactl in this way, but
perhaps that's just human nature. ;-)

The only other reason that I was thinking of - I expect that 
Veritas' VxFS will also wish to provide its own quota subsystem,
as they seem to do for other operating systems.  Since (and I may
be wrong here) the intention there is to make VxFS a commercial
filesystem for Linux, it would also help those folk out if the
point of doing the user data copying was within the filesystem.
So, I was trying to do the right thing by everyone in making it
generic - your suggestion will work just fine for our needs in
XFS though.

Thanks for the feedback - new patch later.

cheers.

-- 
Nathan
