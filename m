Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277229AbRJVRa6>; Mon, 22 Oct 2001 13:30:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277210AbRJVRau>; Mon, 22 Oct 2001 13:30:50 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:37421 "EHLO
	deathstar.prodigy.com") by vger.kernel.org with ESMTP
	id <S277223AbRJVRaj>; Mon, 22 Oct 2001 13:30:39 -0400
Date: Mon, 22 Oct 2001 13:31:09 -0400
Message-Id: <200110221731.f9MHV9r15979@deathstar.prodigy.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Kernel Compile in tmpfs crumples in 2.4.12 w/epoll patch
X-Newsgroups: linux.dev.kernel
In-Reply-To: <20011022.082935.74750744.wscott@bitmover.com>
Organization: TMR Associates, Schenectady NY
From: davidsen@tmr.com (bill davidsen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20011022.082935.74750744.wscott@bitmover.com> wscott@bitmover.com asked:

| So if I am adding files while reading the directory the directory
| structure gets rewritten and I might return files more than once?
| What happens if files are being deleted?  Can files be skipped?!?
| 
| Any reason we have never seen this on ext2 on other filesystems on 10+
| versions of UNIX?  BitKeeper is pretty paranoid and includes a lot of
| sanity checks.

  I think you can see this on any typical UNIX directory. Assume that a
directory is created with some number of entries. Assume then that the
first ten or so are deleted. Then start your program doing readdir().
After reading a few entries, create a file in that directory. When the
deleted directory entry is reused you have already read past it, and
will not see it until the next time you read the directory.

  Obviously there is a timing window here, but I used to see this with
usenet news when each article was in a separate file and files were
created and deleted in large numbers. Missing a file doesn't seem to be
a problem, because the behaviour is the same as if the file were created
after the readdir() pass, but getting the same directory entry more than
once is likely to produce anything from confusing output to serious
malfunction, depending on what's done with the informaction.

-- 
bill davidsen <davidsen@tmr.com>
  His first management concern is not solving the problem, but covering
his ass. If he lived in the middle ages he'd wear his codpiece backward.
