Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265128AbSKEXmA>; Tue, 5 Nov 2002 18:42:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265130AbSKEXmA>; Tue, 5 Nov 2002 18:42:00 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:35081 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S265128AbSKEXl7>; Tue, 5 Nov 2002 18:41:59 -0500
Date: Tue, 5 Nov 2002 18:47:59 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Filesystem Capabilities in 2.6?
In-Reply-To: <Pine.LNX.4.44.0211021025420.2413-100000@home.transmeta.com>
Message-ID: <Pine.LNX.3.96.1021105183722.20035A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2 Nov 2002, Linus Torvalds wrote:

> There are two fairly trivial ways to do it:
> 
>  - put the actual data in the directory entry itself. This is efficient, 
>    but not very easily extensible, since most directory structures have 
>    serious size limitations.

I think the arguments against having different capabilities for the same
executable by different names have been made. It does seem that this would
mean a symbolic link to the enabled directory entry would work and have
capabilities, while a hard link to the inode would not?

Being hard to understand is one source of security errors of the "I didn't
mean to do that" type. 
 
>  - Make a new file type, and put just that information in the directory
>    (so that it shows up in d_type on a readdir()).  Put the real data in
>    the file, ie make it largely look like an "extended symlink".

I thought about symlink-like thngs when I was trying to envision an ACL by
group, allowing control of a group other than the non-owner group to have
more (or fewer) rights.
 
> The latter approach is probably a bit too reminiscent of a Windows
> "shortcut" aka LNK file to some people, but hey, maybe it's a good idea.

The problem with any form of link by name is that there's no easy way to
tell from the inode how many pointers there are, and from the link to tell
when the link target has changed. I could envision security attacks based
on changing the base file and having capabilities apply via the link.

None of this is beyond implementation, but the idea of having something on
a file inode certainly removes all attacks taking advantage of the link
relationship. The best way to make something secure is to eliminate the
need for it.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

