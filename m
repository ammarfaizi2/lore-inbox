Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261226AbULAFmR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261226AbULAFmR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Dec 2004 00:42:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261222AbULAFmR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Dec 2004 00:42:17 -0500
Received: from fmr17.intel.com ([134.134.136.16]:10203 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S261231AbULAFmH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Dec 2004 00:42:07 -0500
Subject: Re: [ACPI] Re: Fw: ACPI bug causes cd-rom lock-ups (2.6.10-rc2)
From: Len Brown <len.brown@intel.com>
To: Stas Sergeev <stsp@aknet.ru>
Cc: Andrew Morton <akpm@osdl.org>, Linux kernel <linux-kernel@vger.kernel.org>,
       ACPI Developers <acpi-devel@lists.sourceforge.net>,
       Shaohua Li <shaohua.li@intel.com>
In-Reply-To: <41A621DD.8060102@aknet.ru>
References: <41990138.7080008@aknet.ru> <1101190148.19999.394.camel@d845pe>
	 <41A4CF1C.6090503@aknet.ru> <1101336267.20008.5326.camel@d845pe>
	 <41A621DD.8060102@aknet.ru>
Content-Type: multipart/mixed; boundary="=-5ycK+gAFzk7SRJ0mB3Gt"
Organization: 
Message-Id: <1101879708.8028.62.camel@d845pe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 01 Dec 2004 00:41:49 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-5ycK+gAFzk7SRJ0mB3Gt
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Thanks for running the tests.
Please confirm that this patch make the problem go away in the 
CONFIG_PNP_ACPI=y configuration.

-Len


--=-5ycK+gAFzk7SRJ0mB3Gt
Content-Disposition: attachment; filename=pnp.patch
Content-Type: text/plain; name=pnp.patch; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

===== drivers/acpi/pci_link.c 1.35 vs edited =====
--- 1.35/drivers/acpi/pci_link.c	2004-11-09 03:08:36 -05:00
+++ edited/drivers/acpi/pci_link.c	2004-12-01 00:38:18 -05:00
@@ -791,9 +791,16 @@
 	return 1;
 }
 
+/*
+ * We'd like PNP to call this routine for the
+ * single ISA_USED value for each legacy device.
+ * But instead it calls us with each POSSIBLE setting.
+ * There is no ISA_POSSIBLE weight, so we simply use
+ * the (small) PCI_USING penalty.
+ */
 void acpi_penalize_isa_irq(int irq)
 {
-	acpi_irq_penalty[irq] += PIRQ_PENALTY_ISA_USED;
+	acpi_irq_penalty[irq] += PIRQ_PENALTY_PCI_USING;
 }
 
 /*

--=-5ycK+gAFzk7SRJ0mB3Gt--

