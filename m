Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261843AbUDIWZP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Apr 2004 18:25:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261969AbUDIWZP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Apr 2004 18:25:15 -0400
Received: from mta9.adelphia.net ([68.168.78.199]:27337 "EHLO
	mta9.adelphia.net") by vger.kernel.org with ESMTP id S261851AbUDIWYE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Apr 2004 18:24:04 -0400
Message-ID: <40772283.1090802@nodivisions.com>
Date: Fri, 09 Apr 2004 18:24:03 -0400
From: Anthony DiSante <orders@nodivisions.com>
Reply-To: orders@nodivisions.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031206 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.6.5 kernel: Unable to mount root fs
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I had been running kernel 2.4.22 on a Slackware 8 system (x86).  I just 
compiled and installed the 2.6.5 kernel from kernel.org.  Now at boot, I get 
a kernel panic:


...
ACPI: (supports S0 S1 S4 S5)
UDF-fs: no partition found (1)
Kernel panic: VFS: Unable to mount root fs on hda1


My IDE disk (/dev/hda) has 3 partitions, all of which are ext3, and I do 
have ext2 and ext3 enabled in the kernel.  Here's all the IDE stuff that 
I've enabled in the kernel config; anything missing?:


CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
CONFIG_BLK_DEV_IDECD=y
CONFIG_IDE_TASKFILE_IO=y
CONFIG_IDE_GENERIC=y
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_IDEDMA_AUTO=y


Here's my lilo.conf:


boot = /dev/hda
vga = 0xf01

image=/boot/bzImage.20031026
   label=2.4.22
   root=/dev/hda1
   read-only
   ramdisk=30000

image=/boot/bzImage.2.6.5
   label=2.6.5
   root=/dev/hda1
   read-only
   ramdisk=30000


The 2.4.22 kernel works fine; the 2.6.5 kernel panics at boot.

I did some searching and found 3 solutions, but none of them worked for me:

- enabled "PC BIOS" support in Partition Types -> Advanced
- added "acpi=no pci=noacpi" on the boot line
- enabled Pseudo filesystems -> /dev file system support (OBSOLETE)

Any ideas?

Thanks,
Anthony
http://nodivisions.com/
