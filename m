Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288731AbSADTZb>; Fri, 4 Jan 2002 14:25:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288730AbSADTZX>; Fri, 4 Jan 2002 14:25:23 -0500
Received: from hera.cwi.nl ([192.16.191.8]:11905 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S288728AbSADTZE>;
	Fri, 4 Jan 2002 14:25:04 -0500
From: Andries.Brouwer@cwi.nl
Date: Fri, 4 Jan 2002 19:24:24 GMT
Message-Id: <UTC200201041924.TAA230416.aeb@cwi.nl>
To: torvalds@transmeta.com, viro@math.psu.edu
Subject: Re: 2.5.2-pre7 still missing bits of kdev_t
Cc: Nikita@Namesys.COM, alessandro.suardi@oracle.com, andries.brouwer@cwi.nl,
        jgarzik@mandrakesoft.com, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    From viro@math.psu.edu Fri Jan  4 19:11:10 2002

    On Fri, 4 Jan 2002, Linus Torvalds wrote:

    > On Fri, 4 Jan 2002, Jeff Garzik wrote:
    > >
    > > As mentioned to viro on IRC, I think init_special_inode should take
    > > major and minor arguments, to nudge the filesystem implementors into
    > > thinking that major and minor should be treated separately, and be
    > > given additional thought as to how they are encoded on-disk.
    > 
    > Yes. If somebody sends me a patch, I'll apply it in a jiffy.

    Guys, wait a minute with that.  There is a related issue (->i_rdev
    becoming dev_t) and I'd rather see it handled first.

Those are independent issues.

If init_special_inode() has major,minor arguments instead of
the present rdev, then the line

	inode->i_rdev = to_kdev_t(rdev);

just becomes

	inode->i_rdev = mk_kdev(major,minor);

I consider every occurrence of mk_kdev() and of to_kdev_t()
a flaw in the kernel, so this change does not make things
better or worse inside init_special_inode().

Andries
