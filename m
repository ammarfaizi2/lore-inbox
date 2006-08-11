Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964801AbWHKWOu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964801AbWHKWOu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Aug 2006 18:14:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964797AbWHKWOt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Aug 2006 18:14:49 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:3509 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S964801AbWHKWOs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Aug 2006 18:14:48 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=lUqxJLp224PX/u6/1x67T7hEsdeVtLith4LOyWAEKuZ3/XPoRKBgdnfoCZPvjjdBFoNSzzQqNopDy5V8B0eQtYSCCCgYpiatCfOwZhjFSV+vRxEpBiFLO7zf5OBnAO7l1FjD23hzAxoVgcl6HuU2jeEfyxP9iGLNwQhxv05Exg4=
Date: Sat, 12 Aug 2006 02:14:47 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] CONFIG_PM=n slim: drivers/parport/parport_serial.c
Message-ID: <20060811221447.GG6847@martell.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 drivers/parport/parport_serial.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/parport/parport_serial.c
+++ b/drivers/parport/parport_serial.c
@@ -374,6 +374,7 @@ static void __devexit parport_serial_pci
 	return;
 }
 
+#ifdef CONFIG_PM
 static int parport_serial_pci_suspend(struct pci_dev *dev, pm_message_t state)
 {
 	struct parport_serial_private *priv = pci_get_drvdata(dev);
@@ -407,14 +408,17 @@ static int parport_serial_pci_resume(str
 
 	return 0;
 }
+#endif
 
 static struct pci_driver parport_serial_pci_driver = {
 	.name		= "parport_serial",
 	.id_table	= parport_serial_pci_tbl,
 	.probe		= parport_serial_pci_probe,
 	.remove		= __devexit_p(parport_serial_pci_remove),
+#ifdef CONFIG_PM
 	.suspend	= parport_serial_pci_suspend,
 	.resume		= parport_serial_pci_resume,
+#endif
 };
 
 

