Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750770AbWJHEGo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750770AbWJHEGo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Oct 2006 00:06:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750776AbWJHEGo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Oct 2006 00:06:44 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:16138 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750770AbWJHEGo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Oct 2006 00:06:44 -0400
Date: Sun, 8 Oct 2006 06:06:38 +0200
From: Adrian Bunk <bunk@stusta.de>
To: ebiederm@xmission.com
Cc: linux-kernel@vger.kernel.org, Jesper Juhl <jesper.juhl@gmail.com>,
       gregkh@suse.de, linux-pci@atrey.karlin.mff.cuni.cz
Subject: [2.6 patch] HT_IRQ must depend on PCI
Message-ID: <20061008040638.GF29474@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

CONFIG_PCI=n, CONFIG_HT_IRQ=y results in the following compile error:

<--  snip  -->

...
  LD      vmlinux
arch/i386/mach-generic/built-in.o: In function `apicid_to_node':
summit.c:(.text+0x53): undefined reference to `apicid_2_node'
arch/i386/kernel/built-in.o: In function `arch_setup_ht_irq':
(.text+0xcf79): undefined reference to `write_ht_irq_low'
arch/i386/kernel/built-in.o: In function `arch_setup_ht_irq':
(.text+0xcf85): undefined reference to `write_ht_irq_high'
arch/i386/kernel/built-in.o: In function `k7nops':
alternative.c:(.data+0x1358): undefined reference to `mask_ht_irq'
alternative.c:(.data+0x1360): undefined reference to `unmask_ht_irq'
make[1]: *** [vmlinux] Error 1

<--  snip  -->

Bug report by Jesper Juhl.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6/drivers/pci/Kconfig.old	2006-10-08 05:55:51.000000000 +0200
+++ linux-2.6/drivers/pci/Kconfig	2006-10-08 05:56:14.000000000 +0200
@@ -55,7 +55,7 @@
 config HT_IRQ
 	bool "Interrupts on hypertransport devices"
 	default y
-	depends on X86_LOCAL_APIC && X86_IO_APIC
+	depends on PCI && X86_LOCAL_APIC && X86_IO_APIC
 	help
 	   This allows native hypertransport devices to use interrupts.
 

