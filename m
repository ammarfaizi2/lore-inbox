Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261889AbUAYAzb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jan 2004 19:55:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262827AbUAYAzb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jan 2004 19:55:31 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:23526 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S261889AbUAYAz1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jan 2004 19:55:27 -0500
Date: Sun, 25 Jan 2004 01:55:23 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>, pc300@cyclades.com
Cc: linux-kernel@vger.kernel.org, jgarzik@pobox.com, linux-net@vger.kernel.org
Subject: [2.4 patch] pc300_drv.c: mark a function pointer as __devexit_p
Message-ID: <20040125005523.GF6441@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I got the following link error in 2.4.25-pre7 when trying to compile 
drivers/net/wan/pc300_drv.c statically into a kernel with 
CONFIG_HOTPLUG=n :

<--  snip  -->

...
        -o vmlinux
local symbol 0: discarded in section `.text.exit' from drivers/net/wan/wan.o
make: *** [vmlinux] Error 1

<--  snip  -->


The patch below fixes this issue by marking the function pointer with 
__devexit_p .

I also did the following changes to this struct:
- added indentation
- switched to C99 initializers
- removed two unneeded NULL's


Please apply
Adrian


--- linux-2.4.25-pre7-full-nohotplug/drivers/net/wan/pc300_drv.c.old	2004-01-25 01:41:56.000000000 +0100
+++ linux-2.4.25-pre7-full-nohotplug/drivers/net/wan/pc300_drv.c	2004-01-25 01:42:52.000000000 +0100
@@ -3459,12 +3459,10 @@
 }
 
 static struct pci_driver cpc_driver = {
-	name:"pc300",
-	id_table:cpc_pci_dev_id,
-	probe:cpc_init_one,
-	remove:cpc_remove_one,
-	suspend:NULL,
-	resume:NULL,
+	.name		= "pc300",
+	.id_table	= cpc_pci_dev_id,
+	.probe		= cpc_init_one,
+	.remove		= __devexit_p(cpc_remove_one),
 };
 
 static int __init cpc_init(void)
