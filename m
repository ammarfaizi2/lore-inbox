Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267936AbUJLWLF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267936AbUJLWLF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 18:11:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267961AbUJLWLE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 18:11:04 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:59035 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S267936AbUJLWKj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 18:10:39 -0400
Date: Tue, 12 Oct 2004 15:07:06 -0700
From: Hanna Linder <hannal@us.ibm.com>
To: sfeldma@pobox.com
cc: Hanna Linder <hannal@us.ibm.com>, lkml <linux-kernel@vger.kernel.org>,
       kernel-janitors <kernel-janitors@lists.osdl.org>, greg@kroah.com,
       wli@holomorphy.com
Subject: Re: [KJ] [RFT 2.6] ebus.c replace pci_find_device with	pci_get_device
Message-ID: <148640000.1097618825@w-hlinder.beaverton.ibm.com>
In-Reply-To: <1097342008.3903.12.camel@sfeldma-mobl2.dsl-verizon.net>
References: <83130000.1097274406@w-hlinder.beaverton.ibm.com> <1097342008.3903.12.camel@sfeldma-mobl2.dsl-verizon.net>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--On Saturday, October 09, 2004 10:13:28 AM -0700 Scott Feldman <sfeldma@pobox.com> wrote:
> If we can get out of the while() with pdev != NULL, then a
> pci_dev_put(pdev) cleanup is required.  
> 
> -scott

Here is the new patch. Thanks Scott.

Signed-off-by: Hanna Linder <hannal@us.ibm.com>

diff -Nrup linux-2.6.9-rc4-mm1cln/arch/sparc/kernel/ebus.c linux-2.6.9-rc4-mm1patch/arch/sparc/kernel/ebus.c
--- linux-2.6.9-rc4-mm1cln/arch/sparc/kernel/ebus.c	2004-10-12 14:15:31.000000000 -0700
+++ linux-2.6.9-rc4-mm1patch/arch/sparc/kernel/ebus.c	2004-10-12 14:53:55.369254888 -0700
@@ -275,7 +275,7 @@ void __init ebus_init(void)
 		}
 	}
 
-	pdev = pci_find_device(PCI_VENDOR_ID_SUN, PCI_DEVICE_ID_SUN_EBUS, 0);
+	pdev = pci_get_device(PCI_VENDOR_ID_SUN, PCI_DEVICE_ID_SUN_EBUS, 0);
 	if (!pdev) {
 		return;
 	}
@@ -342,7 +342,7 @@ void __init ebus_init(void)
 		}
 
 	next_ebus:
-		pdev = pci_find_device(PCI_VENDOR_ID_SUN,
+		pdev = pci_get_device(PCI_VENDOR_ID_SUN,
 				       PCI_DEVICE_ID_SUN_EBUS, pdev);
 		if (!pdev)
 			break;
@@ -356,4 +356,6 @@ void __init ebus_init(void)
 		ebus->next = 0;
 		++num_ebus;
 	}
+	if(pdev)
+		pci_dev_put(pdev);
 }

