Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291512AbSBMK0X>; Wed, 13 Feb 2002 05:26:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291517AbSBMK0M>; Wed, 13 Feb 2002 05:26:12 -0500
Received: from panoramix.vasoftware.com ([198.186.202.147]:27105 "EHLO
	mail2.vasoftware.com") by vger.kernel.org with ESMTP
	id <S291512AbSBMK0F>; Wed, 13 Feb 2002 05:26:05 -0500
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15466.16106.524471.360281@argo.ozlabs.ibm.com>
Date: Wed, 13 Feb 2002 21:24:42 +1100 (EST)
To: linux-kernel@vger.kernel.org, dbrownell@users.sourceforge.net
Subject: [PATCH] USB OHCI powerbook fix (v2.5.4)
X-Mailer: VM 6.75 under Emacs 20.7.2
Reply-To: paulus@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below fixes a compile problem in the USB OHCI HCD driver on
powerbooks, namely that the ohci_hcd structure doesn't have an irq
member.

Paul.

diff -urN linux-2.5/drivers/usb/hcd/ohci-hcd.c pmac-2.5/drivers/usb/hcd/ohci-hcd.c
--- linux-2.5/drivers/usb/hcd/ohci-hcd.c	Sun Feb 10 20:59:48 2002
+++ pmac-2.5/drivers/usb/hcd/ohci-hcd.c	Mon Feb 11 18:47:58 2002
@@ -662,7 +662,7 @@
 		
  #ifdef CONFIG_PMAC_PBOOK
 	if (_machine == _MACH_Pmac)
-		disable_irq (ohci->irq);
+		disable_irq (hcd->pdev->irq);
  	/* else, 2.4 assumes shared irqs -- don't disable */
  #endif
 
@@ -836,7 +836,7 @@
 
  #ifdef CONFIG_PMAC_PBOOK
 		if (_machine == _MACH_Pmac)
-			enable_irq (ohci->irq);
+			enable_irq (hcd->pdev->irq);
  #endif
 		if (ohci->hcca->done_head)
 			dl_done_list (ohci, dl_reverse_done_list (ohci));
