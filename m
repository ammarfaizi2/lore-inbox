Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935795AbWLCLVH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935795AbWLCLVH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Dec 2006 06:21:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936689AbWLCLVH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Dec 2006 06:21:07 -0500
Received: from mail.syneticon.net ([213.239.212.131]:22726 "EHLO
	mail2.syneticon.net") by vger.kernel.org with ESMTP id S935795AbWLCLVF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Dec 2006 06:21:05 -0500
Message-ID: <4572B30F.9020605@wpkg.org>
Date: Sun, 03 Dec 2006 12:20:47 +0100
From: Tomasz Chmielewski <mangoo@wpkg.org>
User-Agent: Thunderbird 1.5.0.8 (X11/20061128)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: why can't I remove a kernel module (or: what uses a given module)?
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There is something I don't understand about loading and unloading kernel 
modules.

I have a SATA controller, it uses a sata_mv driver.
The drive connected to it is not used; it just "merely exists" - no one 
touches it.
This is why I don't understand why I can't remove such a module:

1.

# rmmod sata_mv
ERROR: Module sata_mv is in use

The module was loaded automatically during the system boot.

mount claims no /dev/sda* partition is mounted.


2.

In a second scenario, I move the kernel:

# mv /lib/modules/2.6.19/kernel/drivers/ata/sata_mv.ko /root
# reboot

And load it later manually:

# insmod ./sata_mv
# dmesg -c
sata_mv 0000:01:00.0: version 0.7
ACPI: PCI Interrupt 0000:01:00.0[A] -> GSI 20 (level, low) -> IRQ 23
(...)
SCSI device sda: drive cache: write back
  sda: sda1
sd 24:0:0:0: Attached scsi disk sda


We can remove the module without problems:

# rmmod sata_mv
# dmesg -c
Synchronizing SCSI cache for disk sda:
ACPI: PCI interrupt for device 0000:01:00.0 disabled


Now I could remove the module without problems.


What was using the module in the first scenario (I couldn't remove the 
module)?


-- 
Tomasz Chmielewski
http://wpkg.org
