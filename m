Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268219AbTALEI7>; Sat, 11 Jan 2003 23:08:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268223AbTALEI7>; Sat, 11 Jan 2003 23:08:59 -0500
Received: from tomts8.bellnexxia.net ([209.226.175.52]:53895 "EHLO
	tomts8-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S268219AbTALEI4>; Sat, 11 Jan 2003 23:08:56 -0500
Date: Sat, 11 Jan 2003 23:17:46 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@dell
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: more thoughts on kernel config organization
Message-ID: <Pine.LNX.4.44.0301112300570.20815-100000@dell>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  since i've been whining about the (in some places, very
non-intuitive) layout of kernel configuration options, i'm
going to play with designing a different structure for some
of the submenus.  and number one on my list is the filesystems
menu, which is pretty thoroughly random.

  starting at what seems to be a pretty arbitrary choice
(quota support?  how did that end up at the top of the list?),
we then get "automounter" (again, a bit premature, it seems),
then reiserfs(??), and a bunch of experimental filesystems
before getting to ext3, which doesn't really flow well.

  then we jump to DOS filesystems, bounce around a bit more,
on to JFS (why is this not next to reiserfs?), etc, etc.
and, near that bottom of the list, ext2??

  how about something like

  ext2
  ext3
  reiser
  XFS
  JFS
  quotas
  MS/DOS related filesystems
    MD-DOS
    VFAT
    NTFS
  other OS-related filessytems
    Apple
    ADFS
    BeOS
    BFS
    QNX
    System V/XENIX/...
  Pseudo(?) filessytems
    /proc
    /dev/pts
    /dev

etc, etc.  i know i'm leaving plenty out since i'm typing this
stream-of-consciousness.  but you get the idea.  i'd like to see
the most common choices at the top of the list, and the uncommon/
legacy/experimental further down, where fewer people will care
about that stuff.

  also, there are at least a couple places in that xconfig
meny that seem incorrectly-structured.  example: ext3 -> JBD.
JBD is a sub-option of ext3, but it shows up at the same
indentation level.  it should, based on hierarchy, be one
level indented, at the same level as ext3 extended attributes
to be a proper sub-option.

  same complaint about VFAT being a sub-option of DOS FAT fs
support, but not being indented properly.

  thoughts?

rday

p.s.  i guess i could just learn the menu-layout language
and mock something up, just for fun.

