Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268027AbTBRVUs>; Tue, 18 Feb 2003 16:20:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268030AbTBRVUr>; Tue, 18 Feb 2003 16:20:47 -0500
Received: from tomts17.bellnexxia.net ([209.226.175.71]:26057 "EHLO
	tomts17-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S268027AbTBRVUp>; Tue, 18 Feb 2003 16:20:45 -0500
Date: Tue, 18 Feb 2003 16:28:04 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@dell
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: a really annoying feature of the config menu structure
Message-ID: <Pine.LNX.4.44.0302181604310.23007-100000@dell>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  i finally decided to get serious and start looking at the
overall config menu structure, to re-arrange the menus and
submenus so that it made more sense and flowed more logically,
and i ran into a really annoying feature that makes it
virtually impossible to do this.  (this is all based on the
assumption that i haven't overlooked something obvious.)
so what's the problem?

  my plan was to start collecting some of the logically-related
menu entries together, and to have a main menu top-level entry,
and some submenus for more specific related sub-items.  some
of you may remember that i proposed something like this for
the filesystems menu.  

  other areas where this would have made sense would be for
something like a "Networking" main menu, with submenus for
things like ISDN, Wireless and so on, those all being 
subsets of networking.  it *sounded* like a good idea, but
the way the menus are laid out, this is going to be difficult.

  the main menu file appears to be .../arch/i386/Kconfig,
which defines some menus and "source"s others, and therein
lies the problem.  it's perfectly reasonable to source a
Kconfig file from a kernel subdirectory if that file 
represents a submenu -- such a file can be sourced in the
*middle* of a top-level menu definition, and will therefore
appear as a submenu in the config screen.

  however, those sourced files are, for the most part,
complete menu definitions on their own, so they *cannot*
have further submenus placed inside them, and this is
a pain when any of those are used directly in the top level
in the main Kconfig file.

  a perfect example is the menu for "Networking support".
this is obtained simply with

  source "net/Kconfig"

but since that file was (presumably) created by the person
who was looking after the networking code in that directory,
there is no way to source that file and simultaneously give
it some appropriate submenus, like ISDN, Wireless and so on.

  this is going to be the case with *every* autonomous
directory that comes with its own Kconfig file -- it will
never give the top-level Kconfig file the flexibility
to assign it any submenus, and this is pretty annoying
with something as generic as "Networking support".

  the only possible solution to make this work is to 
make sure each directory with its own Kconfig file never
assumes it's going to be a top-level menu -- it has to 
assume it might be incorporated as a submenu.

  another consequence is that it's a bad idea to have
top level menu entries *both* have config options *and*
submenus, as is done with "Power management" and "ACPI"
(and Filesystems for that matter).  a better solution is
for each kernel source directory to create and manage its
own Kconfig file and define its own menu, then design the
top-level file to act simply as a wrapper around all of these.

  another good example is "Multimedia", which would normally
include "Sound" configuration, wouldn't you think?  but as it
stands, this is currently impossible -- the Multimedia
menu is simply sourced from its directory, and there is no
way to assign it any submenus, like Sound, Video and others
that really belong there.

  as i see it, this can only get worse.  the current
erratic and disorganized structure of the config menus
is proof of that.

  comments?

rday


