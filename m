Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265382AbSKEX4J>; Tue, 5 Nov 2002 18:56:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265380AbSKEXzH>; Tue, 5 Nov 2002 18:55:07 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:36361 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S265379AbSKEXyq>; Tue, 5 Nov 2002 18:54:46 -0500
Date: Tue, 5 Nov 2002 19:00:37 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       olaf.dietsche#list.linux-kernel@t-online.de
Subject: Re: Filesystem Capabilities in 2.6?
In-Reply-To: <200211030031.gA30V8a505209@saturn.cs.uml.edu>
Message-ID: <Pine.LNX.3.96.1021105184858.20035C-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2 Nov 2002, Albert D. Cahalan wrote:

> 
> I have to wonder, just how many setuid executables do people have?
> Implementing filesystem capability bits in ramfs or tmpfs might do
> the job. At boot, initramfs stuff puts a few trusted executables
> in /trusted and sets the capability bits. Then "mount --bind" to
> put /trusted/su over an empty /bin/su file, or use symlinks.

It's more useful that you might at first think, in terms of applications.
If I have an app I want to make available to a limited group, currently I
can portably make the file setuid to app-owner, then group but not world
executable, and the people in the group can have access. The app might be
a database, usenet news, mail system spam filter, whatever. ACLs work, but
are not widely portable at the moment (if ever).

> One might as well make "nosuid" the default then, and mount the
> root filesystem that way. It's not as if a system needs to have
> gigabytes of setuid executables.

Well, my point here is not that you can't do this, but that normal users
may have legitimate reasons for doing this, and that it's desirable to
avoid having to remount the filesystem to reload some setuid file list.

I would think a mount option which blocks setuid on root owned files and
files which are world writable would be useful. That would allow the
mounting of applications, which people in practice do, without
compromising the whole system.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

