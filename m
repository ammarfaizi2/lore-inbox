Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262294AbTEMDbR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 23:31:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262323AbTEMDbR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 23:31:17 -0400
Received: from c16410.randw1.nsw.optusnet.com.au ([210.49.25.29]:18921 "EHLO
	mail.chubb.wattle.id.au") by vger.kernel.org with ESMTP
	id S262294AbTEMDbP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 23:31:15 -0400
From: Peter Chubb <peter@chubb.wattle.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16064.27148.819310.962984@wombat.chubb.wattle.id.au>
Date: Tue, 13 May 2003 13:44:12 +1000
To: linux-kernel@vger.kernel.org
CC: rusty@rustcorp.com.au
Subject: can't build IDE as modules in BK 2.5.69
X-Mailer: VM 7.07 under 21.4 (patch 12) "Portable Code" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


With the 2.5 bk linux as of 2003.05.13, and config options below,
modutils seems to go into a seemingly infinite loop when trying to
buld modules.dep on the resulting module set (and creates an extremely
large modules.dep file -- 95M before the filesystem filled up)

Any ideas?

I'm using gcc 3.2.3 and ld 2.13.90.0.18



CONFIG_IDE=m
CONFIG_BLK_DEV_IDE=m
CONFIG_BLK_DEV_IDEDISK=m
CONFIG_BLK_DEV_IDESCSI=m
CONFIG_BLK_DEV_FLOPPY=m
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_BLK_DEV_GENERIC=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_BLK_DEV_ADMA=y
CONFIG_BLK_DEV_PIIX=m
CONFIG_IDEDMA_AUTO=y


depmod -a output:

WARNING: /lib/modules/2.5.69/kernel/drivers/ide/pci/piix.ko needs
unknown symbol ide_setup_pci_device
WARNING: /lib/modules/2.5.69/kernel/drivers/ide/pci/piix.ko needs
unknown symbol ide_pci_register_host_proc
WARNING: /lib/modules/2.5.69/kernel/drivers/ide/pci/piix.ko needs
unknown symbol ide_setup_dma
WARNING: /lib/modules/2.5.69/kernel/drivers/ide/pci/piix.ko needs
unknown symbol ide_pci_unregister_driver
WARNING: /lib/modules/2.5.69/kernel/drivers/ide/ide-probe.ko needs
unknown symbol ide_bus_type
WARNING: /lib/modules/2.5.69/kernel/drivers/ide/ide-probe.ko needs
unknown symbol do_ide_request
WARNING: /lib/modules/2.5.69/kernel/drivers/ide/ide-probe.ko needs
unknown symbol ide_add_generic_settings
WARNING: /lib/modules/2.5.69/kernel/drivers/ide/ide-floppy.ko needs
unknown symbol proc_ide_read_geometry
WARNING: /lib/modules/2.5.69/kernel/drivers/ide/ide-disk.ko needs
unknown symbol proc_ide_read_geometry
WARNING: Module /lib/modules/2.5.69/kernel/drivers/scsi/ide-scsi.ko
ignored, due to loop
WARNING: Module /lib/modules/2.5.69/kernel/drivers/ide/pci/piix.ko
ignored, due to loop
WARNING: Module /lib/modules/2.5.69/kernel/drivers/ide/ide.ko ignored,
due to loop
WARNING: Module /lib/modules/2.5.69/kernel/drivers/ide/ide-taskfile.ko
ignored, due to loop
WARNING: Module /lib/modules/2.5.69/kernel/drivers/ide/ide-probe.ko
ignored, due to loop

# ls -l /lib/modules/2.5.69
total 93592
lrwxrwxrwx    1 root     staff          25 May 13 13:39 build ->
/usr/src/linux-2.5-wombat
drwxr-xr-x    8 root     staff        4096 May 13 13:39 kernel
-rw-r--r--    1 root     staff           0 May 13 13:39 modules.alias
-rw-r--r--    1 root     staff           0 May 13 13:39 modules.ccwmap
-rw-r--r--    1 root     staff    95735808 May 13 13:39 modules.dep
-rw-r--r--    1 root     staff           0 May 13 13:39 modules.pcimap
-rw-r--r--    1 root     staff           0 May 13 13:39 modules.symbols
-rw-r--r--    1 root     staff           0 May 13 13:39 modules.usbmap


