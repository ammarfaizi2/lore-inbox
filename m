Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262225AbTJFOmP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Oct 2003 10:42:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262228AbTJFOmO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Oct 2003 10:42:14 -0400
Received: from ivoti.terra.com.br ([200.176.3.20]:63683 "EHLO
	ivoti.terra.com.br") by vger.kernel.org with ESMTP id S262225AbTJFOmG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Oct 2003 10:42:06 -0400
Message-ID: <3F81800A.5000500@terra.com.br>
Date: Mon, 06 Oct 2003 11:45:30 -0300
From: Felipe W Damasio <felipewd@terra.com.br>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021226 Debian/1.2.1-9
MIME-Version: 1.0
To: dwmw2@redhat.com
Cc: mtd@infradead.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] Memory leak in mtd/chips/cfi_cmdset_0020
Content-Type: multipart/mixed;
 boundary="------------060200040907000704090502"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060200040907000704090502
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

	Hi David,

	Patch against 2.6.0-test6.

	- Frees a previous allocated kmalloced variable before returning NULL;

	Found by smatch.

	Please consider applying,

Felipe

--------------060200040907000704090502
Content-Type: text/plain;
 name="cfi_cmdset_0020-leak.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cfi_cmdset_0020-leak.patch"

--- linux-2.6.0-test6/drivers/mtd/chips/cfi_cmdset_0020.c.orig	2003-10-06 11:37:31.000000000 -0300
+++ linux-2.6.0-test6/drivers/mtd/chips/cfi_cmdset_0020.c	2003-10-06 11:37:50.000000000 -0300
@@ -208,6 +208,7 @@
 	if (!mtd->eraseregions) { 
 		printk(KERN_ERR "Failed to allocate memory for MTD erase region info\n");
 		kfree(cfi->cmdset_priv);
+		kfree(mtd);
 		return NULL;
 	}
 	

--------------060200040907000704090502--

