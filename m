Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265801AbRGGCac>; Fri, 6 Jul 2001 22:30:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265807AbRGGCaX>; Fri, 6 Jul 2001 22:30:23 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:2571 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S265801AbRGGCaO>;
	Fri, 6 Jul 2001 22:30:14 -0400
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15174.29651.71676.639895@tango.paulus.ozlabs.org>
Date: Sat, 7 Jul 2001 12:28:35 +1000 (EST)
To: linux-kernel@vger.kernel.org
Cc: torvalds@transmeta.com
Subject: [PATCH] fix compile error in usb-ohci.c
X-Mailer: VM 6.75 under Emacs 20.7.2
Reply-To: paulus@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following patch fixes a trivial error in drivers/usb/usb-ohci.c,
where a missing argument to ohci_pci_suspend will cause a compile
error if you have powerbook support enabled.

Linus, please apply.

Paul.

diff -urN linux/drivers/usb/usb-ohci.c pmac/drivers/usb/usb-ohci.c
--- linux/drivers/usb/usb-ohci.c	Wed Jul  4 14:33:36 2001
+++ pmac/drivers/usb/usb-ohci.c	Fri Jul  6 16:20:58 2001
@@ -2749,7 +2749,7 @@
 
 		switch (when) {
 		case PBOOK_SLEEP_NOW:
-			ohci_pci_suspend (ohci->ohci_dev);
+			ohci_pci_suspend (ohci->ohci_dev, 3);
 			break;
 		case PBOOK_WAKE:
 			ohci_pci_resume (ohci->ohci_dev);
