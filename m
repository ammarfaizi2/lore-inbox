Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268079AbUJCSyX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268079AbUJCSyX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Oct 2004 14:54:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268082AbUJCSyX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Oct 2004 14:54:23 -0400
Received: from smtp07.web.de ([217.72.192.225]:38029 "EHLO smtp07.web.de")
	by vger.kernel.org with ESMTP id S268079AbUJCSyE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Oct 2004 14:54:04 -0400
Date: Sun, 3 Oct 2004 21:02:37 +0200
From: Hanno Meyer-Thurow <h.mth@web.de>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc3-mm1, bk-pci patch, USB hubs
Message-Id: <20041003210237.1c1a6132.h.mth@web.de>
X-Mailer: Sylpheed version 0.9.12-gtk2-20040918 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jon,

> These changes make the USB hub module fail to load. I get a trap in
> kmem_cache_alloc called from uhci_alloc_urb_private. Reverting them
> fixes it.

I use EHCI and UHCI and i just had to revert only the part for UHCI. EHCI works just fine here!


This part reverting:

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
