Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262698AbTHaWGH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Aug 2003 18:06:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262719AbTHaWGH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Aug 2003 18:06:07 -0400
Received: from aneto.able.es ([212.97.163.22]:53142 "EHLO aneto.able.es")
	by vger.kernel.org with ESMTP id S262698AbTHaWGE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Aug 2003 18:06:04 -0400
Date: Mon, 1 Sep 2003 00:06:02 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: marcelo@conectiva.com.br, linux-kernel@vger.kernel.org
Subject: Re: [bk patches] 2.4.x quick fixes
Message-ID: <20030831220602.GA2465@werewolf.able.es>
References: <20030831140543.GA4819@gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20030831140543.GA4819@gtf.org>; from jgarzik@pobox.com on Sun, Aug 31, 2003 at 16:05:43 +0200
X-Mailer: Balsa 2.0.14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 08.31, Jeff Garzik wrote:
> 
> Marcelo, please do a
> 
> 	bk pull bk://kernel.bkbits.net/jgarzik/misc-2.4
> 
> This will update the following files:
> 
>  arch/i386/kernel/pci-irq.c |    1 +
>  drivers/pci/pci.c          |    2 +-
>  include/linux/pci.h        |    2 +-
>  3 files changed, 3 insertions(+), 2 deletions(-)
> 

Against pre2, this is missing to build the thing:

--- linux-2.4.23-pre2-jam1m/drivers/pci/pci.c.orig	2003-08-31 23:59:15.000000000 +0200
+++ linux-2.4.23-pre2-jam1m/drivers/pci/pci.c	2003-09-01 00:00:22.000000000 +0200
@@ -908,7 +908,7 @@
 }
 
 /**
- * pdev_set_mwi - arch helper function for pcibios_set_mwi
+ * pci_generic_prep_mwi - arch helper function for pcibios_set_mwi
  * @dev: the PCI device for which MWI is enabled
  *
  * Helper function for implementation the arch-specific pcibios_set_mwi
@@ -918,7 +918,7 @@
  * RETURNS: An appriopriate -ERRNO error value on eror, or zero for success.
  */
 int
-pdev_set_mwi(struct pci_dev *dev)
+pci_generic_prep_mwi(struct pci_dev *dev)
 {
 	int rc = 0;
 	u8 cache_size;
@@ -966,7 +966,7 @@
 #ifdef HAVE_ARCH_PCI_MWI
 	rc = pcibios_set_mwi(dev);
 #else
-	rc = pdev_set_mwi(dev);
+	rc = pci_generic_prep_mwi(dev);
 #endif
 
 	if (rc)

-- 
J.A. Magallon <jamagallon@able.es>      \                 Software is like sex:
werewolf.able.es                         \           It's better when it's free
Mandrake Linux release 9.2 (Cooker) for i586
Linux 2.4.23-pre2-jam1m (gcc 3.3.1 (Mandrake Linux 9.2 3.3.1-1mdk))
