Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265334AbSJRWyG>; Fri, 18 Oct 2002 18:54:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265337AbSJRWyG>; Fri, 18 Oct 2002 18:54:06 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:34788 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S265334AbSJRWyF>;
	Fri, 18 Oct 2002 18:54:05 -0400
Date: Fri, 18 Oct 2002 19:00:05 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Olaf Dietsche <olaf.dietsche#list.linux-kernel@t-online.de>
cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: [PATCH][RFC] 2.5.42 (1/2): Filesystem capabilities kernel patch
In-Reply-To: <87y98vmuqf.fsf@goat.bogus.local>
Message-ID: <Pine.GSO.4.21.0210181845281.21677-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 18 Oct 2002, Olaf Dietsche wrote:

> This patch adds filesystem capabilities to 2.5.42, but it applies to
> 2.5.43 as well.
> 
> It's very simple. In the root directory of every filesystem, there
> must be a file named ".capabilities". This is the capability database
> indexed by inode number. These files are populated by a chcap tool,
> see next mail.
> 
> This fs capability system should work on all filesystem, which can
> provide long dotted names and have some sort of inode. Another benefit
> is, when holes in files are allowed. Otherwise the .capabilities file
> could grow pretty large.
> 
> I use this on an ext2 filesystem. It boots and seems to work so far.
> 
> Comments?

His-fscking-terical.  Seriously, what comments do you expect?  To start
with, on a bunch of filesystems inode numbers are unstable.  Moreover,
owner of that file suddenly gets _all_ capabilities that exist in the
system, ditto for any task capable of mount(2), ditto for owner of
root directory on some filesystem.  And there is no way to recognize
that file as such, so additional checks on write(), mount(), unlink().
etc. are not possible.  And that is not to mention that binding of
non-root will play silly buggers with the entire scheme.

IOW, idea is unsalvagable.

