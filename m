Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750775AbVLCBjn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750775AbVLCBjn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Dec 2005 20:39:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751137AbVLCBjn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Dec 2005 20:39:43 -0500
Received: from havoc.gtf.org ([69.61.125.42]:44704 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S1750775AbVLCBjm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Dec 2005 20:39:42 -0500
Date: Fri, 2 Dec 2005 20:39:41 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: linux-kernel@vger.kernel.org
Cc: gregkh@suse.de, ak@suse.de
Subject: [PATCH 1/3] x86 PCI domain support: a humble fix
Message-ID: <20051203013941.GA2663@havoc.gtf.org>
References: <20051203013904.GA2560@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051203013904.GA2560@havoc.gtf.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



commit 6bc310571a421a755822f1e65815399caddcb400
Author: Jeff Garzik <jgarzik@pobox.com>
Date:   Fri Dec 2 19:20:52 2005 -0500

    [x86, PCI] pass PCI domain number to PCI config read/write hooks
    
    Don't hardcode zero, since modern x86 (with special ACPI sauce)
    can support multiple "PCI segments", aka PCI domains.

 arch/i386/pci/common.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)


6bc310571a421a755822f1e65815399caddcb400
diff --git a/arch/i386/pci/common.c b/arch/i386/pci/common.c
index f6bc48d..6a18a8a 100644
--- a/arch/i386/pci/common.c
+++ b/arch/i386/pci/common.c
@@ -31,12 +31,14 @@ struct pci_raw_ops *raw_pci_ops;
 
 static int pci_read(struct pci_bus *bus, unsigned int devfn, int where, int size, u32 *value)
 {
-	return raw_pci_ops->read(0, bus->number, devfn, where, size, value);
+	return raw_pci_ops->read(pci_domain_nr(bus), bus->number,
+				 devfn, where, size, value);
 }
 
 static int pci_write(struct pci_bus *bus, unsigned int devfn, int where, int size, u32 value)
 {
-	return raw_pci_ops->write(0, bus->number, devfn, where, size, value);
+	return raw_pci_ops->write(pci_domain_nr(bus), bus->number,
+				  devfn, where, size, value);
 }
 
 struct pci_ops pci_root_ops = {
