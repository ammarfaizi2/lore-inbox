Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264466AbTK0KEV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Nov 2003 05:04:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264468AbTK0KEU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Nov 2003 05:04:20 -0500
Received: from mail.fh-wedel.de ([213.39.232.194]:53656 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id S264466AbTK0KEF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Nov 2003 05:04:05 -0500
Date: Thu, 27 Nov 2003 11:02:17 +0100
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: David Lang <david.lang@digitalinsight.com>
Cc: Nick Piggin <piggin@cyberone.com.au>, Robert White <rwhite@casabyte.com>,
       "'Jesse Pollard'" <jesse@cats-chateau.net>,
       "'Florian Weimer'" <fw@deneb.enyo.de>, Valdis.Kletnieks@vt.edu,
       "'Daniel Gryniewicz'" <dang@fprintf.net>,
       "'linux-kernel mailing list'" <linux-kernel@vger.kernel.org>
Subject: Re: OT: why no file copy() libc/syscall ??
Message-ID: <20031127100217.GA9199@wohnheim.fh-wedel.de>
References: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAA2ZSI4XW+fk25FhAf9BqjtMKAAAAQAAAAilRHd97CfESTROe2OYd1HQEAAAAA@casabyte.com> <3FC5A7F0.8080507@cyberone.com.au> <Pine.LNX.4.58.0311270106430.6400@dlang.diginsite.com> <3FC5BC43.8030209@cyberone.com.au> <Pine.LNX.4.58.0311270143060.6400@dlang.diginsite.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.58.0311270143060.6400@dlang.diginsite.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 November 2003 01:50:46 -0800, David Lang wrote:
> >
> > I don't think it should do any linking / unlinking it should just work
> > with file descriptors. Concurrent writes to a file don't have many
> > guarantees. sys_copy shouldn't have to be any stronger (read weaker).
> 
> I'm thinking that it may actually be easier to do this via file paths
> instead of file descripters. with file paths something like COW or
> zero-copy copy can be done trivially (and the kernel knows the user
> credentials of the program issuing the command and can pass them on to the
> filesystem to see if it's allowed). I don't see how this can be done with
> file descripters (if all you have is a file descripter you can truncate
> and write a file, but you don't know all the links to that file so you
> can't reposition that first inode for example).

And how is userspace supposed to protect itself from race conditions?
Just compare:

fd1 = open(path1);
if (stat(fd1) looks fishy)
	abort();
fd2 = open(path2);
if (stat(fd2) looks fishy)
	abort();
copy(fd1, fd2);

and:

fd1 = open(path1);
if (stat(fd1) looks fishy)
	abort();
fd2 = open(path2);
if (stat(fd2) looks fishy)
	abort();
copy(path1, path2);

Jörn

-- 
Don't worry about people stealing your ideas. If your ideas are any good,
you'll have to ram them down people's throats.
-- Howard Aiken quoted by Ken Iverson quoted by Jim Horning quoted by
   Raph Levien, 1979
