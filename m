Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751294AbWJFEyt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751294AbWJFEyt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 00:54:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751799AbWJFEyt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 00:54:49 -0400
Received: from mail01.verismonetworks.com ([164.164.99.228]:49845 "EHLO
	mail01.verismonetworks.com") by vger.kernel.org with ESMTP
	id S1751294AbWJFEyr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 00:54:47 -0400
Subject: [PATCH 3/5] ioremap balanced with iounmap for drivers/char/moxa.c
From: Amol Lad <amol@verismonetworks.com>
To: linux kernel <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>
Content-Type: text/plain
Date: Fri, 06 Oct 2006 10:27:09 +0530
Message-Id: <1160110629.19143.90.camel@amol.verismonetworks.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Amol Lad <amol@verismonetworks.com>
---
 moxa.c |    6 ++++++
 1 files changed, 6 insertions(+)
---
diff -uprN -X linux-2.6.19-rc1-orig/Documentation/dontdiff linux-2.6.19-rc1-orig/drivers/char/moxa.c linux-2.6.19-rc1/drivers/char/moxa.c
--- linux-2.6.19-rc1-orig/drivers/char/moxa.c	2006-10-05 14:00:43.000000000 +0530
+++ linux-2.6.19-rc1/drivers/char/moxa.c	2006-10-05 14:50:00.000000000 +0530
@@ -493,6 +493,12 @@ static void __exit moxa_exit(void)
 	if (tty_unregister_driver(moxaDriver))
 		printk("Couldn't unregister MOXA Intellio family serial driver\n");
 	put_tty_driver(moxaDriver);
+	
+	for (i = 0; i < MAX_BOARDS; i++) {
+		if (moxaBaseAddr[i])
+			iounmap(moxaBaseAddr[i]);
+	}
+	
 	if (verbose)
 		printk("Done\n");
 }


