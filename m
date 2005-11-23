Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030432AbVKWWhO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030432AbVKWWhO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 17:37:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030435AbVKWWfL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 17:35:11 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:62994 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1030432AbVKWWez (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 17:34:55 -0500
Date: Wed, 23 Nov 2005 23:34:54 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: markus.lidel@shadowconnect.com, linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/message/i2o/pci.c: fix a NULL pointer dereference
Message-ID: <20051123223454.GC3963@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The Coverity checker spotted this obvious NULL pointer dereference.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 21 Nov 2005

--- linux-2.6.15-rc1-mm2-full/drivers/message/i2o/pci.c.old	2005-11-20 21:50:45.000000000 +0100
+++ linux-2.6.15-rc1-mm2-full/drivers/message/i2o/pci.c	2005-11-20 21:51:08.000000000 +0100
@@ -421,8 +421,8 @@
 	i2o_pci_free(c);
 
       free_controller:
-	i2o_iop_free(c);
 	put_device(c->device.parent);
+	i2o_iop_free(c);
 
       disable:
 	pci_disable_device(pdev);

