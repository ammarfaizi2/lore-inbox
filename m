Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278794AbRJVN3x>; Mon, 22 Oct 2001 09:29:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278797AbRJVN3n>; Mon, 22 Oct 2001 09:29:43 -0400
Received: from falcon.mail.pas.earthlink.net ([207.217.120.74]:19379 "EHLO
	falcon.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S278794AbRJVN3d>; Mon, 22 Oct 2001 09:29:33 -0400
Date: Mon, 22 Oct 2001 08:29:35 -0500 (EST)
Message-Id: <20011022.082935.74750744.wscott@bitmover.com>
To: viro@math.psu.edu
Cc: cr@sap.com, lm@bitmover.com, janfrode@parallab.uib.no,
        linux-kernel@vger.kernel.org
Subject: Re: Kernel Compile in tmpfs crumples in 2.4.12 w/epoll patch
From: Wayne Scott <wscott@bitmover.com>
In-Reply-To: <Pine.GSO.4.21.0110220556150.2294-100000@weyl.math.psu.edu>
In-Reply-To: <m3pu7gggbf.fsf@linux.local>
	<Pine.GSO.4.21.0110220556150.2294-100000@weyl.math.psu.edu>
X-Mailer: Mew version 2.0.60 on Emacs 20.7 / Mule 4.1 (AOI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Viro <viro@math.psu.edu>
> > tmpfs does not know anything about directory handling. It uses
> > generic_read_dir and dcache_readdir. So this must be a bug in the vfs
> > layer. Al, what do you say?
> 
> If you are changing directory between the calls of getdents(2) - you have
> no warranty that offsets will stay stable.  It's not just Linux.
> 
> Frankly, I don't see what could be done, short of doing qsort() by inumber
> or something equivalent...

So if I am adding files while reading the directory the directory
structure gets rewritten and I might return files more than once?
What happens if files are being deleted?  Can files be skipped?!?

Any reason we have never seen this on ext2 on other filesystems on 10+
versions of UNIX?  BitKeeper is pretty paranoid and includes a lot of
sanity checks.

Does this only happen when the subdirectory I am reading changes, or
on tmpfs will changing any directory cause this?

I am looking at coding a workaround, but I need to know how bad the
problem can be.

-Wayne
