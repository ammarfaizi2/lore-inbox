Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281219AbRKLDVL>; Sun, 11 Nov 2001 22:21:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281222AbRKLDVC>; Sun, 11 Nov 2001 22:21:02 -0500
Received: from zok.SGI.COM ([204.94.215.101]:38624 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S281219AbRKLDUt>;
	Sun, 11 Nov 2001 22:20:49 -0500
Date: Mon, 12 Nov 2001 14:20:29 +1100
From: Nathan Scott <nathans@sgi.com>
To: Anton Altaparmakov <aia21@cam.ac.uk>
Cc: "Tim R." <omarvo@hotmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] extended attributes
Message-ID: <20011112142029.D583135@wobbly.melbourne.sgi.com>
In-Reply-To: <3BECEEA2.4030408@hotmail.com> <5.1.0.14.2.20011112012026.02b3eda8@pop.cus.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <5.1.0.14.2.20011112012026.02b3eda8@pop.cus.cam.ac.uk>; from aia21@cam.ac.uk on Mon, Nov 12, 2001 at 01:57:28AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi Anton,

On Mon, Nov 12, 2001 at 01:57:28AM +0000, Anton Altaparmakov wrote:
> At 09:08 10/11/2001, Tim R. wrote:
> >I'm glad to see you guys are working on a common acl api for ext2/3 and xfs.
> >I was just wondering if this api provided what would be needed for linux 
> >to support NTFS's acls.
> 
> Comments/problems for NTFS with proposed EA/ACL API:
> 
> I think the API is good for extended attributes, no doubt. If we ever get 
> round to implementing EAs in NTFS then I would be happy to use the API. It 
> fully satisfies the needs of the NTFS EAs.

That's great to hear!  Thanks.

> The only addition I would put 
> into the API is that the names of the extended attributes have to be able 
> to have different name spaces themselves. For example I am fairly sure that 
> the name of an EA in NTFS cannot contain just any character and it 
> certainly cannot have a name of any length... This is something that needs 
> to be considered.

Agreed.  I think the determination of what is a valid attribute
name and what are the max name lengths, etc. will have to be
done within the filesystem, as we have already come across these
sorts of differences when reconciling the XFS EAs (from IRIX)
with Andreas' ext2/3 ones.  

I'll put out an initial attempt at some VFS code to sit behind
this system call soon too.

> I guess the real problem is that NTFS security doesn't map very well onto 
> Unix/Linux type of security model because the NTFS model has way more features.
> 
> If you are asking the question whether NTFS can work with the proposed API 
> then yes, it can support all its features, but not the other way round...
> 
> Particular problems:
> 
> - The proposed API puts ACLs inside extended attributes (EAs).

By "proposed API" I assume you are talking about Andreas' POSIX ACL
implementation?  (i.e. not this API for extended attributes, which
we have described here, as this is not specific to any form of ACLs).

I don't think anyone has ever proposed that the NTFS ACLs need to
use the same userspace tools as Andreas' POSIX ACL implementation -
I'm not sure that makes any sense at all.

> On NTFS ACLs have nothing to do with extended attributes.

Yup and right there this extended attribute system call API becomes
inappropriate for NTFS ACLs, right?  It is not that its a limitation
of this API, it is that NTFS does not use EAs to store ACLs.  Using
a crowbar to try to force that association is almost certainly not
a good idea.

> They are two entirely different things.

*nod*

> I suppose they could be merged into one API and the NTFS 
> driver would have to parse and decide whether it is supposed to be 
> operating on ACLs or EAs. But that will be a pain, especially as there may 
> be ways of abusing the system, depending on how exactly it is implemented.

If you do implement NT ACLs in NTFS, then it sounds like you would
be better off using a different API to this extended attribute one.
Andreas has several thoughts on this - he knows plenty more about
ACLs than I, having researched this area alot and having completely
implemented POSIX ACLs for ext2/3 from scratch.  I have read mail
from him saying that given the different semantics of the numerous
forms of ACL, that a single ACL API is inappropriate/impossible.

It is convenient for us in XFS and ext2/3 to be able to use extended
attributes to implement POSIX ACLs - because these filesystems all
really do implement POSIX ACLs using extended attributes.  Of course,
this doesn't necessarily mean that it will be convenient for other
filesystems that don't implement their particular flavour of ACLs as
extended attributes.

Thanks for the feedback, Anton - much appreciated.

cheers.

-- 
Nathan
