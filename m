Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261217AbTD1RSm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Apr 2003 13:18:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261218AbTD1RSl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Apr 2003 13:18:41 -0400
Received: from atlrel8.hp.com ([156.153.255.206]:2772 "EHLO atlrel8.hp.com")
	by vger.kernel.org with ESMTP id S261217AbTD1RSk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Apr 2003 13:18:40 -0400
Message-ID: <3EAD6572.8622DDC3@hp.com>
Date: Mon, 28 Apr 2003 11:31:30 -0600
From: Alex Williamson <alex_williamson@hp.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.21-rc1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH] 8250_pci include offset in iomap_base
Content-Type: multipart/mixed;
 boundary="------------9D3F5432B968490E5772C96F"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------9D3F5432B968490E5772C96F
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit


   This one-liner is required for PCI serial ports that have multiple
MMIO ports off a single PCI BAR.  Calls to request_mem_resource() fail
after the first one otherwise.  Patch against 2.5.67.  Thanks,

	Alex

--
Alex Williamson                             HP Linux & Open Source Lab
--------------9D3F5432B968490E5772C96F
Content-Type: text/plain; charset=us-ascii;
 name="8250_pci_mmio.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="8250_pci_mmio.diff"

--- linux-2.5.67.clean/drivers/serial/8250_pci.c	2003-04-07 11:32:18.000000000 -0600
+++ linux-2.5.67/drivers/serial/8250_pci.c	2003-04-28 11:08:38.000000000 -0600
@@ -126,7 +126,7 @@
 			return -ENOMEM;
 
 		req->io_type = UPIO_MEM;
-		req->iomap_base = port;
+		req->iomap_base = port + offset;
 		req->iomem_base = priv->remapped_bar[bar] + offset;
 		req->iomem_reg_shift = regshift;
 	} else {

--------------9D3F5432B968490E5772C96F--

