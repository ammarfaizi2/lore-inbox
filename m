Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262729AbUKMCdb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262729AbUKMCdb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Nov 2004 21:33:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262689AbUKLXXt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Nov 2004 18:23:49 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.102]:41869 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262690AbUKLXWo convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Nov 2004 18:22:44 -0500
X-Fake: the user-agent is fake
Subject: Re: [PATCH] PCI fixes for 2.6.10-rc1
User-Agent: Mutt/1.5.6i
In-Reply-To: <1100301720892@kroah.com>
Date: Fri, 12 Nov 2004 15:22:00 -0800
Message-Id: <1100301720628@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2091.1.17, 2004/11/12 14:09:41-08:00, hannal@us.ibm.com

[PATCH] ebus.c: replace pci_find_device with pci_get_device

Signed-off-by: Hanna Linder <hannal@us.ibm.com>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 arch/sparc/kernel/ebus.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)


diff -Nru a/arch/sparc/kernel/ebus.c b/arch/sparc/kernel/ebus.c
--- a/arch/sparc/kernel/ebus.c	2004-11-12 15:09:57 -08:00
+++ b/arch/sparc/kernel/ebus.c	2004-11-12 15:09:57 -08:00
@@ -275,7 +275,7 @@
 		}
 	}
 
-	pdev = pci_find_device(PCI_VENDOR_ID_SUN, PCI_DEVICE_ID_SUN_EBUS, 0);
+	pdev = pci_get_device(PCI_VENDOR_ID_SUN, PCI_DEVICE_ID_SUN_EBUS, 0);
 	if (!pdev) {
 		return;
 	}
@@ -342,7 +342,7 @@
 		}
 
 	next_ebus:
-		pdev = pci_find_device(PCI_VENDOR_ID_SUN,
+		pdev = pci_get_device(PCI_VENDOR_ID_SUN,
 				       PCI_DEVICE_ID_SUN_EBUS, pdev);
 		if (!pdev)
 			break;
@@ -356,4 +356,6 @@
 		ebus->next = 0;
 		++num_ebus;
 	}
+	if (pdev)
+		pci_dev_put(pdev);
 }

