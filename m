Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269885AbUJHB1N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269885AbUJHB1N (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 21:27:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267880AbUJHBXy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 21:23:54 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:1998 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S269903AbUJGWvK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 18:51:10 -0400
Date: Thu, 07 Oct 2004 15:51:44 -0700
From: Hanna Linder <hannal@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>
cc: kernel-janitors <kernel-janitors@lists.osdl.org>, greg@kroah.com,
       hannal@us.ibm.com, paulus@samba.org
Subject: [PATCH 2.6][7/12] pcore.c replace pci_find_device with pci_get_device
Message-ID: <30730000.1097189504@w-hlinder.beaverton.ibm.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


As pci_find_device is going away I've replaced it with pci_get_device and pci_dev_put.
If someone with a PPC system could test it I would appreciate it.

Thanks.

Hanna Linder
IBM Linux Technology Center

Signed-off-by: Hanna Linder <hannal@us.ibm.com>

---

diff -Nrup linux-2.6.9-rc3-mm2cln/arch/ppc/platforms/pcore.c linux-2.6.9-rc3-mm2patch2/arch/ppc/platforms/pcore.c
--- linux-2.6.9-rc3-mm2cln/arch/ppc/platforms/pcore.c	2004-09-29 20:03:45.000000000 -0700
+++ linux-2.6.9-rc3-mm2patch2/arch/ppc/platforms/pcore.c	2004-10-07 15:30:31.839323128 -0700
@@ -89,7 +89,7 @@ pcore_pcibios_fixup(void)
 {
 	struct pci_dev *dev;
 
-	if ((dev = pci_find_device(PCI_VENDOR_ID_WINBOND,
+	if ((dev = pci_get_device(PCI_VENDOR_ID_WINBOND,
 				PCI_DEVICE_ID_WINBOND_83C553,
 				0)))
 	{
@@ -108,6 +108,7 @@ pcore_pcibios_fixup(void)
 		 */
  		outb(0x00, PCORE_WINBOND_PRI_EDG_LVL);
 		outb(0x1e, PCORE_WINBOND_SEC_EDG_LVL);
+		pci_dev_put(dev);
 	}
 }
 

