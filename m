Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751227AbVLLLIe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751227AbVLLLIe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Dec 2005 06:08:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751230AbVLLLIe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Dec 2005 06:08:34 -0500
Received: from mail.gmx.de ([213.165.64.21]:30901 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751229AbVLLLId (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Dec 2005 06:08:33 -0500
X-Authenticated: #704063
Subject: [PATCH 2/2] Fix ipmi_poweroff compilation without procfs
From: Eric Sesterhenn / snakebyte <snakebyte@gmx.de>
To: linux-kernel@vger.kernel.org
Cc: sdake@mvista.com
Content-Type: text/plain
Date: Mon, 12 Dec 2005 12:08:30 +0100
Message-Id: <1134385710.30934.6.camel@alice>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes ipmi compilation when procfs is disabled

Signed-off-by: Eric Sesterhenn <snakebyte@gmx.de>

--- linux-2.6.15-rc5/drivers/char/ipmi/ipmi_poweroff.c.orig	2005-12-08 12:11:03.000000000 +0100
+++ linux-2.6.15-rc5/drivers/char/ipmi/ipmi_poweroff.c	2005-12-08 12:12:42.000000000 +0100
@@ -613,7 +613,9 @@ static int ipmi_poweroff_init (void)
 
 	rv = ipmi_smi_watcher_register(&smi_watcher);
 	if (rv) {
+#ifdef CONFIG_PROC_FS
 		unregister_sysctl_table(ipmi_table_header);
+#endif
 		printk(KERN_ERR PFX "Unable to register SMI watcher: %d\n", rv);
 		goto out_err;
 	}


