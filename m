Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262734AbUKMB4V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262734AbUKMB4V (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Nov 2004 20:56:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262733AbUKLXlm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Nov 2004 18:41:42 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.106]:8441 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262707AbUKLXWx convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Nov 2004 18:22:53 -0500
X-Fake: the user-agent is fake
Subject: Re: [PATCH] PCI fixes for 2.6.10-rc1
User-Agent: Mutt/1.5.6i
In-Reply-To: <11003017203241@kroah.com>
Date: Fri, 12 Nov 2004 15:22:00 -0800
Message-Id: <1100301720747@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2091.1.22, 2004/11/12 14:11:29-08:00, hannal@us.ibm.com

[PATCH] pcore.c: replace pci_find_device with pci_get_device

As pci_find_device is going away I've replaced it with pci_get_device
and pci_dev_put.


Signed-off-by: Hanna Linder <hannal@us.ibm.com>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 arch/ppc/platforms/pcore.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletion(-)


diff -Nru a/arch/ppc/platforms/pcore.c b/arch/ppc/platforms/pcore.c
--- a/arch/ppc/platforms/pcore.c	2004-11-12 15:09:19 -08:00
+++ b/arch/ppc/platforms/pcore.c	2004-11-12 15:09:19 -08:00
@@ -89,7 +89,7 @@
 {
 	struct pci_dev *dev;
 
-	if ((dev = pci_find_device(PCI_VENDOR_ID_WINBOND,
+	if ((dev = pci_get_device(PCI_VENDOR_ID_WINBOND,
 				PCI_DEVICE_ID_WINBOND_83C553,
 				0)))
 	{
@@ -108,6 +108,7 @@
 		 */
  		outb(0x00, PCORE_WINBOND_PRI_EDG_LVL);
 		outb(0x1e, PCORE_WINBOND_SEC_EDG_LVL);
+		pci_dev_put(dev);
 	}
 }
 

