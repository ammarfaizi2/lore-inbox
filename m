Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262302AbSKCSgW>; Sun, 3 Nov 2002 13:36:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262310AbSKCSgW>; Sun, 3 Nov 2002 13:36:22 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:31246 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S262302AbSKCSgW>; Sun, 3 Nov 2002 13:36:22 -0500
Date: Sun, 3 Nov 2002 10:42:50 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: yodaiken@fsmlabs.com
cc: Alexander Viro <viro@math.psu.edu>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Olaf Dietsche <olaf.dietsche#list.linux-kernel@t-online.de>,
       "Theodore Ts'o" <tytso@mit.edu>, Dax Kelson <dax@gurulabs.com>,
       Rusty Russell <rusty@rustcorp.com.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       <davej@suse.de>
Subject: Re: Filesystem Capabilities in 2.6?
In-Reply-To: <20021103112510.A1873@hq.fsmlabs.com>
Message-ID: <Pine.LNX.4.44.0211031034300.11657-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 3 Nov 2002 yodaiken@fsmlabs.com wrote:
> 
> So capabilities then just seems like a hack.  You can write a trusted
> user space suid gateway program that consults a database, builds you a
> temporary file system with links and permissions to an otherwise hidden
> shared tree and puts you safely in that "temporary  tree". If I understand
> what this does.

That works for stuff where you are willing to live in a very limited 
environment.

Most people aren't willing to live in such environments. They want to look 
up user files in ~/.xxxxx, falling back to /usr/lib/xxxx/config, etc. And 
they want to take advantage of being able to use other programs in the 
system etc etc.

In other words, yes, you can create a temporary tree, and pretty much
arbitrarily restrict what any process can actually see of the filesystem. 
But it's a _lot_ of work, and requires a lot of care, and by limiting your 
filesystem view you limit yourself to only using that view. 

And the fact is, most programmers are lazy. They don't want to go to that 
effort, since it makes it harder for them. And you can't really blame them 
for that - especially since 99% of all projects evolve from something 
where security wasn't a big deal ("it's only for my own use anyway").

Look at how few programs bother with chroot(), and that's a lot easier to 
use (and portable). 

		Linus

PS. Yeah, to some degree namespaces are at least in theory easier to use
than chroot, since they allow for a lot more flexibility and you can
cherry-pick and do things like just re-mount /usr/bin with nosuid inside
your namespace, which chroot doesn't allow. With chroot you end up having
to copy the files explicitly and maintain a separate chroot directory
structure.

