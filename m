Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268511AbTBWQe4>; Sun, 23 Feb 2003 11:34:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268514AbTBWQe4>; Sun, 23 Feb 2003 11:34:56 -0500
Received: from tomts10.bellnexxia.net ([209.226.175.54]:22704 "EHLO
	tomts10-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S268511AbTBWQey>; Sun, 23 Feb 2003 11:34:54 -0500
Date: Sun, 23 Feb 2003 11:42:04 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@dell
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: even more thoughts on kernel configuration
Message-ID: <Pine.LNX.4.44.0302231125380.27864-100000@dell>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  a few more random thoughts on the kernel configuration process
and where it's going, and some of its weaknesses.

  first, there is an inherent inflexibility in the way some
of the menus are defined.  more specifically, there's a 
definite inconsistency in *who* defines the contents of a
menu.

  consider, for example, .../fs/Kconfig, which allegedly 
defines the menu entries for filesystems.  note that that
file *begins* with the menu definition

  menu "File systems"

what this means is that the config file *itself* is saying,
in effect, "this is it, these are the filesystems because i
say so, there can be no others."  by that file naming itself
as the filesystems menu, it does not give any other menu the
freedom to perhaps incorporate its contents in the middle
of an even larger menu which might include even more
filesystems.

  compare that with an entry near the the bottom of the very
same file, which sources a submenu for partition types:

  menu "Partition types"

  source "fs/partitions/Kconfig"

  endmenu

this is a far more reasonable approach since the sourced
file defines just the menu *entries*, and leaves it up to
the sourcing file to decide how it wants to incorporate that
information into a higher-level menu *and* what to call it.

  the better approach would seem to be, then, for a directory's
Kconfig file to simply supply the menu entry information, but
never define its own menu label -- that job would be up to
the sourcing file.  

  as it is, both approaches are scattered among the Kconfig files,
making it really confusing as to who gets to decide how a menu 
will be incorporated.

  taking this even further, having all the Kconfig info in a 
single file also makes the config process inflexible, since as
it stands, you have to include a lower-level Kconfig on an
all-or-nothing basis.  who says that should be the only 
possibility?

  the most flexible approach (and, granted, this is taking 
this idea to the extreme) would be for a source directory to 
include the config information on everything in that directory,
perhaps in individual, separate files, and the sourcing file
could decide, entry by entry, which entries to incorporate into
a menu, what order they would be in, and what the menu label
would be.  this simply pushes the menu creation decisions up
at least a level, where the ultimate decisions are made at 
the top level (which, in my opinion, is where they belong
anyway).  using that approach would introduce the freedom
to rearrange the menus right down at the individual entry
level.
  
  my final issue is with the EXPERIMENTAL dependency, which
is, quite frankly, not a dependency at all.

  at the moment, the way experimental options are included or
excluded is based on the "depends on" clause.  but this is
really inappropriate since EXPERIMENTAL is not a dependency --
it's more a selection criteria and is completely arbitrary.

  consider -- the option REISERFS_CHECK depends on REISERFS_FS.
now *that's* a dependency -- without the latter, you simply
cannot have the former.

  but whether something is "EXPERIMENTAL" is nothing more than
a judgment call.  at some point, after enough testing, something
which was EXPERIMENTAL is finally accepted as a mainstream option.
i think it's inappropriate to use the "depends on" clause to 
represent both real dependencies and arbitrary selection.

  in addition, who's to say that there should be only one
level of EXPERIMENTAL?  i own a sharp zaurus running the
openzaurus OS, and there are three "feeds" from which i can
download software: stable, testing and unstable.  and this
seems like a reasonable approach since there's nothing that
says that software can't be in three (or even more) states
of dependability.  you could have "stable", as in thoroughly
tested, "testing", as in still under test but fairly stable
and any obvious bugs worked out, and "bleeding edge", as in
really out there, you can try it if you want but it it blows
up your system, you get to keep the pieces (think NTFS).

  it would be far more useful and flexible to remove this
concept as a dependency and perhaps introduce a new config
option, like "status", which could have new levels introduced
at any time.  the final selection would be made from the top
level menu, based on user selection.

  anyway, just some random thoughts.

rday

