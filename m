Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932454AbVK2X50@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932454AbVK2X50 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Nov 2005 18:57:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751410AbVK2X50
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Nov 2005 18:57:26 -0500
Received: from gepetto.dc.ltu.se ([130.240.42.40]:18115 "EHLO
	gepetto.dc.ltu.se") by vger.kernel.org with ESMTP id S1751409AbVK2X5Z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Nov 2005 18:57:25 -0500
Date: Wed, 30 Nov 2005 00:57:18 +0100 (MET)
From: Richard Knutsson <ricknu-0@student.ltu.se>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Cc: Richard Knutsson <ricknu-0@student.ltu.se>
Message-Id: <20051130000228.1003.95000.sendpatchset@thinktank.campus.ltu.se>
Subject: [PATCH 0/6] Replacing pci_module_init() with pci_register_driver()
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just a serie to replace the obsolete pci_module_init() with pci_register_driver(). Last patch deletes pci_module_init().

Because pci_module_init() is implemented as:
pci.h:352 #define pci_module_init pci_register_driver
the replacment should not effect anything. Just to be sure the serie has been compiled (2.6.15-rc3) with:
make allyesconfig
make
without any error (warnings (unrelated) but no errors).

Doing "find . -name *.[chS] | xargs grep -n pci_module_init" in the patched tree results in:
./sound/oss/es1371.c:97: *                       Use pci_module_init
./drivers/media/dvb/b2c2/flexcop-pci.c:418:static int __init flexcop_pci_module_init(void)
./drivers/media/dvb/b2c2/flexcop-pci.c:428:module_init(flexcop_pci_module_init);

It is just sent to lkml in hope that the changes are to small and to spread for mailing every maintainer. Will you pick this up Andrew?

Any comment is welcome.

/Richard
