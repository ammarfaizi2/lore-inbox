Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131275AbRC3KWj>; Fri, 30 Mar 2001 05:22:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131305AbRC3KWa>; Fri, 30 Mar 2001 05:22:30 -0500
Received: from arbi.informatik.uni-oldenburg.de ([134.106.1.7]:22790 "EHLO
	arbi.Informatik.Uni-Oldenburg.DE") by vger.kernel.org with ESMTP
	id <S131275AbRC3KWT>; Fri, 30 Mar 2001 05:22:19 -0500
From: "Jochen Hoenicke" <Jochen.Hoenicke@Informatik.Uni-Oldenburg.DE>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15044.24107.858836.866924@huxley.Informatik.Uni-Oldenburg.DE>
Date: Fri, 30 Mar 2001 12:21:31 +0200 (MET DST)
To: linux-kernel@vger.kernel.org
CC: andre@linux-ide.org
Subject: Bug in EZ-Drive remapping code (ide.c)
X-Mailer: VM 6.75 under 20.0 XEmacs Lucid (beta28)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

The EZ-Drive remapping code remaps to many sectors, if they are read
together with sector 0 in one bunch.  This is even documented:

>From linux-2.4.0/drivers/ide/ide.c line 1165:
/* Yecch - this will shift the entire interval,
   possibly killing some innocent following sector */

This problem hit a GRUB user using linux-2.4.2 but it exists for a
long time; the remapping code is already in 2.0.xx.  The reason that
nobody cares is probably because there are only a few programs that
access /dev/hda directly.

GRUB is a boot loader that normally runs under plain BIOS but there is
also a wrapper to run it under linux and other unixes.  Because it
shares most code with its BIOS derivate it accesses the disk the hard
way, reading directly from /dev/hda and interpreting the file system
with its own (read-only) file system drivers.

This is what happened: Grub reads the first track in one bunch and
since a track has an odd number of sectors, linux adds the first
sector of the next track to this bunch.  This sector contains the boot
sector of the first FAT partition.  The result of the remapping is
that grub can't access that partition.

Please CC me on reply.

  Jochen
