Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750833AbWEPLPB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750833AbWEPLPB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 07:15:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751780AbWEPLPB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 07:15:01 -0400
Received: from embla.aitel.hist.no ([158.38.50.22]:40656 "HELO
	embla.aitel.hist.no") by vger.kernel.org with SMTP id S1750833AbWEPLPA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 07:15:00 -0400
Message-ID: <4469B371.7040102@aitel.hist.no>
Date: Tue, 16 May 2006 13:11:45 +0200
From: Helge Hafting <helge.hafting@aitel.hist.no>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mario Ohnewald <mario@bortal.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: [ MOUNT ] Can not mount compact flash drive hda (ext3) with 2.6.16
References: <1147425102.6987.2.camel@spiekey.spiekey>
In-Reply-To: <1147425102.6987.2.camel@spiekey.spiekey>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mario Ohnewald wrote:

>Hello List,
>
>i am booting a linux box via NFS. 
>When it boot it with a 2.4.32 kernel i CAN mount my compact flash drive
>hda.
>
>If i boot a 2.6.16 kernel i CAN NOT.
>
>
>hdaX is ext3 and ext3 is compiled into the kernel.
>Am i missing a kernel option?
>
>More infos:
>
>~# fdisk -l
>
>Disk /dev/hda: 1024 MB, 1024450560 bytes
>32 heads, 63 sectors/track, 992 cylinders
>Units = cylinders of 2016 * 512 = 1032192 bytes
>
>   Device Boot      Start         End      Blocks   Id  System
>/dev/hda1   *           1          73       73552+  83  Linux
>/dev/hda2              74         751      683424   83  Linux
>/dev/hda3             752         799       48384   83  Linux
>/dev/hda4             800         992      194544   83  Linux
>
>~# mount
>rootfs on / type rootfs (rw)
>/dev/root on / type nfs
>(rw,v2,rsize=4096,wsize=4096,hard,nolock,proto=udp,addr=192.168.1.252)
>proc on /proc type proc (rw)
>sysfs on /sys type sysfs (rw)
>usbfs on /proc/bus/usb type usbfs (rw)
>/dev/root on /dev/.static/dev type nfs
>(rw,v2,rsize=4096,wsize=4096,hard,nolock,proto=udp,addr=192.168.1.252)
>none on /dev type tmpfs (rw)
>tmpfs on /tmp type tmpfs (rw)
>devpts on /dev/pts type devpts (rw)
>tmpfs on /dev/shm type tmpfs (rw)
>
>
>  
>
proc/mounts is the interesting one - the "mount" command
gives you /etc/mtab which may be wrong.

>~# cat /proc/mounts
>rootfs / rootfs rw 0 0
>/dev/root / nfs
>rw,v2,rsize=4096,wsize=4096,hard,nolock,proto=udp,addr=192.168.1.252 0 0
>proc /proc proc rw 0 0
>sysfs /sys sysfs rw 0 0
>usbfs /proc/bus/usb usbfs rw 0 0
>/dev/root /dev/.static/dev nfs
>rw,v2,rsize=4096,wsize=4096,hard,nolock,proto=udp,addr=192.168.1.252 0 0
>none /dev tmpfs rw 0 0
>tmpfs /tmp tmpfs rw 0 0
>devpts /dev/pts devpts rw 0 0
>tmpfs /dev/shm tmpfs rw 0 0
>
>  
>
no hda in use here

>~# lsof | grep hda
><no result>
>
>
>~# dmesg | grep hda
>    ide0: BM-DMA at 0xe000-0xe007, BIOS settings: hda:pio, hdb:pio
>hda: TOSHIBA THNCF1G02PG, CFA DISK drive
>hda: max request size: 128KiB
>hda: 2000880 sectors (1024 MB) w/2KiB Cache, CHS=1985/16/63
> hda: hda1 hda2 hda3 hda4
>
>~# mount -t ext3 /dev/hda1 /mnt/
>mount: /dev/hda1 already mounted or /mnt/ busy
>  
>
There is a hda, it is a 1GB disk, and it has four partitions.  The
four partitions are correct?

There are other ways hda1 could be busy, such as used for swap
or member of a RAID array.  But I guess this is not the case here?

>~# mkfs.ext3 /dev/hda1
>mke2fs 1.38 (30-Jun-2005)
>/dev/hda1 is apparently in use by the system; will not make a filesystem
>here!
>
>  
>
Well, you could try the -F (force) option and see what happens.
Just make sure "hda1" doesn't somehow refer to another device
in the system.


You may also want to try
cfdisk /dev/hda
and see that the partition layout is the same as with 2.4,
and you might want to check if cat /dev/hda > /dev/null works.
This is all very strange, but more data might get more people interested.

Helge Hafting
