Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263930AbTFZUQP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jun 2003 16:16:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263921AbTFZUPS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jun 2003 16:15:18 -0400
Received: from air-2.osdl.org ([65.172.181.6]:3036 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263782AbTFZUN2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jun 2003 16:13:28 -0400
Date: Thu, 26 Jun 2003 13:27:40 -0700
From: Bob Miller <rem@osdl.org>
To: trivial@rustcorp.com.au
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2.5.73 TRIVIAL] Remove racy check_mem_region() call from pcbit/drv.c
Message-ID: <20030626202740.GE16162@doc.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Removed the check_mem_region() call and replaced with request_mem_region().

--
Bob Miller                                      Email: rem@osdl.org
Open Source Development Lab                     Phone: 503.626.2455 Ext. 17

diff -Nru a/drivers/isdn/pcbit/drv.c b/drivers/isdn/pcbit/drv.c
--- a/drivers/isdn/pcbit/drv.c	Wed Jun 25 16:18:28 2003
+++ b/drivers/isdn/pcbit/drv.c	Wed Jun 25 16:18:28 2003
@@ -87,15 +87,13 @@
 
 	if (mem_base >= 0xA0000 && mem_base <= 0xFFFFF ) {
 		dev->ph_mem = mem_base;
-		if (check_mem_region(dev->ph_mem, 4096)) {
+		if (!request_mem_region(dev->ph_mem, 4096, "PCBIT mem")) {
 			printk(KERN_WARNING
 				"PCBIT: memory region %lx-%lx already in use\n",
 				dev->ph_mem, dev->ph_mem + 4096);
 			kfree(dev);
 			dev_pcbit[board] = NULL;
 			return -EACCES;
-		} else {
-			request_mem_region(dev->ph_mem, 4096, "PCBIT mem");
 		}
 		dev->sh_mem = (unsigned char*)ioremap(dev->ph_mem, 4096);
 	}
