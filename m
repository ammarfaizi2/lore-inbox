Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261501AbSJAHPA>; Tue, 1 Oct 2002 03:15:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261503AbSJAHPA>; Tue, 1 Oct 2002 03:15:00 -0400
Received: from c66-235-4-135.sea2.cablespeed.com ([66.235.4.135]:30822 "EHLO
	darklands.zimres.net") by vger.kernel.org with ESMTP
	id <S261501AbSJAHO6>; Tue, 1 Oct 2002 03:14:58 -0400
Date: Tue, 1 Oct 2002 00:16:58 -0700
From: Thomas Zimmerman <thomas@zimres.net>
To: linux-kernel@vger.kernel.org
Subject: 2.5.39: Sleeping function/ Oops
Message-Id: <20021001001658.526be4a3.thomas@zimres.net>
X-Mailer: Sylpheed version 0.8.2 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1"; boundary="=./uZX.YT+c:2Hy1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=./uZX.YT+c:2Hy1
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

After the request for more testers (after a backup) I d/l'ed and
compiled 2.5.39. My setup isn't trivial, but should be fine for 2.6; SiS
chipset, athlon 1gzH, 512Mem, pci promis ide controler, softraid 0 and
5. This is a gentoo install that loves devfs for some reason (I've
always found the paths to be overly long.)

Anyway, right after partition detection ide-scsi detection of my old
no-brand cdrw drive and dvd drive triped this (written down):"
SCSI subsystem driver Revision: 1.0
request_module[scsi_hostadapter]: not ready
request_module[scsi_hostadapter]: not ready
Sleeping function called from illegal context at
/mnt/src/linux-2.4.39/include/asm/semaphore.h:119
...
...
Call trace:
driverfs_create_file+0x57
get_device+0xc1
device_create_file+0x35
pci_pool_create+0x11c
snprintf+0x26
hcd_buffer_create+0x72
usbdev_open+0x52
usb_hcd_pci_probe+0x18a
allac_inode+0x18a
pci_device_probe+0x58
probe+0x22
found_match+0x2b
do_driver_attach+0x5a
bus_for_each_dev+0x79
driver_attach+0x20
do_driver_attach+0x0
driver_register+0x75
pci_register_driver+0x3d
init+0x3d
init+0x0
kernel_thread_helper+0x5"

Next problem: after autoraid start fails on md0 (a made of 3 10gig
partitions on 3 drives; 2 on the SiS ide; 1 on promise ide) it Oops:"
...
...
eip: 0060:[c02479cc]	Not tainted
eflags: 00010286
eip is at export_rdev+0xc/0xa0
...
Proccess raidstart (pid 2242, threadinfo=df192000 task=df6b930)
...
autostart_array+0x6d/0x150
md_ioctl+0x4ab/0x560
devfs_open+0x1c1/0x1d0
get_empty_flip+0x16a/0x160
dentry_open+0x16a/0x160
filp_open+0x60/0x70
blkdev_ioctl+0xbb/0x110
sys_soctl+0xc1/0x320
sys_call+0x7/0xb

Code: 8b 43 14 85 c0 74 04 0f b7 50 10 89 14 24 e8 21 5f f2 ff c7
"

Additional info available on request.

/me back to the safty of 2.4.19-ck7 and a softraid rebuild


Thomas

--=./uZX.YT+c:2Hy1
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9mUvuOStTnUTb5R8RAsajAJ40H0xIdnv5IBKpp1Z7CPM/aJsPyACfRYM8
S9pXkT/76DKsXPYBj6TwyIg=
=H5tT
-----END PGP SIGNATURE-----

--=./uZX.YT+c:2Hy1--
