Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263960AbTJ1NK2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Oct 2003 08:10:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263961AbTJ1NK2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Oct 2003 08:10:28 -0500
Received: from [202.68.142.226] ([202.68.142.226]:23013 "HELO smtp1.iitb.ac.in")
	by vger.kernel.org with SMTP id S263960AbTJ1NK0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Oct 2003 08:10:26 -0500
Subject: kernel 2.6.0-test9 does not boot
From: Amitay Isaacs <amitay@aero.iitb.ac.in>
To: kernel mailing list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: CASDE, Aerospace Engineering, IIT Bombay
Message-Id: <1067346608.3938.32.camel@maxwell.aero.iitb.ac.in>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 28 Oct 2003 18:40:09 +0530
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Kernel 2.6.0-test9 was compiled as following

make allmodconfig
make bzImage
make modules

Attempt at booting with this kernel resulted in following message
and machine freeze.

-------------------------------------------------------------------
ide: Assuming 33MHz system bus speed for PIO modes; override with     
    idebus=xx
pnp: the driver 'ide' has been registered
Using anticipatory io scheduler
hda: 8032MB, CHS=1024/255/63
devfs_mk_dir: invalid argument. <6> hda:
-------------------------------------------------------------------

Kernel was booted with
foll-------------------------------------------------------------------
owing commandline in grub

    kernel /boot/vmlinuz-2.6.0-test9 ro root=/dev/hda1 debug

The actual hard disk parameters as reported by kernel 2.4.20 are

-------------------------------------------------------------------
hda: WDC WD200EB-11BHF0, ATA DISK drive
blk: queue c03c9f40, I/O limit 4095Mb (mask 0xffffffff)
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: host protected area => 1
hda: 39102336 sectors (20020 MB) w/2048KiB Cache, CHS=2434/255/63,
UDMA(100)
-------------------------------------------------------------------

After manual tracing the kernel source, found following call tree 

idedisk_attach (drivers/ide/ide-disk.c:1840)
  add_disk (drivers/genhd/genhd.c:193)
  register_disk (fs/partitions/check.c:335)
    devfs_add_partitioned (fs/partitions/devfs.c:80)
      devfs_mk_dir()

printk revealed that devfs_mk_dir() is getting called with a
0-byte string. What is going wrong? 


Amitay.
-- 
I have always wished that my computer would be as easy to use 
as my telephone. My wish has come true. I no longer know how 
to use my telephone.  - Bjarne Stroustrup

