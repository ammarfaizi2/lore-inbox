Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261578AbSKCD2y>; Sat, 2 Nov 2002 22:28:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261579AbSKCD2y>; Sat, 2 Nov 2002 22:28:54 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:2571 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S261578AbSKCD2x>; Sat, 2 Nov 2002 22:28:53 -0500
Date: Sat, 2 Nov 2002 19:35:25 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alexander Viro <viro@math.psu.edu>
cc: Olaf Dietsche <olaf.dietsche#list.linux-kernel@t-online.de>,
       "Theodore Ts'o" <tytso@mit.edu>, Dax Kelson <dax@gurulabs.com>,
       Rusty Russell <rusty@rustcorp.com.au>, <linux-kernel@vger.kernel.org>,
       <davej@suse.de>
Subject: Re: Filesystem Capabilities in 2.6?
In-Reply-To: <Pine.LNX.4.44.0211021922280.2354-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.44.0211021925230.2382-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 2 Nov 2002, Linus Torvalds wrote:

> 
> On Sat, 2 Nov 2002, Alexander Viro wrote:
> >
> > 	<shrug> that can be done without doing anything to filesystem.
> > Namely, turn current "nosuid" of vfsmount into a mask of capabilities.
> > Then use bindings instead of links.
> 
> I like that idea. It's very explicit, and clearly name-based, and we do
> have 99% of the support for it already.

It occurs to me that we actually do have the "extended symlink" concept in
UNIX already: the existing "#!" escape for executables is really exactly
that. It's just a structured symlink, except the extension is not a
capability, but rather it's the script to be fed to the executable.

With a simple extended binfmt_misc.c or binfmt_script.c, we could do a
capability escape (that only removes capabilities, but allows for suid
shells) fairly easily if people really want it. And it would work on any
almost-UNIXy filesystem, including NFS etc.

But I like Al's idea of mount binds even more, although it requires maybe
a bit more administration.

		Linus

