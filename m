Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262043AbUDELql (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 07:46:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262052AbUDELql
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 07:46:41 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:19607 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S262043AbUDELqi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 07:46:38 -0400
Date: Mon, 5 Apr 2004 13:46:37 +0200
From: Pavel Machek <pavel@suse.cz>
To: jlnance@unity.ncsu.edu
Cc: Jamie Lokier <jamie@shareable.org>,
       =?iso-8859-2?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>, mj@ucw.cz,
       jack@ucw.cz, "Patrick J. LoPresti" <patl@users.sourceforge.net>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cowlinks v2
Message-ID: <20040405114637.GB31036@atrey.karlin.mff.cuni.cz>
References: <20040329171245.GB1478@elf.ucw.cz> <s5g7jx31int.fsf@patl=users.sf.net> <20040329231635.GA374@elf.ucw.cz> <20040402165440.GB24861@wohnheim.fh-wedel.de> <20040402180128.GA363@elf.ucw.cz> <20040402181707.GA28112@wohnheim.fh-wedel.de> <20040402182357.GB410@elf.ucw.cz> <20040402200921.GC653@mail.shareable.org> <20040402213933.GB246@elf.ucw.cz> <20040405111033.GA1456@ncsu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040405111033.GA1456@ncsu.edu>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > get_data_id() is one way to detect equivalent files.  Another would be
> > > a function files_equal(fd1, fd2) which returns a boolean.
> > 
> > files_equal(...) would lead to quadratic number of calls, no?
> > 
> > > get_data_id() has the advantage that it can report immediately whether
> > > a file has _any_ cowlink peers, which is important for programs that
> > > scan trees.  Perhaps getxattr() would be reasonable interface, using a
> > > named attribute "data-id".
> > 
> > Yes, get_data_id() is extremely ugly name.
> 
> I think it is worth asking if we really want to give userspace a way of
> doing this or not.  It exposes fairly low level FS details to userspace,
> and this will limit our ability to change the implementation of the FS
> in the future (partially shared files?).  Certainly there has been some
> pain caused over the years because userspace can ask for the inode number,
> and people have written file systems which do not use inodes.  Then they
> have to kluge around this and make something up.  I would hate to see
> us implement an interface that causes long term pain.

It should not be painfull, get_data_id() can allways return
-Esomething, meaning "I do not know".

> I also cant really think of anyone who would need this information.  I have
> seen diff and tar used as examples.  Perhaps diff would run faster but that
> seems like a very special case thing, and diff will certainly work w/o it.

Speeding up diff was one of main cowlinks motivations.
									Pavel
-- 
Horseback riding is like software...
...vgf orggre jura vgf serr.
