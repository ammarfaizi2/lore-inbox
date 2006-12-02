Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162776AbWLBEih@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162776AbWLBEih (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 23:38:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162777AbWLBEig
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 23:38:36 -0500
Received: from mta11.adelphia.net ([68.168.78.205]:65247 "EHLO
	mta11.adelphia.net") by vger.kernel.org with ESMTP id S1162776AbWLBEif
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 23:38:35 -0500
Date: Fri, 1 Dec 2006 22:38:34 -0600
From: Corey Minyard <minyard@acm.org>
To: Andrew Morton <akpm@osdl.org>, Linux Kernel <linux-kernel@vger.kernel.org>
Cc: OpenIPMI Developers <openipmi-developer@lists.sourceforge.net>
Subject: [PATCH 10/12] IPMI: fix pci warning
Message-ID: <20061202043834.GF30531@localdomain>
Reply-To: minyard@acm.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Change pci_module_init() to the new interface, and check the return
code to avoid warnings and give the user useful information if this
fails.

Signed-off-by: Corey Minyard <minyard@acm.org>

Index: linux-2.6.19/drivers/char/ipmi/ipmi_si_intf.c
===================================================================
--- linux-2.6.19.orig/drivers/char/ipmi/ipmi_si_intf.c
+++ linux-2.6.19/drivers/char/ipmi/ipmi_si_intf.c
@@ -2827,7 +2827,12 @@ static __devinit int init_ipmi_si(void)
 #endif
 
 #ifdef CONFIG_PCI
-	pci_module_init(&ipmi_pci_driver);
+	rv = pci_register_driver(&ipmi_pci_driver);
+	if (rv){
+		printk(KERN_ERR
+		       "init_ipmi_si: Unable to register PCI driver: %d\n",
+		       rv);
+	}
 #endif
 
 	if (si_trydefaults) {
