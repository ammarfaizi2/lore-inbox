Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263091AbTI3Bbr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 21:31:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263092AbTI3Bbr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 21:31:47 -0400
Received: from brouzouf.zelya.net ([62.212.116.7]:47306 "EHLO
	brouzouf.zelya.net") by vger.kernel.org with ESMTP id S263091AbTI3Bbo convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 21:31:44 -0400
Subject: [2.6.0-test6] broken IDE modules support
From: =?ISO-8859-1?Q?S=E9bastien?= Villemot <Sebastien.Villemot@ens.fr>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-15
Message-Id: <1064885485.1253.8.camel@noustoulight.lan.zelya.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 30 Sep 2003 03:31:26 +0200
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

In 2.6.0-test6, when compiling IDE support as modules, I get the
following errors with depmod:

root@noustoulight:~# uname -a
Linux noustoulight 2.6.0-test6 #1 Tue Sep 30 02:38:55 CEST 2003 i686
GNU/Linux
root@noustoulight:~# depmod -a
WARNING: Module /lib/modules/2.6.0-test6/kernel/drivers/ide/ide.ko
ignored, due to loop
WARNING: Module
/lib/modules/2.6.0-test6/kernel/drivers/ide/ide-taskfile.ko ignored, due
to loop
WARNING: Module
/lib/modules/2.6.0-test6/kernel/drivers/ide/pci/via82cxxx.ko ignored,
due to loop
WARNING: Loop detected:
/lib/modules/2.6.0-test6/kernel/drivers/ide/ide-iops.ko needs ide.ko
which needs ide-iops.ko again!
WARNING: Module /lib/modules/2.6.0-test6/kernel/drivers/ide/ide-iops.ko
ignored, due to loop
WARNING: Module /lib/modules/2.6.0-test6/kernel/drivers/ide/ide-io.ko
ignored, due to loop
WARNING: Module /lib/modules/2.6.0-test6/kernel/drivers/ide/ide-disk.ko
ignored, due to loop
WARNING: Module /lib/modules/2.6.0-test6/kernel/drivers/ide/ide-probe.ko
ignored, due to loop
WARNING: Module /lib/modules/2.6.0-test6/kernel/drivers/ide/ide-cd.ko
ignored, due to loop
WARNING: Module
/lib/modules/2.6.0-test6/kernel/drivers/ide/ide-default.ko ignored, due
to loop

There are also some warnings during the compilation, about the use of
deprecated macros (MOD_INC_COUNT or something like this, I haven't
logged it).

  Sébastien Villemot



P.S.: Here is the IDE part of my kernel config:

#
# Please see Documentation/ide.txt for help/info on IDE drives
#
# CONFIG_BLK_DEV_HD_IDE is not set
CONFIG_BLK_DEV_IDEDISK=m
# CONFIG_IDEDISK_MULTI_MODE is not set
# CONFIG_IDEDISK_STROKE is not set
CONFIG_BLK_DEV_IDECD=m
# CONFIG_BLK_DEV_IDETAPE is not set
# CONFIG_BLK_DEV_IDEFLOPPY is not set
# CONFIG_BLK_DEV_IDESCSI is not set
# CONFIG_IDE_TASK_IOCTL is not set
CONFIG_IDE_TASKFILE_IO=y

#
# IDE chipset support/bugfixes
#
# CONFIG_BLK_DEV_CMD640 is not set
# CONFIG_BLK_DEV_IDEPNP is not set
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
# CONFIG_BLK_DEV_OFFBOARD is not set
# CONFIG_BLK_DEV_GENERIC is not set
# CONFIG_BLK_DEV_OPTI621 is not set
# CONFIG_BLK_DEV_RZ1000 is not set
CONFIG_BLK_DEV_IDEDMA_PCI=y
# CONFIG_BLK_DEV_IDE_TCQ is not set
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
CONFIG_IDEDMA_PCI_AUTO=y
# CONFIG_IDEDMA_ONLYDISK is not set
# CONFIG_IDEDMA_PCI_WIP is not set
CONFIG_BLK_DEV_ADMA=y
# CONFIG_BLK_DEV_AEC62XX is not set
# CONFIG_BLK_DEV_ALI15X3 is not set
# CONFIG_BLK_DEV_AMD74XX is not set
# CONFIG_BLK_DEV_CMD64X is not set
# CONFIG_BLK_DEV_TRIFLEX is not set
# CONFIG_BLK_DEV_CY82C693 is not set
# CONFIG_BLK_DEV_CS5520 is not set
# CONFIG_BLK_DEV_CS5530 is not set
# CONFIG_BLK_DEV_HPT34X is not set
# CONFIG_BLK_DEV_HPT366 is not set
# CONFIG_BLK_DEV_SC1200 is not set
# CONFIG_BLK_DEV_PIIX is not set
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_PDC202XX_OLD is not set
# CONFIG_BLK_DEV_PDC202XX_NEW is not set
# CONFIG_BLK_DEV_SVWKS is not set
# CONFIG_BLK_DEV_SIIMAGE is not set
# CONFIG_BLK_DEV_SIS5513 is not set
# CONFIG_BLK_DEV_SLC90E66 is not set
# CONFIG_BLK_DEV_TRM290 is not set
CONFIG_BLK_DEV_VIA82CXXX=m
# CONFIG_IDE_CHIPSETS is not set
CONFIG_BLK_DEV_IDEDMA=y
# CONFIG_IDEDMA_IVB is not set
CONFIG_IDEDMA_AUTO=y
# CONFIG_DMA_NONPCI is not set
# CONFIG_BLK_DEV_HD is not set


