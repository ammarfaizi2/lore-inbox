Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285251AbRLSLKH>; Wed, 19 Dec 2001 06:10:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285250AbRLSLJ5>; Wed, 19 Dec 2001 06:09:57 -0500
Received: from www.deepbluesolutions.co.uk ([212.18.232.186]:53254 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S285241AbRLSLJq>; Wed, 19 Dec 2001 06:09:46 -0500
Date: Tue, 18 Dec 2001 23:50:24 +0000
From: Russell King <rmk@flint.arm.linux.org.uk>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] PCI updates - 32-bit IO support
Message-ID: <20011218235024.N13126@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have here a system which requires 32-bit IO addressing on its PCI
busses.  Currently, Linux zeros the upper IO base/limit registers on
all PCI bridges, which prevents addresses being forwarded on this
system.

The following patch the upper IO base/limit registers to be set
appropriately by the PCI layer.

This patch is being sent for review, and is targetted solely at 2.5.

diff -ur orig/drivers/pci/setup-bus.c linux/drivers/pci/setup-bus.c
--- orig/drivers/pci/setup-bus.c	Sun Oct 14 20:53:14 2001
+++ linux/drivers/pci/setup-bus.c	Tue Dec 18 23:20:13 2001
@@ -148,7 +181,10 @@
 	pci_write_config_dword(bridge, PCI_IO_BASE, l);
 
 	/* Clear upper 16 bits of I/O base/limit. */
-	pci_write_config_dword(bridge, PCI_IO_BASE_UPPER16, 0);
+	pci_write_config_word(bridge, PCI_IO_BASE_UPPER16,
+			ranges.io_start >> 16);
+	pci_write_config_word(bridge, PCI_IO_LIMIT_UPPER16,
+			ranges.io_end >> 16);
 
 	/* Clear out the upper 32 bits of PREF base/limit. */
 	pci_write_config_dword(bridge, PCI_PREF_BASE_UPPER32, 0);


--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

