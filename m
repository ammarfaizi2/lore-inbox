Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265069AbSKFNc0>; Wed, 6 Nov 2002 08:32:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265071AbSKFNc0>; Wed, 6 Nov 2002 08:32:26 -0500
Received: from hellcat.admin.navo.hpc.mil ([204.222.179.34]:48333 "EHLO
	hellcat.admin.navo.hpc.mil") by vger.kernel.org with ESMTP
	id <S265069AbSKFNcZ> convert rfc822-to-8bit; Wed, 6 Nov 2002 08:32:25 -0500
Content-Type: text/plain; charset=US-ASCII
From: Jesse Pollard <pollard@admin.navo.hpc.mil>
To: Bill Davidsen <davidsen@tmr.com>,
       Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Filesystem Capabilities in 2.6?
Date: Wed, 6 Nov 2002 07:36:52 -0600
User-Agent: KMail/1.4.1
References: <Pine.LNX.3.96.1021105183722.20035A-100000@gatekeeper.tmr.com>
In-Reply-To: <Pine.LNX.3.96.1021105183722.20035A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200211060736.52780.pollard@admin.navo.hpc.mil>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 05 November 2002 05:47 pm, Bill Davidsen wrote:
> On Sat, 2 Nov 2002, Linus Torvalds wrote:
> > There are two fairly trivial ways to do it:
> >
> >  - put the actual data in the directory entry itself. This is efficient,
> >    but not very easily extensible, since most directory structures have
> >    serious size limitations.
>
> I think the arguments against having different capabilities for the same
> executable by different names have been made. It does seem that this would
> mean a symbolic link to the enabled directory entry would work and have
> capabilities, while a hard link to the inode would not?
>
> Being hard to understand is one source of security errors of the "I didn't
> mean to do that" type.

Not to mention what happens if a file gets lost - fsck puts it in the
lost+found directory, but without the protection specified by the owner.

> >  - Make a new file type, and put just that information in the directory
> >    (so that it shows up in d_type on a readdir()).  Put the real data in
> >    the file, ie make it largely look like an "extended symlink".
>
> I thought about symlink-like thngs when I was trying to envision an ACL by
> group, allowing control of a group other than the non-owner group to have
> more (or fewer) rights.
>
> > The latter approach is probably a bit too reminiscent of a Windows
> > "shortcut" aka LNK file to some people, but hey, maybe it's a good idea.
>
> The problem with any form of link by name is that there's no easy way to
> tell from the inode how many pointers there are, and from the link to tell
> when the link target has changed. I could envision security attacks based
> on changing the base file and having capabilities apply via the link.
>
> None of this is beyond implementation, but the idea of having something on
> a file inode certainly removes all attacks taking advantage of the link
> relationship. The best way to make something secure is to eliminate the
> need for it.

absolutely

-- 
-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.
