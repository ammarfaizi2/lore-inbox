Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262379AbTJYE3T (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Oct 2003 00:29:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262404AbTJYE3T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Oct 2003 00:29:19 -0400
Received: from zok.SGI.COM ([204.94.215.101]:61573 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id S262379AbTJYE3J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Oct 2003 00:29:09 -0400
Date: Sat, 25 Oct 2003 14:28:41 +1000
From: Nathan Scott <nathans@sgi.com>
To: Jirka Kosina <jikos@jikos.cz>
Cc: linux-kernel@vger.kernel.org, linux-xfs@oss.sgi.com
Subject: Re: 2.6.0-test8 XFS bug
Message-ID: <20031025142841.A833021@wobbly.melbourne.sgi.com>
References: <Pine.LNX.4.58.0310232336180.6971@twin.jikos.cz> <20031024000951.GH858@frodo> <Pine.LNX.4.58.0310240853500.30731@twin.jikos.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.58.0310240853500.30731@twin.jikos.cz>; from jikos@jikos.cz on Fri, Oct 24, 2003 at 09:03:01AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 24, 2003 at 09:03:01AM +0200, Jirka Kosina wrote:
> On Fri, 24 Oct 2003, Nathan Scott wrote:
> > > Oct 22 13:12:56 storage2 kernel: Filesystem "dm-0": XFS internal error xfs_alloc_read_agf at line 2208 of file fs/xfs/xfs_alloc.c.  Caller 0xc01e8f5c
> > You're allocating real disk space for delayed allocate file data
> > down this path, and the read of the allocation group header found
> > something that didn't look at all like metadata on disk.
> > So, you definately have corruption and will need to xfs_repair.
> > Any ideas as to what operations triggered the initial problem?
> > (is it reproducible for you?)
> 
> I can simply reproduce it - the only thing needed is to nfsmount this
> partition from clients and start writing a file to it, as I've written
> before. The crash occurs immediately after the transfer begins.

OK, I missed that information in your last mail then, I thought
you had done successful NFS tests and then failed on a local cp.
Looks like we need to focus on more XFS/NFS testing in 2.6; will
do.

> As I've said, I wouldn't blame HW failure or things like this, because 
> ext3 does the job flawlessly, as far as I can see.

Understood -- its good to have it narrowed down to XFS.  Was that
ext3 test on the same DM device, also at 5.5 Tb with LBD, and NFS
involved too?  Could you send me your xfs_repair output and also
your filesystem geometry (xfs_info).

thanks.

-- 
Nathan
