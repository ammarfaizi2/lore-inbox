Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264143AbTFZWmF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jun 2003 18:42:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264095AbTFZWk5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jun 2003 18:40:57 -0400
Received: from 64-60-248-67.cust.telepacific.net ([64.60.248.67]:27532 "EHLO
	mx.rackable.com") by vger.kernel.org with ESMTP id S264067AbTFZWga
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jun 2003 18:36:30 -0400
Message-ID: <3EFB77CD.1020607@rackable.com>
Date: Thu, 26 Jun 2003 15:46:37 -0700
From: Samuel Flory <sflory@rackable.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030529
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, Alan Cox <alan@redhat.com>
CC: B.Zolnierkiewicz@elka.pw.edu.pl
Subject: ICH5-SATA file corruption under 2.4.21-ac1
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 26 Jun 2003 22:50:41.0590 (UTC) FILETIME=[5EADFD60:01C33C35]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  On an Intel winterpark motherboard I'm seeing file corruption when 
using the onboard SATA interface.  The test I'm running is ctcs's new 
kdiff test which just copies a kernel, diffs it, deletes the tree, and 
starts over.  (Which seems to find file system issues like this pretty 
quickly.) 
The error I'm getting look like this:
]] start diff
diff -u -r /usr/src/linux/drivers/acpi/debugger/dbcmds.c 
./drivers/acpi/debugger
/dbcmds.c
--- /usr/src/linux/drivers/acpi/debugger/dbcmds.c       Thu Jun 21 
08:47:39 2001
+++ ./drivers/acpi/debugger/dbcmds.c    Thu Jun 21 08:47:39 2001
@@ -439,7 +439,7 @@
  
******************************************************************************
/

 void
-acpi_db_dump_namespace_by_owner (
+acpi_db_dump_namespace_by_owler (
        NATIVE_CHAR             *owner_arg,
        NATIVE_CHAR             *depth_arg)
 {
@@ -484,7 +484,7 @@
  
******************************************************************************
/

 void
-acpi_db_send_notify (
+acpi^db_send_notify (
        NATIVE_CHAR             *name,
        u32                     value)
 {
diff -u -r /usr/src/linux/drivers/acpi/resources/rsdump.c 
./drivers/acpi/resourc
es/rsdump.c
--- /usr/src/linux/drivers/acpi/resources/rsdump.c      Thu Jun 21 
08:47:40 2001
+++ ./drivers/acpi/resources/rsdump.c   Thu Jun 21 08:47:40 2001
@@ -324,7 +324,7 @@
  *
  * RETURN:      None
  *
- * DESCRIPTION: Prints out the various members of the Data structure type.
+ * DESCRIPTION: Prints out the various members of the Data structure type,
  *
  
******************************************************************************
/




Lscpi of ide controller:
00:1f.1 IDE interface: Intel Corporation: Unknown device 24db (rev 02) 
(prog-if 8a [M
aster SecP PriP])
        Subsystem: Intel Corporation: Unknown device 3428
        Flags: bus master, medium devsel, latency 0, IRQ 18
        I/O ports at <unassigned>
        I/O ports at <unassigned>
        I/O ports at <unassigned>
        I/O ports at <unassigned>
        I/O ports at ffa0 [size=16]
        Memory at 80000000 (32-bit, non-prefetchable) [size=1K]

00:1f.2 IDE interface: Intel Corporation: Unknown device 24d1 (rev 02) 
(prog-if 8f [M
aster SecP SecO PriP PriO])
        Subsystem: Intel Corporation: Unknown device 3428
        Flags: bus master, 66Mhz, medium devsel, latency 0, IRQ 18
        I/O ports at ec00 [size=8]
        I/O ports at e800 [size=4]
        I/O ports at e400 [size=8]
        I/O ports at e000 [size=4]
        I/O ports at dc00 [size=16]


IDE initialization:
Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH5: IDE controller at PCI slot 00:1f.1
PCI: Enabling device 00:1f.1 (0005 -> 0007)
ICH5: chipset revision 2
ICH5: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:pio, hdd:pio
ICH5-SATA: IDE controller at PCI slot 00:1f.2
ICH5-SATA: chipset revision 2
ICH5-SATA: 100% native mode on irq 18
    ide2: BM-DMA at 0xdc00-0xdc07, BIOS settings: hde:DMA, hdf:pio
    ide3: BM-DMA at 0xdc08-0xdc0f, BIOS settings: hdg:pio, hdh:pio
hda: CD-224E, ATAPI CD/DVD-ROM drive
hde: ST380023AS, ATA DISK drive
hdf: probing with STATUS(0x00) instead of ALTSTATUS(0x50)
hdf: probing with STATUS(0x00) instead of ALTSTATUS(0x50)
blk: queue c060cde0, I/O limit 4095Mb (mask 0xffffffff)
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide2 at 0xec00-0xec07,0xe802 on irq 18
hde: attached ide-disk driver.
hde: host protected area => 1
hde: 156301488 sectors (80026 MB) w/8192KiB Cache, CHS=155061/16/63, 
UDMA(100)
hda: attached ide-cdrom driver.
hda: ATAPI 24X CD-ROM drive, 128kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
ide-floppy driver 0.99.newide
Partition check:
 hde: hde1 hde2 hde3
ide-floppy driver 0.99.newide

IDE section of .config:
CONFIG_IDE=y

CONFIG_BLK_DEV_IDE=y

CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
CONFIG_BLK_DEV_IDECD=y
CONFIG_BLK_DEV_IDETAPE=m
CONFIG_BLK_DEV_IDEFLOPPY=y
CONFIG_BLK_DEV_IDESCSI=m
CONFIG_IDE_TASK_IOCTL=y

CONFIG_BLK_DEV_CMD640=y
CONFIG_BLK_DEV_CMD640_ENHANCED=y
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_IDEDMA_PCI_WIP=y
CONFIG_BLK_DEV_ADMA100=y
CONFIG_BLK_DEV_AEC62XX=y
CONFIG_BLK_DEV_ALI15X3=y
CONFIG_BLK_DEV_AMD74XX=y
CONFIG_BLK_DEV_CMD64X=y
CONFIG_BLK_DEV_TRIFLEX=y
CONFIG_BLK_DEV_CY82C693=y
CONFIG_BLK_DEV_CS5530=y
CONFIG_BLK_DEV_HPT34X=y
CONFIG_BLK_DEV_HPT366=y
CONFIG_BLK_DEV_PIIX=y
CONFIG_BLK_DEV_NS87415=y
CONFIG_BLK_DEV_OPTI621=y
CONFIG_BLK_DEV_PDC202XX_OLD=y
CONFIG_BLK_DEV_PDC202XX_NEW=y
CONFIG_PDC202XX_FORCE=y
CONFIG_BLK_DEV_RZ1000=y
CONFIG_BLK_DEV_SC1200=y
CONFIG_BLK_DEV_SVWKS=y
CONFIG_BLK_DEV_SIIMAGE=y
CONFIG_BLK_DEV_SIS5513=y
CONFIG_BLK_DEV_SLC90E66=y
CONFIG_BLK_DEV_TRM290=y
CONFIG_BLK_DEV_VIA82CXXX=y
CONFIG_IDEDMA_AUTO=y
CONFIG_BLK_DEV_PDC202XX=y
CONFIG_BLK_DEV_IDE_MODES=y
CONFIG_BLK_DEV_ATARAID=m
CONFIG_BLK_DEV_ATARAID_PDC=m
CONFIG_BLK_DEV_ATARAID_HPT=m
CONFIG_BLK_DEV_ATARAID_SII=m


  Full dmesg, lspci, and .config are availble if needed.

-- 
Once you have their hardware. Never give it back.
(The First Rule of Hardware Acquisition)
Sam Flory  <sflory@rackable.com>


