Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262304AbSKCSHU>; Sun, 3 Nov 2002 13:07:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262310AbSKCSHT>; Sun, 3 Nov 2002 13:07:19 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:3085 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S262304AbSKCSHT>; Sun, 3 Nov 2002 13:07:19 -0500
Date: Sun, 3 Nov 2002 10:13:37 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: yodaiken@fsmlabs.com
cc: Alexander Viro <viro@math.psu.edu>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Olaf Dietsche <olaf.dietsche#list.linux-kernel@t-online.de>,
       "Theodore Ts'o" <tytso@mit.edu>, Dax Kelson <dax@gurulabs.com>,
       Rusty Russell <rusty@rustcorp.com.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       <davej@suse.de>
Subject: Re: Filesystem Capabilities in 2.6?
In-Reply-To: <20021103095612.A436@hq.fsmlabs.com>
Message-ID: <Pine.LNX.4.44.0211031003170.11657-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 3 Nov 2002 yodaiken@fsmlabs.com wrote:
> 
> Plan 9 !

Well, yes. But also Linux. The code is all there, and you can create a new
namespace group with just a simple CLONE_NEWNS. Then you just do
pivot_root() in that namespace, unmount the old root, and you're done.

Yeah, yeah, I'm sure I forgot something, glossed over the details, and a
real example is more involved. And I'm also sure it hasn't been used in
practice all that much, but Al's point is that this is much more than
"chroot()", and is actually safe from all the normal chroot problems.  
Because the namespace is not a part of the old tree - it's a completely
new tree with no connections to the old one. 

We got it pretty much for free (*) with the vfsmount stuff - which in turn
was needed for bind-mounts.

			Linus

(*) Although, to be honest, it's hard to say how much of it was "for
free", and how much of it was the normal "Al thinking ahead a year or so
while doing incremental patches".  Al is scary that way.

