Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262449AbTARFMw>; Sat, 18 Jan 2003 00:12:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262452AbTARFMw>; Sat, 18 Jan 2003 00:12:52 -0500
Received: from luyer.net ([203.62.148.69]:4992 "EHLO luyer.net")
	by vger.kernel.org with ESMTP id <S262449AbTARFMv>;
	Sat, 18 Jan 2003 00:12:51 -0500
Date: Sat, 18 Jan 2003 16:21:31 +1100
From: David Luyer <david@luyer.net>
Message-Id: <200301180521.h0I5LVkD001333@luyer.net>
To: arjanv@redhat.com
Subject: Two ataraid suggestions
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have an A7V333 so I unfortunately have to use ataraid to use my ata133
drives (if I set up normal filesystems taking up the full drive, then
the BIOS complains no array is present and automatically creates one,
yuck; and I don't know what sector[s] to avoid to make the BIOS believe
an array is present and leave my drives alone).

Suggestion 1: help text which would inform the user of what to do to avoid
using ataraid on controllers which insist on using it (eg. set both disks
up as independant arrays and avoid creating partitions covering certain
areas of disks)

Suggestion 2: [option to] ignore ataraid normal rules when swapping onto
raid1 and instead use full space for swap rather than keeping two copies
of swap

Suggestion 3: (actually a bug) - cfdisk/fdisk partition table re-read
fails for ataraid in stock 2.4.20 (I can't run the new IDE code, I get
an oops on boot [partial traceback sent to the list weeks ago], so I
can't test newer kernels but assume this bug remains as it's not mentioned
in the changelogs).

And a question - I've told the BIOS my entire drives should be a RAID1
array, and then partitioned and set up /dev/ataraid/d0 etc.  Can I now
set Linux to use MD on the /dev/hd[eg][0-3] partitions and completely
ignore the ataraid driver?  ie, is the partition table as read from
the raw disk now correct and avoiding any RAID reserved sectors even
if the disks are accessed directly?  It appears like this is quite
possibly the case, that a RAID1 array on two identical disks set up
using ataraid can later be used via normal MD devices.

David.
