Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261179AbUDBVkx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Apr 2004 16:40:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261187AbUDBVkw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Apr 2004 16:40:52 -0500
Received: from gprs214-45.eurotel.cz ([160.218.214.45]:10880 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261179AbUDBVjs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Apr 2004 16:39:48 -0500
Date: Fri, 2 Apr 2004 23:39:34 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Jamie Lokier <jamie@shareable.org>
Cc: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>, mj@ucw.cz,
       jack@ucw.cz, "Patrick J. LoPresti" <patl@users.sourceforge.net>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cowlinks v2
Message-ID: <20040402213933.GB246@elf.ucw.cz>
References: <s5gznab4lhm.fsf@patl=users.sf.net> <20040320152328.GA8089@wohnheim.fh-wedel.de> <20040329171245.GB1478@elf.ucw.cz> <s5g7jx31int.fsf@patl=users.sf.net> <20040329231635.GA374@elf.ucw.cz> <20040402165440.GB24861@wohnheim.fh-wedel.de> <20040402180128.GA363@elf.ucw.cz> <20040402181707.GA28112@wohnheim.fh-wedel.de> <20040402182357.GB410@elf.ucw.cz> <20040402200921.GC653@mail.shareable.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040402200921.GC653@mail.shareable.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Okay, now I have to start talking about implementation. Assume ext2 as
> > a base. Theres new object "cowid" which contains, well, id for
> > get_data_id() and usage count. Each inode either has pointer to
> > "cowid" object, or it is plain old regular file.
> 
> Pavel has it exactly right.
> 
> A simple way to store COWID objects in the filesystem itself is as
> another ordinary inode.  The attributes of that inode (mtime, mode
> etc.) aren't important (except to fsck), only the size and data
> pointers are important.  The files which point to a COWID need a flag
> to indicate that, too.

Actually, my solution has one weirdness...

> a
copyfile a b
rm a

...now b has pointer to cowid with usage count of 1. Which is slightly
ugly (and wastes one cowid entry), but should be harmless.

> get_data_id() is one way to detect equivalent files.  Another would be
> a function files_equal(fd1, fd2) which returns a boolean.

files_equal(...) would lead to quadratic number of calls, no?

> get_data_id() has the advantage that it can report immediately whether
> a file has _any_ cowlink peers, which is important for programs that
> scan trees.  Perhaps getxattr() would be reasonable interface, using a
> named attribute "data-id".

Yes, get_data_id() is extremely ugly name.
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
