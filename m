Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261270AbUAILck (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jan 2004 06:32:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261298AbUAILck
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jan 2004 06:32:40 -0500
Received: from catv-50620dee.bp13catv.broadband.hu ([80.98.13.238]:34824 "EHLO
	guard.localnet") by vger.kernel.org with ESMTP id S261270AbUAILcf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jan 2004 06:32:35 -0500
Subject: Modular IDE in 2.6
From: Attila BODY <compi@freemail.hu>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1073647943.1013.12.camel@smiley.localnet>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 09 Jan 2004 12:32:24 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

It has been reported already but there was no response on the list so I
have to ask a straight question:

Will we have a modular ide in 2.6 anytime (soon)?

The sympthom is when I am trying to compile the IDE code as modules in
2.6 (last time in 2.6.1), depmod fails with unresolved symbols and
circular dependencies:

if [ -r System.map ]; then /sbin/depmod -ae -F System.map -b ~/linux -r
2.6.1; fi
WARNING:
/home/compi/linux/lib/modules/2.6.1/kernel/drivers/ide/ide-floppy.ko
needs unknown symbol proc_ide_read_geometry
WARNING:
/home/compi/linux/lib/modules/2.6.1/kernel/drivers/ide/ide-probe.ko
needs unknown symbol create_proc_ide_interfaces
WARNING:
/home/compi/linux/lib/modules/2.6.1/kernel/drivers/ide/ide-probe.ko
needs unknown symbol ide_cfg_sem
WARNING:
/home/compi/linux/lib/modules/2.6.1/kernel/drivers/ide/ide-probe.ko
needs unknown symbol idedefault_driver
WARNING:
/home/compi/linux/lib/modules/2.6.1/kernel/drivers/ide/ide-probe.ko
needs unknown symbol do_ide_request
WARNING:
/home/compi/linux/lib/modules/2.6.1/kernel/drivers/ide/ide-probe.ko
needs unknown symbol ide_add_generic_settings
WARNING:
/home/compi/linux/lib/modules/2.6.1/kernel/drivers/ide/ide-probe.ko
needs unknown symbol blk_queue_activity_fn
WARNING: /home/compi/linux/lib/modules/2.6.1/kernel/drivers/ide/ide.ko
needs unknown symbol ide_scan_pcibus
WARNING: /home/compi/linux/lib/modules/2.6.1/kernel/drivers/ide/ide.ko
needs unknown symbol ide_release_dma
WARNING: /home/compi/linux/lib/modules/2.6.1/kernel/drivers/ide/ide.ko
needs unknown symbol create_proc_ide_interfaces
WARNING: /home/compi/linux/lib/modules/2.6.1/kernel/drivers/ide/ide.ko
needs unknown symbol ide_add_proc_entries
WARNING: /home/compi/linux/lib/modules/2.6.1/kernel/drivers/ide/ide.ko
needs unknown symbol proc_ide_read_capacity
WARNING: /home/compi/linux/lib/modules/2.6.1/kernel/drivers/ide/ide.ko
needs unknown symbol destroy_proc_ide_drives
WARNING: /home/compi/linux/lib/modules/2.6.1/kernel/drivers/ide/ide.ko
needs unknown symbol idedefault_driver
WARNING: /home/compi/linux/lib/modules/2.6.1/kernel/drivers/ide/ide.ko
needs unknown symbol proc_ide_destroy
WARNING: /home/compi/linux/lib/modules/2.6.1/kernel/drivers/ide/ide.ko
needs unknown symbol ide_remove_proc_entries
WARNING: /home/compi/linux/lib/modules/2.6.1/kernel/drivers/ide/ide.ko
needs unknown symbol proc_ide_create

...

WARNING: Module /lib/modules/2.6.1/kernel/drivers/scsi/ide-scsi.ko
ignored, due to loop
WARNING: Module
/lib/modules/2.6.1/kernel/drivers/usb/storage/usb-storage.ko ignored,
due to loop
WARNING: Module /lib/modules/2.6.1/kernel/drivers/ide/ide-io.ko ignored,
due to loop
WARNING: Module /lib/modules/2.6.1/kernel/drivers/ide/ide-cd.ko ignored,
due to loop
WARNING: Module /lib/modules/2.6.1/kernel/drivers/ide/ide-floppy.ko
ignored, due to loop
WARNING: Loop detected:
/home/compi/linux/lib/modules/2.6.1/kernel/drivers/ide/ide-iops.ko needs
ide.ko which needs ide-iops.ko again!


The relevan .config part is the following:

CONFIG_IDE=m
CONFIG_BLK_DEV_IDE=m

# CONFIG_BLK_DEV_HD_IDE is not set
CONFIG_BLK_DEV_IDEDISK=m
# CONFIG_IDEDISK_MULTI_MODE is not set
# CONFIG_IDEDISK_STROKE is not set
CONFIG_BLK_DEV_IDECD=m
CONFIG_BLK_DEV_IDETAPE=m
CONFIG_BLK_DEV_IDEFLOPPY=m
CONFIG_BLK_DEV_IDESCSI=m
CONFIG_IDE_TASK_IOCTL=y
CONFIG_IDE_TASKFILE_IO=y

# CONFIG_BLK_DEV_CMD640 is not set
# CONFIG_BLK_DEV_IDEPNP is not set
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
# CONFIG_BLK_DEV_OFFBOARD is not set
CONFIG_BLK_DEV_GENERIC=y
CONFIG_BLK_DEV_OPTI621=m
CONFIG_BLK_DEV_RZ1000=m
CONFIG_BLK_DEV_IDEDMA_PCI=y
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
CONFIG_IDEDMA_PCI_AUTO=y
# CONFIG_IDEDMA_ONLYDISK is not set
# CONFIG_IDEDMA_PCI_WIP is not set
CONFIG_BLK_DEV_ADMA=y
CONFIG_BLK_DEV_AEC62XX=m
CONFIG_BLK_DEV_ALI15X3=m
# CONFIG_WDC_ALI15X3 is not set
CONFIG_BLK_DEV_AMD74XX=m
CONFIG_BLK_DEV_CMD64X=m
CONFIG_BLK_DEV_TRIFLEX=m
CONFIG_BLK_DEV_CY82C693=m
# CONFIG_BLK_DEV_CS5520 is not set
CONFIG_BLK_DEV_CS5530=m
CONFIG_BLK_DEV_HPT34X=m
CONFIG_BLK_DEV_HPT366=m
CONFIG_BLK_DEV_SC1200=m
CONFIG_BLK_DEV_PIIX=m
CONFIG_BLK_DEV_NS87415=m
CONFIG_BLK_DEV_PDC202XX_OLD=m
CONFIG_BLK_DEV_PDC202XX_NEW=m
CONFIG_BLK_DEV_SVWKS=m
CONFIG_BLK_DEV_SIIMAGE=m
CONFIG_BLK_DEV_SIS5513=m
CONFIG_BLK_DEV_SLC90E66=m
CONFIG_BLK_DEV_TRM290=m
CONFIG_BLK_DEV_VIA82CXXX=m
CONFIG_IDE_CHIPSETS=y

CONFIG_BLK_DEV_4DRIVES=y
CONFIG_BLK_DEV_ALI14XX=m
CONFIG_BLK_DEV_DTC2278=m
CONFIG_BLK_DEV_HT6560B=m
CONFIG_BLK_DEV_PDC4030=m
CONFIG_BLK_DEV_QD65XX=m
CONFIG_BLK_DEV_UMC8672=m
CONFIG_BLK_DEV_IDEDMA=y
# CONFIG_IDEDMA_IVB is not set
CONFIG_IDEDMA_AUTO=y
# CONFIG_DMA_NONPCI is not set
# CONFIG_BLK_DEV_HD is not set

Thanks in advance,

Attila

