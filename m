Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422687AbWJLBrV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422687AbWJLBrV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 21:47:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422683AbWJLBrV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 21:47:21 -0400
Received: from havoc.gtf.org ([69.61.125.42]:5856 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S1422685AbWJLBrU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 21:47:20 -0400
Date: Wed, 11 Oct 2006 21:47:20 -0400
From: Jeff Garzik <jeff@garzik.org>
To: linux-serial@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] serial: handle pci_enable_device() failure upon resume
Message-ID: <20061012014720.GA12935@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Signed-off-by: Jeff Garzik <jeff@garzik.org>

---

 drivers/serial/8250_pci.c    |    8 ++++++--

diff --git a/drivers/serial/8250_pci.c b/drivers/serial/8250_pci.c
index 4d0ff8f..aa96e94 100644
--- a/drivers/serial/8250_pci.c
+++ b/drivers/serial/8250_pci.c
@@ -1810,16 +1810,20 @@ static int pciserial_resume_one(struct p
 	pci_restore_state(dev);
 
 	if (priv) {
+		int rc;
+
 		/*
 		 * The device may have been disabled.  Re-enable it.
 		 */
-		pci_enable_device(dev);
+		rc = pci_enable_device(dev);
+		if (rc)
+			return rc;
 
 		pciserial_resume_ports(priv);
 	}
 	return 0;
 }
-#endif
+#endif /* CONFIG_PM */
 
 static struct pci_device_id serial_pci_tbl[] = {
 	{	PCI_VENDOR_ID_V3, PCI_DEVICE_ID_V3_V960,
