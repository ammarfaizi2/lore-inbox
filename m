Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318794AbSICP1D>; Tue, 3 Sep 2002 11:27:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318798AbSICP1C>; Tue, 3 Sep 2002 11:27:02 -0400
Received: from libra.cus.cam.ac.uk ([131.111.8.19]:53637 "EHLO
	libra.cus.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S318794AbSICP1A>; Tue, 3 Sep 2002 11:27:00 -0400
Date: Tue, 3 Sep 2002 16:31:32 +0100 (BST)
From: Anton Altaparmakov <aia21@cantab.net>
To: Jan Harkes <jaharkes@cs.cmu.edu>
cc: linux-kernel@vger.kernel.org
Subject: Re: [BK-PATCH-2.5] Introduce new VFS inode cache lookup function
In-Reply-To: <20020903152228.GB9903@ravel.coda.cs.cmu.edu>
Message-ID: <Pine.SOL.3.96.1020903162736.14707C-100000@libra.cus.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Sep 2002, Jan Harkes wrote:
> On Tue, Sep 03, 2002 at 06:20:44AM +0100, Anton Altaparmakov wrote:
> > 2) It will return inodes that are I_FREEING or I_CLEAR. I will have to
> > test for these in NTFS and then iput() to wash my hands clean of such
> > garbage. And if I am not mistaken, the iput() actually will BUG().
> 
> If that is the case iget is broken. Perhaps it should test for these
> states in find_inode (and find_inode_fast) and never return them. Are
> those types of inodes still on the inode hash?

That is of course the big question. As I said I haven't looked at this
very closely...

> > 4) If anything, as Christoph Hellwig suggested to me on #kernel,
> > iget{,5}_locked() should be reimplemented in terms of my ilookup()
> > implementation and not vice versa. (-:
> 
> Well, considering that this function (modulo the I_FREEING|I_CLEAR test
> is identical to the first 10 lines in iget5_locked, this could call that
> function. Ofcourse iget_locked is using the 'fast' version of find_inode.

Yes, indeed, and yes. I recall that Al wanted the _fast() versions to
remain separate. This can be done easily enough here, too. For example
ilookup()  and ilookup5() (to remain consistent with iget5() or if you
have a better idea for a name...). 

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cantab.net> (replace at with @)
Linux NTFS maintainer / IRC: #ntfs on irc.openprojects.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

