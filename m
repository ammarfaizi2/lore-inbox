Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268064AbUJCSeP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268064AbUJCSeP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Oct 2004 14:34:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268076AbUJCSeP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Oct 2004 14:34:15 -0400
Received: from rproxy.gmail.com ([64.233.170.195]:32385 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S268064AbUJCSdv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Oct 2004 14:33:51 -0400
Message-ID: <9e473391041003113351c6e237@mail.gmail.com>
Date: Sun, 3 Oct 2004 14:33:48 -0400
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: lkml <linux-kernel@vger.kernel.org>
Subject: 2.6.9-rc3-mm1, bk-pci patch, USB hubs
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

These changes make the USB hub module fail to load. I get a trap in
kmem_cache_alloc called from uhci_alloc_urb_private. Reverting them
fixes it.

diff -Nru a/drivers/usb/host/ehci-hcd.c b/drivers/usb/host/ehci-hcd.c
--- a/drivers/usb/host/ehci-hcd.c       2004-10-03 14:22:49 -04:00
+++ b/drivers/usb/host/ehci-hcd.c       2004-10-03 14:22:49 -04:00
@@ -1092,7 +1092,7 @@
                sizeof (struct ehci_qh), sizeof (struct ehci_qtd),
                sizeof (struct ehci_itd), sizeof (struct ehci_sitd));

-       return pci_module_init (&ehci_pci_driver);
+       return pci_register_driver (&ehci_pci_driver);
 }
 module_init (init);

diff -Nru a/drivers/usb/host/ohci-pci.c b/drivers/usb/host/ohci-pci.c
--- a/drivers/usb/host/ohci-pci.c       2004-10-03 14:22:49 -04:00
+++ b/drivers/usb/host/ohci-pci.c       2004-10-03 14:22:49 -04:00
@@ -279,7 +279,7 @@

        pr_debug ("%s: block sizes: ed %Zd td %Zd\n", hcd_name,
                sizeof (struct ed), sizeof (struct td));
-       return pci_module_init (&ohci_pci_driver);
+       return pci_register_driver (&ohci_pci_driver);
 }
 module_init (ohci_hcd_pci_init);

diff -Nru a/drivers/usb/host/uhci-hcd.c b/drivers/usb/host/uhci-hcd.c
--- a/drivers/usb/host/uhci-hcd.c       2004-10-03 14:22:49 -04:00
+++ b/drivers/usb/host/uhci-hcd.c       2004-10-03 14:22:49 -04:00
@@ -2534,7 +2534,7 @@
        if (!uhci_up_cachep)
                goto up_failed;

-       retval = pci_module_init(&uhci_pci_driver);
+       retval = pci_register_driver(&uhci_pci_driver);
        if (retval)
                goto init_failed;


-- 
Jon Smirl
jonsmirl@gmail.com
