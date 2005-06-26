Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261382AbVFZBEZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261382AbVFZBEZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Jun 2005 21:04:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261428AbVFZBEZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Jun 2005 21:04:25 -0400
Received: from mail-1.netbauds.net ([62.232.161.102]:15327 "EHLO
	mail-1.netbauds.net") by vger.kernel.org with ESMTP id S261382AbVFZBDR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Jun 2005 21:03:17 -0400
Message-ID: <42BDFEC2.3030004@netbauds.net>
Date: Sun, 26 Jun 2005 02:02:58 +0100
From: "Darryl L. Miles" <darryl@netbauds.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-GB; rv:1.8b) Gecko/20050217
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.12 initrd module loading seems parallel on bootup
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



The kernel is panic'ed trying to mount even before the sym53c8xx driver 
has completed SCSI bus detection, the MD driver does not find any 
volumes (since neither the cpqarray.ko or sym53c8xx.ko have registered 
any disks on the system yet).

I have also witnessed (when booting 2.6.12.1) what appeared to be 
ext3.ko load failure, I think due to jbd.ko not having chance to 
register its exported symbols before ext3.ko needs to find them.


The broken sequence on 2.6.12 (excuse any errors, this has been typed in 
not pasted) it would be handy to allow Shift-Page Up to work from a 
panic, "unable to mount root" or "unable to exec init" if that were 
possible.

You can see the out of place "input: AT Translated Set 2 keyboard on 
isa0060/serio0" and "Compaq SMART2 Driver (v 2.6.0)" the elapsed time to 
print all these messages is < 1.5 seconds.

RedHat nash version 4.1.18 stable
Mounting /proc filesystem
Mounting sysfs
Creating /dev
Starting udev
input: AT Translated Set 2 keyboard on isa0060/serio0
Loading scsi_mod.ko module
Loading sd_mod.ko module
SCSI subsystem initialized
Loading scsi_transport_spi.ko module
Loading sym53c8xx.ko module
Loading cpqarray.ko module
Loading raid1.ko module
Loading jbd.ko module
Loading ext3.ko module
ACPI: PCI interrupt 0000:05:04.0[A] -> GSI 22 (level, low) -> IRQ 169
sym0: <896> rev 0x5 at pci 0000:05:04.0 irq 177
Compaq SMART2 Driver (v 2.6.0)
sym0: No NVRAM, ID 7, Fast-40, LVD, parity checking
sym0: SCSI BUS has been reset.
scsi0 : sym-2.2.0
md: raid1 personality registered as nr 3
md: Autodetecting RAID arrays.
md: ... autorun DONE.
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.

Creating root device
Mounting root filesystem
mount: error 19 mounting ext3
mount: error 2 mounting none
Switching to new root
switchroot: mount failed: 22
umount /initrd /dev failed: 2
kernel panic - not syncing: Attempted to kill init!
<0>Rebooting in 240 seconds...



The following is what a healthy 2.6.11.12 bootup on the same system looks like:


Freeing unused kernel memory: 232k freed
SCSI subsystem initialized
Compaq SMART2 Driver (v 2.6.0)
cpqarray: Device 0xae10 has been found at bus 6 dev 0 func 0
ACPI: PCI interrupt 0000:06:00.0[A] -> GSI 30 (level, low) -> IRQ 169
cpqarray: Finding drives on ida0 (Smart Array 3200)
cpqarray ida/c0d0: blksz=512 nr_blks=35561280
cpqarray ida/c0d1: blksz=512 nr_blks=71130720
cpqarray ida/c0d2: blksz=512 nr_blks=17764320
cpqarray ida/c0d3: blksz=512 nr_blks=35838720
 ida/c0d0: p1 p2
 ida/c0d1: p1
 ida/c0d2: p1 p2
 ida/c0d3: p1
ACPI: PCI interrupt 0000:05:04.0[A] -> GSI 22 (level, low) -> IRQ 177
sym0: <896> rev 0x5 at pci 0000:05:04.0 irq 177
sym0: No NVRAM, ID 7, Fast-40, LVD, parity checking
sym0: SCSI BUS has been reset.
scsi0 : sym-2.1.18n
  Vendor: COMPAQ    Model: BD30088279        Rev: HPB0
  Type:   Direct-Access                      ANSI SCSI revision: 03
sym0:0:0: tagged command queuing enabled, command queue depth 16.
 target0:0:0: Beginning Domain Validation
sym0:0: wide asynchronous.
sym0:0: FAST-40 WIDE SCSI 80.0 MB/s ST (25.0 ns, offset 31)
 target0:0:0: Ending Domain Validation
SCSI device sda: 585937500 512-byte hdwr sectors (300000 MB)
SCSI device sda: drive cache: write through
SCSI device sda: 585937500 512-byte hdwr sectors (300000 MB)
SCSI device sda: drive cache: write through
 sda: sda1 sda2 sda3 sda4
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
  Vendor: COMPAQ    Model: BD30088279        Rev: HPB0
  Type:   Direct-Access                      ANSI SCSI revision: 03
sym0:4:0: tagged command queuing enabled, command queue depth 16.
 target0:0:4: Beginning Domain Validation
sym0:4: wide asynchronous.
sym0:4: FAST-40 WIDE SCSI 80.0 MB/s ST (25.0 ns, offset 31)
 target0:0:4: Ending Domain Validation
SCSI device sdb: 585937500 512-byte hdwr sectors (300000 MB)
SCSI device sdb: drive cache: write through
SCSI device sdb: 585937500 512-byte hdwr sectors (300000 MB)
SCSI device sdb: drive cache: write through
SCSI device sdb: drive cache: write through
 sdb: sdb1 sdb2 sdb3 sdb4
Attached scsi disk sdb at scsi0, channel 0, id 4, lun 0
ACPI: PCI interrupt 0000:05:04.1[B] -> GSI 21 (level, low) -> IRQ 185
sym1: <896> rev 0x5 at pci 0000:05:04.1 irq 185
sym1: No NVRAM, ID 7, Fast-40, LVD, parity checking
sym1: SCSI BUS has been reset.
scsi1 : sym-2.1.18n
md: raid1 personality registered as nr 3
md: Autodetecting RAID arrays.
md: invalid raid superblock magic on sda4
md: sda4 has invalid sb, not importing!
md: invalid raid superblock magic on sdb4
md: sdb4 has invalid sb, not importing!
md: autorun ...
md: considering sdb3 ...
md:  adding sdb3 ...
md: sdb2 has different UUID to sdb3
md: sdb1 has different UUID to sdb3
md:  adding sda3 ...
md: sda2 has different UUID to sdb3
md: sda1 has different UUID to sdb3
md: created md2
md: bind<sda3>
md: bind<sdb3>
md: running: <sdb3><sda3>
raid1: raid set md2 active with 2 out of 2 mirrors
md: considering sdb2 ...
md:  adding sdb2 ...
md: sdb1 has different UUID to sdb2
md:  adding sda2 ...
md: sda1 has different UUID to sdb2
md: created md0
md: bind<sda2>
md: bind<sdb2>
md: running: <sdb2><sda2>
raid1: raid set md0 active with 2 out of 2 mirrors
md: considering sdb1 ...
md:  adding sdb1 ...
md:  adding sda1 ...
md: created md1
md: bind<sda1>
md: bind<sdb1>
md: running: <sdb1><sda1>
raid1: raid set md1 active with 2 out of 2 mirrors
md: ... autorun DONE.
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.

Hope this helps


-- 
Darryl L. Miles


