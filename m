Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932208AbVLAM6h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932208AbVLAM6h (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 07:58:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932211AbVLAM6h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 07:58:37 -0500
Received: from gepetto.dc.ltu.se ([130.240.42.40]:26366 "EHLO
	gepetto.dc.ltu.se") by vger.kernel.org with ESMTP id S932208AbVLAM6h
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 07:58:37 -0500
Date: Thu, 1 Dec 2005 13:58:29 +0100 (MET)
From: Richard Knutsson <ricknu-0@student.ltu.se>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, Richard Knutsson <ricknu-0@student.ltu.se>
Message-Id: <20051201130338.28376.65935.sendpatchset@thinktank.campus.ltu.se>
Subject: [PATCH 2.6.15-rc3-mm1 0/3] -mm patches to replace pci_module_init() with pci_register_driver()
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

An additional serie to replace the obsolete pci_module_init() with pci_register_driver() in the -mm tree. Last patch #if 0's pci_module_init().

Because pci_module_init() is implemented as:
pci.h:352 #define pci_module_init pci_register_driver
the replacment should not effect anything.

Doing "find . -name *.[chS] | xargs grep -n pci_module_init" in the patched tree results in:
./sound/oss/es1371.c:97: *                       Use pci_module_init
./include/linux/pci.h:350: * pci_module_init is obsolete, this stays here till we fix up all usages of it
./include/linux/pci.h:353:#define pci_module_init       pci_register_driver
./drivers/net/3c59x.c:41:    - Set vortex_have_pci if pci_module_init returns zero (fixes cardbus
./drivers/media/dvb/b2c2/flexcop-pci.c:418:static int __init flexcop_pci_module_init(void)
./drivers/media/dvb/b2c2/flexcop-pci.c:428:module_init(flexcop_pci_module_init);

It is just sent to lkml in hope that the changes are to small and to spread for mailing every maintainer. Will you pick this up too, Andrew?

Any comment is welcome.

/Richard
