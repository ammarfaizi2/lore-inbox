Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263937AbSJHADF>; Mon, 7 Oct 2002 20:03:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263938AbSJHADF>; Mon, 7 Oct 2002 20:03:05 -0400
Received: from air-2.osdl.org ([65.172.181.6]:32680 "EHLO cherise.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S263937AbSJHADC>;
	Mon, 7 Oct 2002 20:03:02 -0400
Date: Mon, 7 Oct 2002 17:11:04 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@cherise.pdx.osdl.net
To: torvalds@transmeta.com
cc: linux-kernel@vger.kernel.org
Subject: [bk/patch] Rename driverfs to kfs
Message-ID: <Pine.LNX.4.44.0210071701460.16276-100000@cherise.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hey there.

It's the incredible mutable filesystem. As was talked about at the Kernel
Summit in Ottawa, and as has been threatened in the past three months,
here is the patch to rename driverfs to kfs. 

It's really simple, and is basically a global search and replace of all
the direct users of driverfs (so far only the driver model and acpi), as 
well as the documentation.

As a result of this, you must of course update your /etc/fstab to mount 
kfs instead of driverfs. 

Please apply. 


	-pat

Please pull from 

	bk://ldm.bkbits.net/linux-2.5-kfs

This will update the following files:

 Documentation/filesystems/driverfs.txt   |  330 -----------
 drivers/acpi/driverfs.c                  |   46 -
 fs/driverfs/Makefile                     |    9 
 fs/driverfs/inode.c                      |  706 ------------------------
 include/linux/driverfs_fs.h              |   70 --
 Documentation/driver-model/binding.txt   |    4 
 Documentation/driver-model/bus.txt       |    4 
 Documentation/driver-model/class.txt     |    8 
 Documentation/driver-model/device.txt    |    6 
 Documentation/driver-model/driver.txt    |    6 
 Documentation/driver-model/interface.txt |    2 
 Documentation/driver-model/overview.txt  |   12 
 Documentation/filesystems/kfs.txt        |  333 +++++++++++
 drivers/acpi/Makefile                    |    2 
 drivers/acpi/acpi_bus.h                  |    4 
 drivers/acpi/driverfs.c                  |    2 
 drivers/acpi/kfs.c                       |   66 +-
 drivers/base/core.c                      |   12 
 drivers/base/fs/bus.c                    |   20 
 drivers/base/fs/class.c                  |   30 -
 drivers/base/fs/device.c                 |   30 -
 drivers/base/fs/driver.c                 |   12 
 drivers/base/fs/intf.c                   |    8 
 drivers/base/interface.c                 |    2 
 fs/Makefile                              |    2 
 fs/kfs/Makefile                          |    9 
 fs/kfs/inode.c                           |  900 +++++++++++++++++++++++++++----
 include/linux/device.h                   |    2 
 include/linux/kfs.h                      |   86 ++
 29 files changed, 1357 insertions(+), 1366 deletions(-)

through these ChangeSets:

<mochel@osdl.org> (02/10/07 1.573.1.140)
   kfs documentation: s/driverfs/kfs/g in driver model and kfs docs.
   
   Also, move Documentation/filesystems/driverfs.txt to 
   Documentation/filesystems/kfs.txt.

<mochel@osdl.org> (02/10/07 1.573.1.139)
   kfs: s/driverfs/kfs/ for kfs API calls and their users in the kernel.

<mochel@osdl.org> (02/10/07 1.573.1.138)
   ACPI: move driverfs.c to kfs.c

<mochel@osdl.org> (02/10/07 1.573.1.137)
   kfs: s/driverfs/kfs/ for internal functions. 
   
   The API still is not affected. 
   
   init_kfs_fs() is now a core_initcall and happens implicitly, instead of being explicitly
   called from the driver model init.

<mochel@osdl.org> (02/10/07 1.573.1.136)
   Rename driverfs to kfs: directories and header files.
   
   This doesn't change the API at all; it only moves fs/driverfs to fs/kfs and 
   changes the name of hte header file. 
   
   All the users of the header have been updated.
   
   Also, the name in the fs_type is changed, so it shows up as kfs in /proc/filesystems
   and must be mounted as such.


