Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964886AbVJZT3q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964886AbVJZT3q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Oct 2005 15:29:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964885AbVJZT3q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Oct 2005 15:29:46 -0400
Received: from odyssey.analogic.com ([204.178.40.5]:5380 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S964883AbVJZT3p convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Oct 2005 15:29:45 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <435FC886.7070105@rhla.com>
References: <435FC886.7070105@rhla.com>
X-OriginalArrivalTime: 26 Oct 2005 19:29:36.0481 (UTC) FILETIME=[99AD3510:01C5DA63]
Content-class: urn:content-classes:message
Subject: Re: Kernel Panic + Intel SATA
Date: Wed, 26 Oct 2005 15:29:25 -0400
Message-ID: <Pine.LNX.4.61.0510261523350.6174@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Kernel Panic + Intel SATA
Thread-Index: AcXaY5m0VNKv5HrvRUanxFpbYX5a8g==
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: =?iso-8859-1?Q?M=E1rcio_Oliveira?= <moliveira@rhla.com>
Cc: "Linux kernel" <linux-kernel@vger.kernel.org>,
       "Marcio Oliveira" <moliveira@latinsourcetech.com>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 26 Oct 2005, [iso-8859-1] Márcio Oliveira wrote:

> Hi there!
>
>  I have a IBM ThinkPad t43 running Fedora Core  Linux 4 and kernel
> 2.6.12-1.146_FC4. I recompiled the kernel (2.6.13.4 - kernel.org) and I
> am geting the following message when the computer boots:
>
> Creating root device
> mkrootdev: label / not found

This label was no good it needs to be /dev/sda6 from your fstab
You will need to put the device name in /boot/*/*.conf lilo or
grub instead on "label"

> Mounting root filesystem
> mount: error 2 mouting ext3

Error 2 == ENOENT


> Switchimg to new root
> ERROR opening /dev/console!!!!: 2
> switchroot: mount failed: 22

Error 22 = EINVAL

> Kernel Panic - not syncing to kill init!
>
>    I added the fdisk command to the initrd file and the init script
> executes it every boot to check if the kernel was recognizing the SATA
> disk. All partitions are listed in the boot process and the disk is
> recognized without problems, but the kernel still not able to mount the
> root partition:
>
> scsi0: ata_piix
> ...
> ...
> Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
>
> Disk /dev/sda: 60.0 GB, 60011642880 bytes
> 255 heads, 63 sectors/track, 7296 cylinders
> Units = cylinders of 16065 * 512 = 8225280 bytes
>
>   Device Boot      Start         End      Blocks   Id  System
> /dev/sda1   *           1        1913    15361888+   7  HPFS/NTFS
> Partition 1 does not end on cylinder boundary.
> /dev/sda2            6778        7296     4165560   12  Compaq diagnostics
> Partition 2 does not end on cylinder boundary.
> /dev/sda3            1914        1929      128520   83  Linux
> /dev/sda4            1930        6777    38941560    5  Extended
> /dev/sda5            1930        2843     7341673+  8e  Linux LVM
> /dev/sda6            2844        3235     3148708+  83  Linux
> /dev/sda7            3236        6777    28451083+   b  W95 FAT32
>
> Partition table entries are not in disk order
>
>   I also checked the initrd file and all seems ok.
>   Thinks I made:
>
> - compiled the kernel with ext3 modular support;
> - compiled the kernel with ext3 built-in support;
> - checked the modules loaded in the initrd;
> - rebuilded and customized the initrd;
> - checked if the SATA controller is recognized at boot time;
> - tested fstab with and without "LABEL" partition name.
>
> Any idea?
>
>   Related Files:
>
> /etc/fstab:
>
> # This file is edited by fstab-sync - see 'man fstab-sync' for details
> /dev/sda6                 /                       ext3
> defaults        1 1
> #LABEL=/                 /                       ext3    defaults        1 1
> #LABEL=/boot             /boot                   ext3    defaults        1 2
> /dev/sda3             /boot                   ext3    defaults        1 2
> /dev/devpts             /dev/pts                devpts  gid=5,mode=620  0 0
> /dev/shm                /dev/shm                tmpfs   defaults        0 0
> /dev/proc               /proc                   proc    defaults        0 0
> /dev/sys                /sys                    sysfs   defaults        0 0
> /dev/VG00/usr           /usr                    ext3    defaults        1 2
> /dev/VG00/var           /var                    ext3    defaults        1 2
> /dev/VG00/swap          swap                    swap    defaults        0 0
> /dev/sda7               /mnt/windows            vfat    user,defaults   0 0
> /dev/hdc                /media/cdrecorder       auto
> pamconsole,exec,noauto,managed 0 0
>
> /boot/grub/menu.lst
>
> title Fedora Core (2.6.13-4)
>        root (hd0,2)
>        kernel /vmlinuz-2.6.13.4-ext3 ro root=LABEL=/ hda=noprobe 1
>        initrd /initrd-2.6.13.4-ext3.img
>
> *** I tested the root=LABEL=/ and root=/dev/sda6 kernel comand options.
>
> Initrd file contents:
>
> ./sbin
> ./loopfs
> ./proc
> ./init
> ./sysroot
> ./bin
> ./bin/hotplug
> ./bin/nash
> ./bin/udev
> ./bin/fdisk
> ./bin/insmod
> ./bin/udevstart
> ./bin/modprobe
> ./dev
> ./dev/tty3
> ./dev/tty4
> ./dev/tty1
> ./dev/console
> ./dev/tty2
> ./dev/null
> ./dev/ram
> ./dev/systty
> ./sys
> ./lib
> ./lib/libc.so.6
> ./lib/ld-2.3.5.so
> ./lib/scsi_mod.ko
> ./lib/ld-linux.so.2
> ./lib/sd_mod.ko
> ./lib/libc-2.3.5.so
> ./lib/dm-mod.ko
> ./lib/ata_piix.ko
> ./lib/libata.ko
> ./etc
> ./etc/udev
> ./etc/udev/udev.conf
>
> /init initrd file:
>
> #!/bin/nash
> mount -t proc /proc /proc
> setquiet
> echo Mounted /proc filesystem
> echo Mounting sysfs
> mount -t sysfs /sys /sys
> echo Creating /dev
> mount -o mode=0755 -t tmpfs /dev /dev
> mknod /dev/console c 5 1
> mknod /dev/null c 1 3
> mknod /dev/zero c 1 5
> mkdir /dev/pts
> mkdir /dev/shm
> echo Starting udev
> /sbin/udevstart
> echo -n "/sbin/hotplug" > /proc/sys/kernel/hotplug
> echo "Loading scsi_mod.ko module"
> insmod /lib/scsi_mod.ko
> echo "Loading sd_mod.ko module"
> insmod /lib/sd_mod.ko
> echo "Loading libata.ko module"
> insmod /lib/libata.ko
> echo "Loading ata_piix.ko module"
> insmod /lib/ata_piix.ko
> echo "Loading dm-mod.ko module"
> insmod /lib/dm-mod.ko
> sleep 10
> /sbin/fdisk -l
> sleep 10
> /sbin/udevstart
> echo Creating root device
> mkrootdev /dev/root
> echo Mounting root filesystem
> mount -o defaults --ro -t ext3 /dev/root /sysroot
> echo Switching to new root
> switchroot --movedev /sysroot
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

Cheers,
Dick Johnson
Penguin : Linux version 2.6.13.4 on an i686 machine (5589.55 BogoMips).
Warning : 98.36% of all statistics are fiction.

****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
