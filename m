Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265417AbSJSATn>; Fri, 18 Oct 2002 20:19:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265418AbSJSATn>; Fri, 18 Oct 2002 20:19:43 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:24791 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S265417AbSJSATO>;
	Fri, 18 Oct 2002 20:19:14 -0400
Date: Fri, 18 Oct 2002 20:25:14 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Olaf Dietsche <olaf.dietsche#list.linux-kernel@t-online.de>
cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: [PATCH][RFC] 2.5.42 (1/2): Filesystem capabilities kernel patch
In-Reply-To: <87d6q7mgtf.fsf@goat.bogus.local>
Message-ID: <Pine.GSO.4.21.0210182018010.21677-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 19 Oct 2002, Olaf Dietsche wrote:

> > To start
> > with, on a bunch of filesystems inode numbers are unstable.
> 
> Not really a problem, so restrict it to stable inode systems only.

So exec.c code should go looking for fs type and try and match it
against some table?  OK...
 
> > Moreover,
> > owner of that file suddenly gets _all_ capabilities that exist in the
> > system,
> 
> Yup, like root for example.
> 
> > ditto for any task capable of mount(2),
> 
> How's that? I think this task must own the filesystem and root
> directory too.

mount --bind my_file /usr/.capabilities

> > ditto for owner of
> > root directory on some filesystem.
> 
> Which is a problem for foreign (network) filesystems only. Should be
> solvable with a mount option (i.e. mount -o nocaps ...).
> 
> > And there is no way to recognize
> > that file as such, so additional checks on write(), mount(), unlink().
> > etc. are not possible.
> 
> Depends on, wether I want to recognize it and do these checks. Anyway,
> could be solved with a mount option too or something like quotactl(2)
> maybe.

Ahem.  You had made several capabilities equivalent to "everything".
E.g. "anyone who can override checks in chown() can set arbitrary
capabilities", etc.  Which changes model big way and makes the affected
capabilities pretty much useless - they can be elevated to any other
capability.
 
> > And that is not to mention that binding of
> > non-root will play silly buggers with the entire scheme.
> 
> I don't understand this sentence. What do you mean with "binding of
> non-root"?

mount --bind /usr/bin /mnt
Suddenly /mnt/foo and /usr/bin/foo (same file) have different capabilities.

