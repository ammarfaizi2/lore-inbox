Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273564AbRIUOon>; Fri, 21 Sep 2001 10:44:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273569AbRIUOoe>; Fri, 21 Sep 2001 10:44:34 -0400
Received: from rj.sgi.com ([204.94.215.100]:36750 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S273564AbRIUOo1>;
	Fri, 21 Sep 2001 10:44:27 -0400
Message-Id: <200109211445.f8LEjlW24891@jen.americas.sgi.com>
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
To: Alexander Viro <viro@math.psu.edu>
cc: Steve Lord <lord@sgi.com>, hch@ns.caldera.de,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        "Gonyou, Austin" <austin@coremetrics.com>,
        narancs@narancs.tii.matav.hu, linux-xfs@oss.sgi.com,
        linux-kernel@vger.kernel.org
Subject: Re: XFS to main kernel source 
In-Reply-To: Message from Alexander Viro <viro@math.psu.edu> 
   of "Fri, 21 Sep 2001 10:19:33 EDT." <Pine.GSO.4.21.0109210956150.8014-100000@weyl.math.psu.edu> 
Date: Fri, 21 Sep 2001 09:45:47 -0500
From: Steve Lord <lord@sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> 
> On Thu, 20 Sep 2001, Steve Lord wrote:
> 
> > Two answers here - economics and code stability. This is a filesystem
> > which has been worked on by people being payed to do so by a corporation,
> > therefore there is a budget (long since blown). It was simpler and hence
> > cheaper to wrap XFS in a conversion layer than to rework the code down
> > into the bowels of the filesystem. Then the stability part of it, we
> > started with a working filesystem, from an engineering standpoint it 
> > made more sense to keep as much of the existing code base intact as
> > possible - the less surgery performed the better in terms of keeping
> > things running, and making it easy to take enhancements and fixes made
> > in the Irix base into the Linux code (we don't do it the other way around).
> 
> True, but there's a cost of maintaining the source and reducing the
> size of said source by order of magnitude will help to reduce _that_.

Well there is not an order of magnitude in it, and it then leaves SGI
in the situation of having two even more divergent versions of XFS
than we have now. I do realise there are two conflicting goals in all of
this.

> 
> The argument would make sense if you were treating everything under
> your compatibility layer as a black box, but I sincerely hope that
> it's not the case.

Well, not everything, but the vast majority of the xfs code has not
had to change at all, we have a different buffer cache interface,
and the read/write path is different, and the inode creation/teardown
interface needed surgery to work with linux inodes, oh and endian
conversion. But apart from that ......

>  
> > >  o checks already peformed by the VFS all over the place
> > >    (just take a look at xfs_rename.c!)
> > 
> > I think I will answer this one more slowly and in response to Al Viro's
> > email. But that economics/stability thing comes into it again.
> 
> Looking forward to that...  Just documenting the exclusion requirements
> of CXFS would help.  Big way.  As it is, you are bordering on the "adding
> undocumented API for proprietory module" and while I've got no problems
> with the last part (I don't suffer from stallmanellosis), I really don't
> like the first one.  Nobody's asking to give up the guts of CXFS, but
> having its exclusion requirements documented is a different story.

Working on the locking first, the tricky part is how locks interact with
the transaction mechanism.

Steve


