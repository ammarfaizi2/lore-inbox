Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269039AbUJTS4C@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269039AbUJTS4C (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 14:56:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269063AbUJTSzX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 14:55:23 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:30599 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S268937AbUJTSvT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 14:51:19 -0400
Date: Wed, 20 Oct 2004 11:51:17 -0700
From: Hanna Linder <hannal@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>,
       kernel-janitors <kernel-janitors@lists.osdl.org>
cc: Hanna Linder <hannal@us.ibm.com>, greg@kroah.com, davej@codemonkey.org.uk
Subject: [RFT 2.6] generic.c: replace pci_find_device with pci_get_device
Message-ID: <17100000.1098298277@w-hlinder.beaverton.ibm.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As pci_find_device is going away soon I have converted this file to use
pci_get_device instead. I have compile tested it. If anyone has this hardware
and could test it that would be great.

Hanna Linder
IBM Linux Technology Center

Signed-off-by: Hanna Linder <hannal@us.ibm.com>
---

diff -Nrup linux-2.6.9cln/drivers/char/agp/generic.c linux-2.6.9patch/drivers/char/agp/generic.c
--- linux-2.6.9cln/drivers/char/agp/generic.c	2004-10-18 16:35:52.000000000 -0700
+++ linux-2.6.9patch/drivers/char/agp/generic.c	2004-10-18 17:20:56.000000000 -0700
@@ -507,7 +507,7 @@ u32 agp_collect_device_status(u32 mode, 
 	u32 tmp;
 	u32 agp3;
 
-	while ((device = pci_find_device(PCI_ANY_ID, PCI_ANY_ID, device)) != NULL) {
+	for_each_pci_dev(device) {
 		cap_ptr = pci_find_capability(device, PCI_CAP_ID_AGP);
 		if (!cap_ptr)
 			continue;
@@ -551,7 +551,7 @@ void agp_device_command(u32 command, int
 	if (agp_v3)
 		mode *= 4;
 
-	while ((device = pci_find_device(PCI_ANY_ID, PCI_ANY_ID, device)) != NULL) {
+	for_each_pci_dev(device) {
 		u8 agp = pci_find_capability(device, PCI_CAP_ID_AGP);
 		if (!agp)
 			continue;


