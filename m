Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267892AbTBYKVR>; Tue, 25 Feb 2003 05:21:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267896AbTBYKVR>; Tue, 25 Feb 2003 05:21:17 -0500
Received: from h-64-105-35-241.SNVACAID.covad.net ([64.105.35.241]:16592 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S267892AbTBYKVQ>; Tue, 25 Feb 2003 05:21:16 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Tue, 25 Feb 2003 02:23:18 -0800
Message-Id: <200302251023.CAA01067@adam.yggdrasil.com>
To: linux-kernel@vger.kernel.org
Subject: Patch: 2.5.62 devfs shrink
Cc: akpm@digeo.com, alistair@devzero.co.uk, cloos@jhcloos.com,
       elenstev@mesatop.com, jordan.breeding@attbi.com, maneesh@in.ibm.com,
       scole@lanl.gov, solarce@fallingsnow.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Here is an update to my patch to shrink devfs for linux-2.5.62.
The patch is a net deletion of 2407 lines.  It contains the following new
changes:

	- Maneesh Soni submitted a patch for operation with the
	  read-copy-update code, which was extremely good timing,
	  as that code apparently got integrated into 2.5.62.

	- Fixed a bug reported by Alistair Strachan where
	  pseudo-terminals could not be allocated by non-super-user
	  processes (devfs needed to set CAP_DAC_OVERRIDE in a couple
	  of places).

	- Restore the devfs=nomount option, to accomodate a distribution
	  compatability problem reported by Steven Cole.  devfs=nomount
	  suppresses the effect CONFIG_DEVFS_MOUNT--that is, mounting
	  of /dev before the kernel invokes /sbin/init.  Note: perhsps
	  we should eliminate CONFIG_DEVFS_MOUNT entirely.  I'll have
	  to check to see if it is needed by systems that boot directly
	  to a hardware device rather than to an initial ramdisk.


	Presumably because of the size of all of the "-" lines in the
patch, the linux-kernel mailing list filters it out, so I'll just post
a URL for it:

ftp://ftp.yggdrasil.com/pub/dist/device_control/devfs/smalldevfs-2.5.62-v10.patch

	Also, here is the URL for the latest devfs_helper user level
program (version 0.2, unchanged).  It is a reduced functionality
replacement for devfsd.

ftp://ftp.yggdrasil.com/pub/dist/device_control/devfs/devfs_helper-0.2.tar.gz


	I'll also describe my "to do" list for this software, in case
anyone spots something I've forgotten:

		- Submit a patch to the -mm kernels, as Andrew has been
		  kind enough to distribute this change in his -mm kernels.
		- Write a small FAQ list on moving from old devfs.
		- Remove CONFIG_DEVFS_MOUNT?
		- Probably request integration after linux-2.7.0.

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."
