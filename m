Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261161AbUCHTpy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Mar 2004 14:45:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261162AbUCHTpy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Mar 2004 14:45:54 -0500
Received: from [193.108.190.253] ([193.108.190.253]:49289 "EHLO
	pluto.linuxkonsulent.dk") by vger.kernel.org with ESMTP
	id S261161AbUCHTpw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Mar 2004 14:45:52 -0500
Subject: UID/GID mapping system
From: =?ISO-8859-1?Q?S=F8ren?= Hansen <sh@warma.dk>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-15
Message-Id: <1078775149.23059.25.camel@luke>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 08 Mar 2004 20:45:50 +0100
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Based on recent discussions with Urban Widmark, regarding a patch to
smbfs, I've come up with a system for mapping "local" and "remote" UID's
and GID's to each other. "Local" means those in the user database and
"remote" means those on the filesystem in question, be it networked or
non-networked. This system enables you to mount a filesystem via NFS or
Samba (with UNIX extensions) and supply a bunch of mappings between the
UID's and GID's on the client system and those on the server system.
Whenever a local user does something on the filesystem, his UID is
mapped to his corresponding UID on the remote system. This all takes
place in the VFS system.
The system can also be used if a user were to mount a samba share that
has the UNIX extensions enabled. In this case, you'd define a default
local and a default remote UID/GID so that all files would locally
appear to be owned by the mounting user, hence allowing him to actually
access the files that the server would allow him to, without placing any
additional local restrictions on his access (if this doesn't seem to
make sense, see my previous post with subject "smbfs patch").
If you you're moving a disk from one system to another, you could use
the system to fix up the ownership instead of having to change them all
on the actual filesystem.
All in all, I think this could be very helpful.

However, I have two question:
1. I'm very new to this kernel stuff, and this might only be a good idea
inside my head. Does this sound clever or am I fixing these problems at
the totally wrong level?
2. I need a bit of help getting these mappings from the mount command
into the kernel. I'm thinking about allowing a mount option called
uidmap and one called gidmap which both take a filename as argument.
This file could look like so:
============================
# Syntax:
# local id = remote id
1000 = 1005
1001 = 1003
1002 = 1002
default = 1000
1004 = default
============================
...or something like that. I just haven't quite figured out how to have
mount read these options and pass it to the kernel to populate these map
tables. Any pointers would be greatly appreciated.
The patches to the VFS system are in place, I just want to test them
some more before posting them anywhere.

Looking forward to your input!

-- 
Søren Hansen <sh@warma.dk>

