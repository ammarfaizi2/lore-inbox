Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262341AbVBKVOM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262341AbVBKVOM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Feb 2005 16:14:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262343AbVBKVOM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Feb 2005 16:14:12 -0500
Received: from eeout.etn.com ([63.67.43.145]:30522 "EHLO
	pitpashub01.nasa.ad.etn.com") by vger.kernel.org with ESMTP
	id S262341AbVBKVOH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Feb 2005 16:14:07 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.0.6603.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: Self-destruct in 5 seconds?
Date: Fri, 11 Feb 2005 16:13:57 -0500
Message-ID: <F0A064EBC8C91C449244D108367426DC0206556E@ra1ncsmb01.nasa.ad.etn.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Self-destruct in 5 seconds?
Thread-Index: AcUQfu748FByGorMR06bKwU9uD11EA==
From: "Creech, Matthew" <MattCreech@eaton.com>
To: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 11 Feb 2005 21:13:57.0895 (UTC) FILETIME=[999B6970:01C5107E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I posted this to the linux-arm mailing list, and Russell King referred
me to the main list.

I'm running an AT91RM9200DK-based board with the 2.6.10 kernel.  I'm
trying to use TmpFS for my root so I don't have a hard-coded ramdisk
size.  My /linuxrc script looks something like this:

mount -t tmpfs tmpfs /mnt/tmp
mkdir /mnt/tmp/initrd

[ copy files from / to /mnt/tmp ]

mount -t devfs devfs /mnt/tmp/dev
echo "Changing mount points..."
cd /mnt/tmp
pivot_root . initrd
cd /
mount -t proc proc /proc
exec chroot . /sbin/init <dev/console >dev/console 2>&1

Init then kicks off a "sysinit" script that immediately does this:

echo "Unmounting old root..."
umount /initrd
echo "Freeing initrd..."
freeramdisk /dev/rd/0

This actually works fine.  The system boots properly, my memory usage
looks good, etc.  But this is what prints to the screen, and it's pretty
scary looking:

Unmounting old root...
VFS: Busy inodes after unmount. Self-destruct in 5 seconds.  Have a nice
day...
Freeing initrd...

Although things seem to work [consistently - it does it every time
during boot], this message frightens me.  Is it safe to ignore, or is my
embedded device about to self-destruct?  :)  Thanks for the help

-- 
Matthew L. Creech 
