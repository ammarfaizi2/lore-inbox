Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264465AbTEaVrJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 May 2003 17:47:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264467AbTEaVrJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 May 2003 17:47:09 -0400
Received: from ironbark.bendigo.latrobe.edu.au ([149.144.21.60]:15798 "EHLO
	ironbark.bendigo.latrobe.edu.au") by vger.kernel.org with ESMTP
	id S264465AbTEaVrH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 May 2003 17:47:07 -0400
From: Grant <grant@ironbark.bendigo.latrobe.edu.au>
To: linux-kernel@vger.kernel.org
Subject: 2.4 -ac zip ppa --  'mount: /dev/sda4 is not a valid block device'
Date: Sun, 01 Jun 2003 08:00:23 +1000
Organization: Scattered
Reply-To: gcoady@bendigo.net.au
Message-ID: <2j5idv0eh05vpva8tqkd4lc97bbh3dhack@4ax.com>
X-Mailer: Forte Agent 1.93/32.576 English (American)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,

Mounting a ppa zip drive:

2.4.21-rc5-ac2 and redhat 2.4.20-13.9 report sda4 as "not a 
valid block device" and do not mount the drive.

2.4.21-rc6 and redhat 2.4.20-9 kernels work fine.

As two of these kernels are stock redhat releases, I doubt 
my .config file is relevant.  My system has IDE HD & CDROM. 

File '/etc/modules.conf' has no references to scsi or parport 
modules and I manually load modules with script zip-mount:

#!/bin/sh
echo "zip-mount: load modules & mount zip drive..."
insmod scsi_mod
insmod sd_mod
insmod parport
insmod parport_pc
insmod ppa
mount /mnt/zip

- - -

### Okay:

[root@two root]# /home/system/zip-mount
zip-mount: load modules & mount zip drive...
Using /lib/modules/2.4.21-rc6/kernel/drivers/scsi/scsi_mod.o
Using /lib/modules/2.4.21-rc6/kernel/drivers/scsi/sd_mod.o
Using /lib/modules/2.4.21-rc6/kernel/drivers/parport/parport.o
Using /lib/modules/2.4.21-rc6/kernel/drivers/parport/parport_pc.o
Using /lib/modules/2.4.21-rc6/kernel/drivers/scsi/ppa.o
ppa: Version 2.07 (for Linux 2.4.x)
ppa: Found device at ID 6, Attempting to use EPP 32 bit
ppa: Communication established with ID 6 using EPP 32 bit
  Vendor: IOMEGA    Model: ZIP 100           Rev: D.17
  Type:   Direct-Access                      ANSI SCSI revision: 02
Attached scsi removable disk sda at scsi0, channel 0, id 6, lun 0
SCSI device sda: 196608 512-byte hdwr sectors (101 MB)
sda: Write Protect is off
[root@two root]#

### Fail:

[root@two root]# /home/system/zip-mount
zip-mount: load modules & mount zip drive...
Using /lib/modules/2.4.21-rc5-ac2/kernel/drivers/scsi/scsi_mod.o
Using /lib/modules/2.4.21-rc5-ac2/kernel/drivers/scsi/sd_mod.o
Using /lib/modules/2.4.21-rc5-ac2/kernel/drivers/parport/parport.o
Using /lib/modules/2.4.21-rc5-ac2/kernel/drivers/parport/parport_pc.o
Using /lib/modules/2.4.21-rc5-ac2/kernel/drivers/scsi/ppa.o
ppa: Version 2.07 (for Linux 2.4.x)
ppa: Found device at ID 6, Attempting to use EPP 32 bit
ppa: Communication established with ID 6 using EPP 32 bit
  Vendor: IOMEGA    Model: ZIP 100           Rev: D.17
  Type:   Direct-Access                      ANSI SCSI revision: 02
Attached scsi removable disk sda at scsi0, channel 0, id 6, lun 0
SCSI device sda: 196608 512-byte hdwr sectors (101 MB)
sda: Write Protect is off
 I/O error: dev 08:00, sector 0
 unable to read partition table
mount: /dev/sda4 is not a valid block device
[root@two root]#

- - -

Cheers,
Grant.

