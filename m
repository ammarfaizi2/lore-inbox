Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261378AbTDBDBF>; Tue, 1 Apr 2003 22:01:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261379AbTDBDBF>; Tue, 1 Apr 2003 22:01:05 -0500
Received: from mail.casabyte.com ([209.63.254.226]:34821 "EHLO
	mail.1casabyte.com") by vger.kernel.org with ESMTP
	id <S261378AbTDBDBD>; Tue, 1 Apr 2003 22:01:03 -0500
From: "Robert White" <rwhite@casabyte.com>
To: "Linus Torvalds" <tordalds@transmeta.com>, <linux-kernel@vger.kernel.org>
Subject: RE: A more balanced view of user privileges
Date: Tue, 1 Apr 2003 19:12:26 -0800
Message-ID: <PEEPIDHAKMCGHDBJLHKGGEMICFAA.rwhite@casabyte.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <503755781.1049233111@resnet146-209.resnet.buffalo.edu>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4920.2300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

5.  The ephemeral user.  They can do anything but none of the things they
actually take place.  The system and kernel give them a consistent view of
the sum total of their actions, which lasts until they direct their sprit
elsewhere (log off).

[This clever combination of a tempfs cache/overlay of the whole file tree
and a clever pre-shell chroot to same, traps all modify and delete actions
to files and directories in a copy-on-use and white-out-of-deleted-items
system indistinguishable from the real system state.  Great for
pointy-headed bosses!]

/END AFJ

The A.F.J. elements aside... I have been contemplating just such a file
system meta-driver for prototyping and package building.  When the meta
driver is installed "on top of" two existing file systems, the cache-side
system will receive all the changes, while the back-side system will provide
the defaults.

Consider: mount -t ephfs -o backside=/ /dev/accumulated_state_fs
/some_mount_point ; chroot /some_mount_point /bin/bash

If the cache side is a tmpfs and the back-side is your existing root, then
you could run any script/program/etc in the ephemeral arena and then look
into just the cache-side to see the total modified system effect of that
action.

This would also be outstanding for putting in front of a read-only nfs
mount.  You could have one master NFS image for a group of diskless
workstations, and the init system/pattern would rotate in a ephfs as the new
root that was backed up by the real static root image.  Great for schools
and system in front-line or haxors-attractive settings.

If the cache-side is a more permanent media (a real FS or a loopback to a
file) you could do other, more interesting things too.  This would be Great
for printing up distributions, you could just "make install" that pesky
program and then tar up (make package, make RPM, whatever) the cache-side
FS.

I am still doing initial feasibility on this.

-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org]On Behalf Of Linus Torvalds
Sent: Tuesday, April 01, 2003 6:39 PM
To: linux-kernel@vger.kernel.org
Subject: A more balanced view of user priviliges


Hi folks,

I've always tried to keep our work separate from religious and political
influences, however I also feel that incorporating suggestions from all
categories of users is part of what makes Linux, and Open Source in
general, so great.

I was recently talking with a friend of mine who is a Lirpa Buddhist (of
the Lo'of school, to be specific).  He said that as it currently stands, we
have two types of user - the superuser, with absolute power over the
system, and the ordinary user, with no power.  We even occasionally refer
to systems administrators as God.  My Lipran friend believes that this
reflects an excessively Western thinking about the relationship between man
and God - a thinking which is so embedded in our culture that we seldom
realize it.  After some discussion with him, I have decided that as of
2.7.x we will fork the kernel to allow other ideas about priviledges.  In
particular, there will be a "Lipraite" version of the Kernel in which there
are seven categories of users:

1. The Creative User - can create any file but must then stand back and not
modify it;

2. The Destructive User - can delete any file, or shut the system down, at
which time (once hardware support is in place) it will rise from its own
ashes

3. The Force of Maintence - can change the system within fundamental
physical laws.  Can not, for example, load new device drivers.

4. Ordinary users, who are bound to the cycle of writing, compiling, and
debugging, until they achieve Nirvana and log out of the system.

More may be added as needed.

Hopefully with these changes Linux 2.7+ will be more friendly to a diverse
user population.

Linus
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

