Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261746AbULOQQ0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261746AbULOQQ0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 11:16:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262376AbULOQQZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 11:16:25 -0500
Received: from h66-38-154-67.gtcust.grouptelecom.net ([66.38.154.67]:38608
	"EHLO pbl.ca") by vger.kernel.org with ESMTP id S261746AbULOQQI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 11:16:08 -0500
Message-ID: <41C06344.7030101@pbl.ca>
Date: Wed, 15 Dec 2004 10:16:04 -0600
From: Aleksandar Milivojevic <amilivojevic@pbl.ca>
User-Agent: Mozilla Thunderbird 0.8 (X11/20041020)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RAID1 + LVM not detected during boot on 2.6.9
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------030901050906050205080401"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030901050906050205080401
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

I've installed one machine (Fedora Core 3 distro) with /boot on  RAID1 
device (md0) and all other filesystems on LVM volumes located on another 
RAID1 device (md1).  There was only one volume group, with couple of 
volumes for file systems (one of them was root file system).

The installation went fine, however when I try to reboot machine, Linux 
kernel is unable to detect LVM volumes, and panics since it can't find 
root file system.  I see messages saying that it is searching for LVM 
volumes, but it dosn't find any.

If I boot into rescue mode from CD (also 2.6.9 kernel), and let Fedora 
installer search for existing installations, all volumes are found and I 
can mount root file system.

At first I suspected that I was missing some modules from initrd image, 
and attempted to recreate it by hand.  However that hasn't worked (I've 
attached mkinitrd -v output).  It seems that all needed modules and 
config files are present in initrd image (SCSI, RAID, DM, and ext3 file 
system).

I do remember having this very same setup working on kernel 2.6.5.

-- 
Aleksandar Milivojevic <amilivojevic@pbl.ca>    Pollard Banknote Limited
Systems Administrator                           1499 Buffalo Place
Tel: (204) 474-2323 ext 276                     Winnipeg, MB  R3T 1L7

--------------030901050906050205080401
Content-Type: text/plain;
 name="mk.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mk.txt"

Creating initramfs
Looking for deps of module scsi_mod	
Looking for deps of module sd_mod	 scsi_mod
Looking for deps of module scsi_mod	
Looking for deps of module unknown	
Looking for deps of module sym53c8xx	 scsi_transport_spi scsi_mod
Looking for deps of module scsi_transport_spi	 scsi_mod
Looking for deps of module scsi_mod	
Looking for deps of module scsi_mod	
Looking for deps of module ide-disk	
Looking for deps of module dm-mod	
Looking for deps of module raid1	
Looking for deps of module ext3	 jbd
Looking for deps of module jbd	
Looking for deps of module dm-mod	
Looking for deps of module dm-mirror	 dm-mod
Looking for deps of module dm-mod	
Looking for deps of module dm-zero	 dm-mod
Looking for deps of module dm-mod	
Looking for deps of module dm-snapshot	 dm-mod
Looking for deps of module dm-mod	
Using modules:  ./kernel/drivers/scsi/scsi_mod.ko ./kernel/drivers/scsi/sd_mod.ko ./kernel/drivers/scsi/scsi_transport_spi.ko ./kernel/drivers/scsi/sym53c8xx_2/sym53c8xx.ko ./kernel/drivers/md/dm-mod.ko ./kernel/drivers/md/raid1.ko ./kernel/fs/jbd/jbd.ko ./kernel/fs/ext3/ext3.ko ./kernel/drivers/md/dm-mirror.ko ./kernel/drivers/md/dm-zero.ko ./kernel/drivers/md/dm-snapshot.ko
/sbin/nash -> /tmp/initrd.qC1073/bin/nash
/sbin/insmod.static -> /tmp/initrd.qC1073/bin/insmod
/sbin/udev.static -> /tmp/initrd.qC1073/sbin/udev
/etc/udev/udev.conf -> /tmp/initrd.qC1073/etc/udev/udev.conf
`/lib/modules/2.6.9-1.667/./kernel/drivers/scsi/scsi_mod.ko' -> `/tmp/initrd.qC1073/lib/scsi_mod.ko'
`/lib/modules/2.6.9-1.667/./kernel/drivers/scsi/sd_mod.ko' -> `/tmp/initrd.qC1073/lib/sd_mod.ko'
`/lib/modules/2.6.9-1.667/./kernel/drivers/scsi/scsi_transport_spi.ko' -> `/tmp/initrd.qC1073/lib/scsi_transport_spi.ko'
`/lib/modules/2.6.9-1.667/./kernel/drivers/scsi/sym53c8xx_2/sym53c8xx.ko' -> `/tmp/initrd.qC1073/lib/sym53c8xx.ko'
`/lib/modules/2.6.9-1.667/./kernel/drivers/md/dm-mod.ko' -> `/tmp/initrd.qC1073/lib/dm-mod.ko'
`/lib/modules/2.6.9-1.667/./kernel/drivers/md/raid1.ko' -> `/tmp/initrd.qC1073/lib/raid1.ko'
`/lib/modules/2.6.9-1.667/./kernel/fs/jbd/jbd.ko' -> `/tmp/initrd.qC1073/lib/jbd.ko'
`/lib/modules/2.6.9-1.667/./kernel/fs/ext3/ext3.ko' -> `/tmp/initrd.qC1073/lib/ext3.ko'
`/lib/modules/2.6.9-1.667/./kernel/drivers/md/dm-mirror.ko' -> `/tmp/initrd.qC1073/lib/dm-mirror.ko'
`/lib/modules/2.6.9-1.667/./kernel/drivers/md/dm-zero.ko' -> `/tmp/initrd.qC1073/lib/dm-zero.ko'
`/lib/modules/2.6.9-1.667/./kernel/drivers/md/dm-snapshot.ko' -> `/tmp/initrd.qC1073/lib/dm-snapshot.ko'
/sbin/lvm.static -> /tmp/initrd.qC1073/bin/lvm
/etc/lvm -> /tmp/initrd.qC1073/etc/lvm
`/etc/lvm/lvm.conf' -> `/tmp/initrd.qC1073/etc/lvm/lvm.conf'
Loading module scsi_mod
Loading module sd_mod
Loading module scsi_transport_spi
Loading module sym53c8xx
Loading module dm-mod
Loading module raid1
Loading module jbd
Loading module ext3
Loading module dm-mirror
Loading module dm-zero
Loading module dm-snapshot

--------------030901050906050205080401--
