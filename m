Return-Path: <linux-kernel-owner+w=401wt.eu-S1751437AbXAFSZS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751437AbXAFSZS (ORCPT <rfc822;w@1wt.eu>);
	Sat, 6 Jan 2007 13:25:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751443AbXAFSZS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Jan 2007 13:25:18 -0500
Received: from nf-out-0910.google.com ([64.233.182.186]:52340 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751437AbXAFSZP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Jan 2007 13:25:15 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=jg0ULcnWl/a8oGcQ1GfSyYbrklm0vRoLKEzISjv9LKbHZAtcnTca2zjcDDPMPatorr0u/H0LsTO/KY2YFqewXzhyViMqr2se9G49tW1OhMMH0QqRqC6l2fvje5H8L2ZATcKgerNXlxoO8ROetEHYF2AdYcvkzRwppGFEwcuhN58=
Date: Sat, 6 Jan 2007 19:24:54 +0100
From: Luca Tettamanti <kronos.it@gmail.com>
To: Giuseppe Bilotta <bilotta78@hotpop.com>
Cc: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Jeff Garzik <jgarzik@pobox.com>
Subject: Re: JMicron JMB363 SATA hard disk appears twice (sda + hdg)
Message-ID: <20070106182454.GA12426@dreamland.darkstar.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <31vxryq446ny.b23nrmopmm4.dlg@40tude.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(I'm CCing the author and libata guru)

Giuseppe Bilotta <bilotta78@hotpop.com> ha scritto:
> I have a DVD burner attached to the first IDE channel and a hard
> disk (THE hard disk) attached to the SATA_II controller.

Hi,
Do you have anything attached to the PATA ports of JM controller?

> The BIOS is set to use the SATA controllers in AHCI mode, not IDE.
> However, the hard disk appears twice, first as hdg, then as sda.
> Passing ide2=noprobe ide3=noprobe as boot parameters to the kernel
> doesn't seem to have any effect:
> 
> ATA/IDE-relative dmesg without noprobe:
> 
> Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
> JMB363: IDE controller at PCI slot 0000:02:00.1
>    ide2: BM-DMA at 0xd400-0xd407, BIOS settings: hde:pio, hdf:pio
>    ide3: BM-DMA at 0xd408-0xd40f, BIOS settings: hdg:DMA, hdh:pio
> Probing IDE interface ide2...
> Probing IDE interface ide3...
> hdg: ST3320620AS, ATA DISK drive
> ide3 at 0xd800-0xd807,0xd482 on irq 74
> ahci 0000:02:00.0: AHCI 0001.0000 32 slots 2 ports 3 Gbps 0x3 impl
> SATA mode
> ata1: SATA max UDMA/133 cmd 0xF8874100 ctl 0x0 bmdma 0x0 irq 122
> ata2: SATA max UDMA/133 cmd 0xF8874180 ctl 0x0 bmdma 0x0 irq 122
> ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> ata1.00: ATA-7, max UDMA/133, 625142448 sectors: LBA48 NCQ (depth
> 31/32)
> ata2: SATA link down (SStatus 0 SControl 300)
>  Vendor: ATA       Model: ST3320620AS       Rev: 3.AA
> VP_IDE: IDE controller at PCI slot 0000:00:0f.1
> VP_IDE: chipset revision 7
> VP_IDE: not 100% native mode: will probe irqs later
> VP_IDE: VIA vt8237a (rev 00) IDE UDMA133 controller on
> pci0000:00:0f.1
>    ide0: BM-DMA at 0xfc00-0xfc07, BIOS settings: hda:DMA, hdb:pio
>    ide1: BM-DMA at 0xfc08-0xfc0f, BIOS settings: hdc:pio, hdd:pio
> Probing IDE interface ide0...
> ide3: reset: master: error (0xff?); slave: failed
> ide3: reset: master: error (0xff?); slave: failed
> hda: PHILIPS DVDR1668P1, ATAPI CD/DVD-ROM drive
> ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> Probing IDE interface ide1...
> ata3: SATA max UDMA/133 cmd 0xCC00 ctl 0xC882 bmdma 0xC400 irq 106
> ata4: SATA max UDMA/133 cmd 0xC800 ctl 0xC482 bmdma 0xC408 irq 106
> hda: ATAPI 48X DVD-ROM DVD-R CD-R/RW drive, 2048kB Cache, UDMA(33)
> ata3: SATA link down 1.5 Gbps (SStatus 0 SControl 300)
> ATA: abnormal status 0x7F on port 0xCC07
> ata4: SATA link down 1.5 Gbps (SStatus 0 SControl 300)
> ATA: abnormal status 0x7F on port 0xC807

This may be a bug in the driver. As a workaround you can disable
CONFIG_BLK_DEV_JMICRON (the legacy PATA driver) and enable
CONFIG_PATA_JMICRON (libata based, look for "JMicron PATA support" under
"ATA Device"). Of course if you don't need PATA driver from JMicron (I
see VIA controller here) just turn it off.

Or, you can try the following untested patch. The drawback is that users
who don't want to use libata are cut off; but they can still use the
controller in IDE mode, no? Alan, Jeff what do you think?

jmicron: don't touch the controller when it's AHCI mode. As help text
suggests ("For full support use the libata drivers") the new libata AHCI
driver will take care of it.

Signed-Off-By: Luca Tettamanti <kronos.it@gmail.com>
---

 drivers/ide/pci/jmicron.c |    3 +++
 include/linux/pci_ids.h   |    1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/ide/pci/jmicron.c b/drivers/ide/pci/jmicron.c
index c1cec23..29bf00f 100644
--- a/drivers/ide/pci/jmicron.c
+++ b/drivers/ide/pci/jmicron.c
@@ -235,6 +235,9 @@ static ide_pci_device_t jmicron_chipsets[] __devinitdata = {
 
 static int __devinit jmicron_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 {
+	/* Ignore this controller when in AHCI mode */
+	if (dev->class == PCI_CLASS_STORAGE_AHCI)
+		return -ENODEV;
 	ide_setup_pci_device(dev, &jmicron_chipsets[id->driver_data]);
 	return 0;
 }
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index f7a416c..b43369a 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -15,6 +15,7 @@
 #define PCI_CLASS_STORAGE_FLOPPY	0x0102
 #define PCI_CLASS_STORAGE_IPI		0x0103
 #define PCI_CLASS_STORAGE_RAID		0x0104
+#define PCI_CLASS_STORAGE_AHCI		0x010601
 #define PCI_CLASS_STORAGE_SAS		0x0107
 #define PCI_CLASS_STORAGE_OTHER		0x0180
 


Luca
-- 
> While we're on all of this, are we going to change "tained" to some
> other less alarmist word?
"screwed" -- Alexander Viro
