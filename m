Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267433AbTB1DEh>; Thu, 27 Feb 2003 22:04:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267436AbTB1DEh>; Thu, 27 Feb 2003 22:04:37 -0500
Received: from h-64-105-34-105.SNVACAID.covad.net ([64.105.34.105]:53378 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S267433AbTB1DEg>; Thu, 27 Feb 2003 22:04:36 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Thu, 27 Feb 2003 19:14:48 -0800
Message-Id: <200302280314.TAA11682@baldur.yggdrasil.com>
To: miquels@cistron-office.nl
Subject: Re: Patch: 2.5.62 devfs shrink
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

miquels@cistron-office.nl wrote:
>If you're making it not 100% compatible anyway, now is the time
>to do away with that horrible 'disc' spelling ;). 'disk' is a
>harddisk or floppy disk, 'disc' is for compact disc (try Google
>on both spellings and you'll see that the world agrees ..).
>Just do s/disc/disk/g in devfs_register().

	The names of devices are not chosen by fs/devfs/*.[ch].  They
are chosen by the client code in device drivers and elsewhere that
call call devfs.  In the case of the /dev/discs/ names, they are
chose by devfs_{create,remove}_partitions in fs/partitions/check.c,
which, from the comments, was apparently written by Linus Torvalds
and Russell King.

Tangential note:	

	For what it's worth, my preference would be to change from
/dev/discs/disc0/part1 to /dev/disk/0/part1, but I think it would
probably do more harm than good to try to coordinate such a change
with switching devfs.  If you want to try to make a change where
people will eventually have to update their systems, I think it would
probably make more sense to survey existing devfs naming practices and
try to come up with some recommendations harmonize them a bit.  For
example, should the directory names be singular or plural (/dev/loop
or /dev/loops, /dev/disk or /dev/disks)?  I would recommend signular
because it is less English-centric.  There are probably four or five
recommendations like these that could be put into a Documentation
file.  More consistent naming schemes in anything tend to make
a system more readily usable.

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."
