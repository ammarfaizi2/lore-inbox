Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261491AbUJZVuo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261491AbUJZVuo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 17:50:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261496AbUJZVun
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 17:50:43 -0400
Received: from smtp08.auna.com ([62.81.186.18]:25998 "EHLO smtp08.retemail.es")
	by vger.kernel.org with ESMTP id S261491AbUJZVuQ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 17:50:16 -0400
Date: Tue, 26 Oct 2004 21:50:14 +0000
From: "J.A. Magallon" <jamagallon@able.es>
Subject: Setting 32bit IO on SATA drives
To: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
X-Mailer: Balsa 2.2.5
Message-Id: <1098827414l.6518l.0l@werewolf.able.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all...

I have a bunch of SATA drives on a RAID-5 setup.
I was investigating the usual things on ide disks to optimize performance,
with hdparm.

The defalt settings, as they boot:

sata_promise version 1.00
ACPI: PCI interrupt 0000:00:07.0[A] -> GSI 17 (level, low) -> IRQ 177
ata1: SATA max UDMA/133 cmd 0xF0802200 ctl 0xF0802238 bmdma 0x0 irq 177
...
ata1: dev 0 cfg 49:2f00 82:7c6b 83:7f09 84:4003 85:7c69 86:3e01 87:4003 88:407f
ata1: dev 0 ATA, max UDMA/133, 490234752 sectors: lba48
ata1: dev 0 configured for UDMA/133

nada:~# lsscsi -l
[0:0:0:0]    disk    ATA      Maxtor 7Y250M0   YAR5  /dev/sda
  state=running queue_depth=1 scsi_level=6 type=0 device_blocked=0 timeout=30

nada:~# hdparm /dev/sda

/dev/sda:
 HDIO_GET_MULTCOUNT failed: Operation not supported
 IO_support   =  0 (default 16-bit)
 readonly     =  0 (off)
 readahead    = 256 (on)
 geometry     = 30515/255/63, sectors = 251000193024, start = 0

nada:~# hdparm -c /dev/sda

/dev/sda:
 IO_support   =  0 (default 16-bit)

nada:~# hdparm -c1 /dev/sda

/dev/sda:
 setting 32-bit IO_support flag to 1
 HDIO_SET_32BIT failed: Invalid argument
 IO_support   =  0 (default 16-bit)

How can I make 32bit IO active ?

TIA

--
J.A. Magallon <jamagallon()able!es>     \               Software is like sex:
werewolf!able!es                         \         It's better when it's free
Mandrakelinux release 10.1 (Community) for i586
Linux 2.6.9-jam1 (gcc 3.4.1 (Mandrakelinux 10.1 3.4.1-4mdk)) #4


