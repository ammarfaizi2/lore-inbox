Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265883AbUBJOSW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 09:18:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265900AbUBJOSW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 09:18:22 -0500
Received: from [217.157.19.70] ([217.157.19.70]:61964 "EHLO jehova.dsm.dk")
	by vger.kernel.org with ESMTP id S265883AbUBJOSS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 09:18:18 -0500
Date: Tue, 10 Feb 2004 14:18:15 +0000 (GMT)
From: Thomas Horsten <thomas@horsten.com>
X-X-Sender: thomas@jehova.dsm.dk
To: linux-kernel@vger.kernel.org, <linux-raid@vger.kernel.org>
Subject: ATARAID userspace configuration tool
Message-ID: <Pine.LNX.4.40.0402101405190.25784-100000@jehova.dsm.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm writing a userspace utility to detect/configure Medley (and later
other) ataraid devices in 2.6.

It's intended to run from initramfs (or initrd for those who use that).

I have a couple of questions and requests for clarification.

- Is there a "recommended" way to enumerate all block devices (not
partitions) from userside? Since this is ATA RAID, I could of course just
read the ideX majors from /proc/devices and try all the minors, but I
would prefer to get a list of all detected block devices in a portable
way.

- After I have used the DM (and possible MD for some RAID types) to map
the ataraid devices, is there a way to remove the partitions from the
underlying disks from the kernel? This was my main reason for wanting to
do kernel-level autodetection of these arrays, so I could prevent add_disk
from being called and analysing the partition table (on these BIOS RAIDs,
in striped mode the first disk contains the partition table for the entire
array in sector 0, and if the user (or a script) tries to mount the
partitions (or even read the extended partition table) it may try to read
after the end of the disk and will in any case use wrong sector numbers -
leading to possible disk corruption.

On top of this it would be useful to make the underlying devices
inaccessible after the mapped device is created (to prevent people from
doing things like fdisk /dev/hda, when what they really wanted was
something like fdisk /dev/ataraid/disc).

Detecting the partition table in userspace would fix this, but it's not
planned before 2.7 and I don't think it is safe to leave the false
partitions exposed.

- Some RAID types will need (I think) to use the MD framework as well as
DM (e.g. RAID0+1), so the device the users would be the md device which
would be composed of two dm devices. Is there a way to hide the underlying
dm devices from the user so he they only see the ones they should use (or
prevent these from being used directly some other way)?

// Thomas

