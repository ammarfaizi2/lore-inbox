Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269635AbUJFXb7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269635AbUJFXb7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 19:31:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269649AbUJFX2P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 19:28:15 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:64965 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S269610AbUJFXZo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 19:25:44 -0400
Date: Wed, 06 Oct 2004 16:26:05 -0700
From: Hanna Linder <hannal@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>
cc: Hanna Linder <hannal@us.ibm.com>,
       kernel-janitors <kernel-janitors@lists.osdl.org>, greg@kroah.com,
       paulus@samba.org, benh@kernel.crashing.org
Subject: Re: [PATCH 2.6] [2/12] chrp_pci.c replace pci_find_device with pci_get_device
Message-ID: <55400000.1097105165@w-hlinder.beaverton.ibm.com>
In-Reply-To: <303220000.1096932072@w-hlinder.beaverton.ibm.com>
References: <303220000.1096932072@w-hlinder.beaverton.ibm.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--On Monday, October 04, 2004 04:21:12 PM -0700 Hanna Linder <hannal@us.ibm.com> wrote:

> 
> As pci_find_device is going away I have replaced this call with pci_get_device.
> If someone with a PPC system could verify it I would appreciate it.
> 
> Hanna Linder
> IBM Linux Technology Center
> 
> Signed-off-by: Hanna Linder <hannal@us.ibm.com>

Reroll this patch with new macro

diff -Nrup linux-2.6.9-rc3-mm2cln/arch/ppc/platforms/chrp_pci.c linux-2.6.9-rc3-mm2patch/arch/ppc/platforms/chrp_pci.c
--- linux-2.6.9-rc3-mm2cln/arch/ppc/platforms/chrp_pci.c	2004-09-29 20:06:04.000000000 -0700
+++ linux-2.6.9-rc3-mm2patch/arch/ppc/platforms/chrp_pci.c	2004-10-06 16:15:44.000000000 -0700
@@ -158,7 +158,7 @@ chrp_pcibios_fixup(void)
 	struct device_node *np;
 
 	/* PCI interrupts are controlled by the OpenPIC */
-	while ((dev = pci_find_device(PCI_ANY_ID, PCI_ANY_ID, dev)) != NULL) {
+	for_each_pci_dev(dev) {
 		np = pci_device_to_OF_node(dev);
 		if ((np != 0) && (np->n_intrs > 0) && (np->intrs[0].line != 0))
 			dev->irq = np->intrs[0].line;

