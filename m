Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261659AbSKCFpk>; Sun, 3 Nov 2002 00:45:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261660AbSKCFpj>; Sun, 3 Nov 2002 00:45:39 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:44048 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S261659AbSKCFpj>; Sun, 3 Nov 2002 00:45:39 -0500
Date: Sat, 2 Nov 2002 21:52:08 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Oliver Xymoron <oxymoron@waste.org>
cc: Alexander Viro <viro@math.psu.edu>,
       Olaf Dietsche <olaf.dietsche#list.linux-kernel@t-online.de>,
       "Theodore Ts'o" <tytso@mit.edu>, Dax Kelson <dax@gurulabs.com>,
       Rusty Russell <rusty@rustcorp.com.au>, <linux-kernel@vger.kernel.org>,
       <davej@suse.de>
Subject: Re: Filesystem Capabilities in 2.6?
In-Reply-To: <20021103050344.GF18884@waste.org>
Message-ID: <Pine.LNX.4.44.0211022144070.2934-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 2 Nov 2002, Oliver Xymoron wrote:
> 
> Yes, but this has annoying side effects like booting single-user and
> discovering things like /sbin/ping doesn't exist because mount -a
> didn't run yet.

No, /sbin/ping _would_ exist, it just wouldn't have gotten the elevated 
capabilities yet. 

But that shouldn't matter in single-user mode, since it doesn't _need_ any
elevated capabilities (unless you've somehow made your single-user mode
run as a normal user - that's really secure, but you can't do anything
with it ;)

[ In general the schenario you bring up is actually a good thing: a
  failure mode would fail with _less_ provileges rather than more. Which 
  on the whole is exactly what you want - failure to initialize something 
  should not leave nasty security holes around. ]

On the other hand, I have this suspicion that the most secure setup is one 
that the sysadmin is _used_ to, and knows all the pitfalls of. Which 
obviously is a big argument for just maintaining the status quo with suid 
binaries.

We have decades of knowledge on how to minimize the negative impact of
suid (I've used sendmail as an example of a suid program, and yet last I
looked sendmail was actually pretty careful about dropping all unnecessary
privileges very early on).

And as Al points out, new security features don't mean that you can just
stop being careful. 

		Linus

