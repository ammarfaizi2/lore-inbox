Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131079AbRACU4S>; Wed, 3 Jan 2001 15:56:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131113AbRACU4K>; Wed, 3 Jan 2001 15:56:10 -0500
Received: from jalon.able.es ([212.97.163.2]:22748 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S131079AbRACUzv>;
	Wed, 3 Jan 2001 15:55:51 -0500
Date: Wed, 3 Jan 2001 21:55:41 +0100
From: "J . A . Magallon" <jamagallon@able.es>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.2.19pre6
Message-ID: <20010103215541.A743@werewolf.able.es>
In-Reply-To: <E14DsXi-0004Mt-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <E14DsXi-0004Mt-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Wed, Jan 03, 2001 at 19:21:43 +0100
X-Mailer: Balsa 1.0.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2001.01.03 Alan Cox wrote:
> 
> 2.2.19pre6
> o	Yamaha PCI sound updates			(Pete Zaitcev)
> o	Alpha SMP ASN reuse races			(Andrea Arcangeli)
> o	Alpha bottom half SMP race fixes		(Andrea Arcangeli)
> o	Alpha SMP read_unloc race fix			(Andrea
> Arcangeli)
> o	Show registers across CPUs on SMP alpha death	(Andrea
> Arcangeli)
> o	Print the 8K of stack not the top 4K on x86	(Andrea Arcangeli)
> o	Dcache aging					(Andrea Arcangeli)
> o	Kill unused parameter in free_inode_memory	(Andrea Arcangeli)
> 

Please apply this patchlet, corrects some ugly KERN_INFOs in ne2k-pci.

--- linux-2.2.19-pre6/drivers/net/ne2k-pci.c.org	Wed Jan  3 21:06:16 2001
+++ linux-2.2.19-pre6/drivers/net/ne2k-pci.c	Wed Jan  3 21:15:57 2001
@@ -33,10 +33,9 @@
 */
 
 /* These identify the driver base version and may not be removed. */
-static const char version1[] =
-"ne2k-pci.c:v1.02 10/19/2000 D. Becker/P. Gortmaker\n";
-static const char version2[] =
-"  http://www.scyld.com/network/ne2k-pci.html\n";
+static const char* version =
+"ne2k-pci.c: v1.02 for Linux 2.2, 10/19/2000, D. Becker/P. Gortmaker,"
+" http://www.scyld.com/network/ne2k-pci.html";
 
 #include <linux/module.h>
 #include <linux/kernel.h>
@@ -159,8 +158,7 @@
 init_module(void)
 {
 	/* We must emit version information. */
-	if (debug)
-		printk(KERN_INFO "%s" KERN_INFO "%s", version1, version2);
+	printk(KERN_INFO "%s\n", version);
 
 	if (ne2k_pci_probe(0)) {
 		printk(KERN_NOTICE "ne2k-pci.c: No useable cards found, driver
NOT installed.\n");
@@ -243,7 +241,7 @@
 		{
 			static unsigned version_printed = 0;
 			if (version_printed++ == 0)
-				printk(KERN_INFO "%s %s", version1, version2);
+				printk(KERN_INFO "%s\n", version);
 		}
 #endif
 

-- 
J.A. Magallon                                         $> cd pub
mailto:jamagallon@able.es                             $> more beer

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
