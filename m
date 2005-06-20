Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261259AbVFTNSG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261259AbVFTNSG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 09:18:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261247AbVFTNR3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 09:17:29 -0400
Received: from 41.150.104.212.access.eclipse.net.uk ([212.104.150.41]:61116
	"EHLO pinky.shadowen.org") by vger.kernel.org with ESMTP
	id S261217AbVFTNPE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 09:15:04 -0400
Date: Mon, 20 Jun 2005 14:14:51 +0100
To: gregkh@suse.de
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-mm1
Message-ID: <20050620131451.GA9739@shadowen.org>
References: <20050619233029.45dd66b8.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050619233029.45dd66b8.akpm@osdl.org>
User-Agent: Mutt/1.5.9i
From: Andy Whitcroft <apw@shadowen.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Having trouble getting 2.6.12-mm1 to compile on my x86 test
boxes other than a basic PC.  I suspect this patch is to 'blame'.

> +gregkh-pci-pci-assign-unassigned-resources.patch

We seem to need to include setup-bus.o for most x86 architectures
regardless of HOTPLUG.  Not sure if this is the right fix, but it
seems to work on the systems I have tested.

-apw

=== 8< ===
It seems that X86 architectures in general need the setup-bus.o
not just those with HOTPLUG.  This avoids the following error on
X86_NUMAQ and x86_64:

    arch/i386/pci/built-in.o(.init.text+0x15a6): In function `pcibios_init':
    : undefined reference to `pci_assign_unassigned_resources'

Signed-off-by: Andy Whitcroft <apw@shadowen.org>
---
 Makefile |    1 +
 1 files changed, 1 insertion(+)
diff -upN reference/drivers/pci/Makefile current/drivers/pci/Makefile
--- reference/drivers/pci/Makefile
+++ current/drivers/pci/Makefile
@@ -19,6 +19,7 @@ obj-$(CONFIG_HOTPLUG_PCI) += hotplug/
 #
 # Some architectures use the generic PCI setup functions
 #
+obj-$(CONFIG_X86) += setup-bus.o
 obj-$(CONFIG_ALPHA) += setup-bus.o setup-irq.o
 obj-$(CONFIG_ARM) += setup-bus.o setup-irq.o
 obj-$(CONFIG_PARISC) += setup-bus.o
