Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261640AbTIVQIM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 12:08:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261842AbTIVQIM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 12:08:12 -0400
Received: from atlrel7.hp.com ([156.153.255.213]:55774 "EHLO atlrel7.hp.com")
	by vger.kernel.org with ESMTP id S261640AbTIVQIF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 12:08:05 -0400
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>,
       Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] 2.4 fix pci_generic_prep_mwi export breakage
Date: Mon, 22 Sep 2003 10:07:54 -0600
User-Agent: KMail/1.5.3
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>, <jgarzik@redhat.com>,
       <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0309211524290.18223-100000@logos.cnet>
In-Reply-To: <Pine.LNX.4.44.0309211524290.18223-100000@logos.cnet>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309221007.54856.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 21 September 2003 12:28 pm, Marcelo Tosatti wrote:
> On Sat, 20 Sep 2003, Jeff Garzik wrote:
> > Bjorn Helgaas wrote:
> > > I think the recent change to pci.c to export pci_generic_prep_mwi() 
> > > is incorrect.
> > > 
> > > pci_generic_prep_mwi() is only defined if !HAVE_ARCH_PCI_MWI,
> > > so it is wrong to export it.  In particular, it breaks on
> > > ia64, because we define HAVE_ARCH_PCI_MWI.
> > > 
> > > It looks to me like the following patch should be applied.  This
> > > removes the export and in fact makes pci_generic_prep_mwi() static
> > > as it is in 2.5.
> > 
> > Looks OK to me.  Marcelo applied this already, right?
> 
> Well I dont remember applying it but I dont seem to have 
> pci_generic_prep_mwi exported. 

Looks to me like your tree still needs this change.  Here's the
patch again in case you need it:

===== drivers/pci/pci.c 1.45 vs edited =====
--- 1.45/drivers/pci/pci.c	Sun Aug 31 07:52:15 2003
+++ edited/drivers/pci/pci.c	Mon Sep 22 12:27:35 2003
@@ -921,7 +921,7 @@
  *
  * RETURNS: An appriopriate -ERRNO error value on eror, or zero for success.
  */
-int
+static int
 pci_generic_prep_mwi(struct pci_dev *dev)
 {
 	u8 cacheline_size;
@@ -2151,7 +2151,6 @@
 EXPORT_SYMBOL(pci_set_master);
 EXPORT_SYMBOL(pci_set_mwi);
 EXPORT_SYMBOL(pci_clear_mwi);
-EXPORT_SYMBOL(pci_generic_prep_mwi);
 EXPORT_SYMBOL(pci_set_dma_mask);
 EXPORT_SYMBOL(pci_dac_set_dma_mask);
 EXPORT_SYMBOL(pci_assign_resource);
===== include/linux/pci.h 1.34 vs edited =====
--- 1.34/include/linux/pci.h	Sun Aug 31 07:52:15 2003
+++ edited/include/linux/pci.h	Mon Sep 22 12:27:35 2003
@@ -628,7 +628,6 @@
 #define HAVE_PCI_SET_MWI
 int pci_set_mwi(struct pci_dev *dev);
 void pci_clear_mwi(struct pci_dev *dev);
-int pci_generic_prep_mwi(struct pci_dev *dev);
 int pci_set_dma_mask(struct pci_dev *dev, u64 mask);
 int pci_dac_set_dma_mask(struct pci_dev *dev, u64 mask);
 int pci_assign_resource(struct pci_dev *dev, int i);

