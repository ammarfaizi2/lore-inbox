Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263205AbTFIL2f (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jun 2003 07:28:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263264AbTFIL2e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jun 2003 07:28:34 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:40201 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id S263205AbTFIL2d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jun 2003 07:28:33 -0400
Date: Mon, 9 Jun 2003 15:41:42 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Matthew Wilcox <willy@debian.org>
Cc: linux-kernel@vger.kernel.org, David Mosberger <davidm@hpl.hp.com>
Subject: Re: [PATCH] [3/3] PCI segment support
Message-ID: <20030609154142.E15283@jurassic.park.msu.ru>
References: <20030407234411.GT23430@parcelfarce.linux.theplanet.co.uk> <20030408203824.A27019@jurassic.park.msu.ru> <20030608164351.GI28581@parcelfarce.linux.theplanet.co.uk> <20030609140749.A15138@jurassic.park.msu.ru> <20030609111739.GP28581@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030609111739.GP28581@parcelfarce.linux.theplanet.co.uk>; from willy@debian.org on Mon, Jun 09, 2003 at 12:17:39PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

BTW, you can include this in the next version of the patch. :-)

Ivan.

--- 2.5/include/asm-alpha/pci.h	Tue May 27 05:00:20 2003
+++ linux/include/asm-alpha/pci.h	Mon Jun  9 15:29:51 2003
@@ -195,6 +195,9 @@ extern void
 pcibios_resource_to_bus(struct pci_dev *dev, struct pci_bus_region *region,
 			 struct resource *res);
 
+#define pci_domain_nr(pbus) ({ struct pci_controller *_hose_ = pbus->sysdata; \
+			       _hose_->index; })
+
 #endif /* __KERNEL__ */
 
 /* Values for the `which' argument to sys_pciconfig_iobase.  */
--- 2.5/arch/alpha/Kconfig	Mon Jun  9 12:39:39 2003
+++ linux/arch/alpha/Kconfig	Mon Jun  9 12:43:55 2003
@@ -295,6 +295,10 @@ config PCI
 	  information about which PCI hardware does work under Linux and which
 	  doesn't.
 
+config PCI_DOMAINS
+	bool
+	default PCI
+
 config ALPHA_CORE_AGP
 	bool
 	depends on ALPHA_GENERIC || ALPHA_TITAN || ALPHA_MARVEL
