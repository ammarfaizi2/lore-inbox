Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161228AbWJPKHL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161228AbWJPKHL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 06:07:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030343AbWJPKHK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 06:07:10 -0400
Received: from [62.77.196.1] ([62.77.196.1]:32137 "EHLO linux.dunaweb.hu")
	by vger.kernel.org with ESMTP id S1030342AbWJPKHJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 06:07:09 -0400
Message-ID: <4533598A.3040909@dunaweb.hu>
Date: Mon, 16 Oct 2006 12:06:02 +0200
From: Zoltan Boszormenyi <zboszor@dunaweb.hu>
User-Agent: Thunderbird 1.5.0.7 (X11/20061008)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Is there a way to limit VFAT allocation?
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have bought a 2GB MP3 player / flash disk
that erroneously partitions and formats its storage.
The built-in firmware has an off-by-one bug that
creates the partition one cylinder larger that the
disk size allows and then it formats the VFAT fs
according to the buggy partition size. No wonder
when I try to copy large amounts of data to the
flash disk it detects errors and then remounts it
read-only.

I tried to repartition and reformat it three times
with different mformat or mkdosfs options
but as soon as I remove it from the USB port,
the device detects changed disk format and
automatically reformats itself again, so it
stays buggy.

Here's the excerpt from the logs on one occasion
I tried to copy some large stuff onto it:

Oct  3 22:56:31 host-81-17-177-202 kernel: SCSI device sdb: 4095765 
512-byte hdwr sectors (2097 MB)
Oct  3 22:56:31 host-81-17-177-202 kernel: sdb: Write Protect is off
Oct  3 22:56:32 host-81-17-177-202 kernel: sdb: assuming drive cache: 
write through
Oct  3 22:56:32 host-81-17-177-202 kernel: SCSI device sdb: 4095765 
512-byte hdwr sectors (2097 MB)
Oct  3 22:56:32 host-81-17-177-202 kernel: sdb: Write Protect is off
Oct  3 22:56:32 host-81-17-177-202 kernel: sdb: assuming drive cache: 
write through
Oct  3 22:56:33 host-81-17-177-202 kernel:  sdb: sdb1
Oct  3 22:56:33 host-81-17-177-202 kernel:  sdb: p1 exceeds device capacity
Oct  3 22:56:33 host-81-17-177-202 kernel: sd 6:0:0:0: Attached scsi 
removable disk sdb
Oct  3 22:56:33 host-81-17-177-202 kernel: sd 6:0:0:0: Attached scsi 
generic sg1 type 0
Oct  3 22:56:33 host-81-17-177-202 kernel: sd 5:0:0:0: Attached scsi 
removable disk sdc
Oct  3 22:56:33 host-81-17-177-202 kernel: sd 5:0:0:0: Attached scsi 
generic sg2 type 0
Oct  3 22:56:33 host-81-17-177-202 kernel: Buffer I/O error on device 
sdb1, logical block 4095616
Oct  3 22:56:34 host-81-17-177-202 kernel: Buffer I/O error on device 
sdb1, logical block 4095617
Oct  3 22:56:34 host-81-17-177-202 kernel: Buffer I/O error on device 
sdb1, logical block 4095618
Oct  3 22:56:34 host-81-17-177-202 kernel: Buffer I/O error on device 
sdb1, logical block 4095619
Oct  3 22:56:34 host-81-17-177-202 kernel: Buffer I/O error on device 
sdb1, logical block 4095620
Oct  3 22:56:34 host-81-17-177-202 kernel: Buffer I/O error on device 
sdb1, logical block 4095621
Oct  3 22:56:34 host-81-17-177-202 kernel: Buffer I/O error on device 
sdb1, logical block 4095622
Oct  3 22:56:34 host-81-17-177-202 kernel: Buffer I/O error on device 
sdb1, logical block 4095623
Oct  3 22:56:34 host-81-17-177-202 kernel: Buffer I/O error on device 
sdb1, logical block 4095616
Oct  3 22:56:34 host-81-17-177-202 kernel: Buffer I/O error on device 
sdb1, logical block 4095617
Oct  3 22:56:34 host-81-17-177-202 kernel: SELinux: initialized (dev 
sdb1, type vfat), uses genfs_contexts
...
Oct  3 23:26:53 host-81-17-177-202 kernel: FAT: Filesystem panic (dev sdb1)
Oct  3 23:26:53 host-81-17-177-202 kernel:     fat_get_cluster: invalid 
cluster chain (i_pos 0)
Oct  3 23:26:53 host-81-17-177-202 kernel:     File system has been set 
read-only
...
Oct  3 23:31:35 host-81-17-177-202 kernel: FAT: Filesystem panic (dev sdb1)
Oct  3 23:31:35 host-81-17-177-202 kernel:     fat_get_cluster: invalid 
cluster chain (i_pos 0)
Oct  3 23:35:33 host-81-17-177-202 kernel: FAT: Filesystem panic (dev sdb1)
Oct  3 23:35:33 host-81-17-177-202 kernel:     fat_bmap_cluster: request 
beyond EOF (i_pos 47395744)
Oct  3 23:35:33 host-81-17-177-202 kernel: FAT: Filesystem panic (dev sdb1)
Oct  3 23:35:33 host-81-17-177-202 kernel:     fat_bmap_cluster: request 
beyond EOF (i_pos 47395744)
Oct  3 23:35:33 host-81-17-177-202 kernel: FAT: Filesystem panic (dev sdb1)
Oct  3 23:35:33 host-81-17-177-202 kernel:     fat_bmap_cluster: request 
beyond EOF (i_pos 47395744)
Oct  3 23:35:33 host-81-17-177-202 kernel: FAT: Filesystem panic (dev sdb1)
Oct  3 23:35:33 host-81-17-177-202 kernel:     fat_bmap_cluster: request 
beyond EOF (i_pos 47395744)
...

Unfortunately, the firmware is not upgradeable.
The device in question is a Telstar UFM-102B.

Is there a way to tell the VFAT driver to exclude
the last N sectors from the allocation strategy?

Best regards,
Zoltán Böszörményi

