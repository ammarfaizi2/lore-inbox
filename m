Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261850AbUDELKy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 07:10:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261984AbUDELKy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 07:10:54 -0400
Received: from uni03du.unity.ncsu.edu ([152.1.13.103]:10112 "EHLO
	uni03du.unity.ncsu.edu") by vger.kernel.org with ESMTP
	id S261850AbUDELKw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 07:10:52 -0400
From: jlnance@unity.ncsu.edu
Date: Mon, 5 Apr 2004 07:10:33 -0400
To: Pavel Machek <pavel@ucw.cz>
Cc: Jamie Lokier <jamie@shareable.org>,
       =?unknown-8bit?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>, mj@ucw.cz,
       jack@ucw.cz, "Patrick J. LoPresti" <patl@users.sourceforge.net>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cowlinks v2
Message-ID: <20040405111033.GA1456@ncsu.edu>
References: <20040320152328.GA8089@wohnheim.fh-wedel.de> <20040329171245.GB1478@elf.ucw.cz> <s5g7jx31int.fsf@patl=users.sf.net> <20040329231635.GA374@elf.ucw.cz> <20040402165440.GB24861@wohnheim.fh-wedel.de> <20040402180128.GA363@elf.ucw.cz> <20040402181707.GA28112@wohnheim.fh-wedel.de> <20040402182357.GB410@elf.ucw.cz> <20040402200921.GC653@mail.shareable.org> <20040402213933.GB246@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040402213933.GB246@elf.ucw.cz>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 02, 2004 at 11:39:34PM +0200, Pavel Machek wrote:

> > get_data_id() is one way to detect equivalent files.  Another would be
> > a function files_equal(fd1, fd2) which returns a boolean.
> 
> files_equal(...) would lead to quadratic number of calls, no?
> 
> > get_data_id() has the advantage that it can report immediately whether
> > a file has _any_ cowlink peers, which is important for programs that
> > scan trees.  Perhaps getxattr() would be reasonable interface, using a
> > named attribute "data-id".
> 
> Yes, get_data_id() is extremely ugly name.

I think it is worth asking if we really want to give userspace a way of
doing this or not.  It exposes fairly low level FS details to userspace,
and this will limit our ability to change the implementation of the FS
in the future (partially shared files?).  Certainly there has been some
pain caused over the years because userspace can ask for the inode number,
and people have written file systems which do not use inodes.  Then they
have to kluge around this and make something up.  I would hate to see
us implement an interface that causes long term pain.

I also cant really think of anyone who would need this information.  I have
seen diff and tar used as examples.  Perhaps diff would run faster but that
seems like a very special case thing, and diff will certainly work w/o it.
Tar might also be faster creating archives if it had this information
available.  However to make tar useful wrt cowlinks, it will need to be
able to create these links at extract time from tarfiles which were created
on non-cowlink filesystems, so I don't think there is a pressing need.

Of course, I am willing to believe that I am wrong.  Hope you all have a
great day.

Thanks,

Jim

-- 
www.jeweltran.com
