Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268072AbUJVVWG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268072AbUJVVWG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 17:22:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267863AbUJVVEw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 17:04:52 -0400
Received: from atlrel6.hp.com ([156.153.255.205]:58852 "EHLO atlrel6.hp.com")
	by vger.kernel.org with ESMTP id S267916AbUJVVB6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 17:01:58 -0400
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH] PCDP: call acpi_register_gsi() with arguments in correct order
Date: Fri, 22 Oct 2004 15:01:55 -0600
User-Agent: KMail/1.7
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_DVXeB2ZI5/bxEV3"
Message-Id: <200410221501.55931.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_DVXeB2ZI5/bxEV3
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

We were calling acpi_register_gsi() with arguments out of order.

--Boundary-00=_DVXeB2ZI5/bxEV3
Content-Type: text/x-diff;
  charset="us-ascii";
  name="pcdp-swap-arguments.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="pcdp-swap-arguments.patch"

PCDP: call acpi_register_gsi() with arguments in correct order

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

===== drivers/firmware/pcdp.c 1.6 vs edited =====
--- 1.6/drivers/firmware/pcdp.c	2004-07-28 22:58:54 -06:00
+++ edited/drivers/firmware/pcdp.c	2004-10-22 14:55:47 -06:00
@@ -98,8 +98,8 @@
 
 	if (uart_irq_supported(rev, uart)) {
 		port.irq = acpi_register_gsi(uart->gsi,
-			uart_active_high_low(rev, uart),
-			uart_edge_level(rev, uart));
+			uart_edge_level(rev, uart),
+			uart_active_high_low(rev, uart));
 		port.flags |= UPF_AUTO_IRQ;  /* some FW reported wrong GSI */
 		if (uart_pci(rev, uart))
 			port.flags |= UPF_SHARE_IRQ;

--Boundary-00=_DVXeB2ZI5/bxEV3--
