Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269649AbUJFXgF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269649AbUJFXgF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 19:36:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269617AbUJFXcX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 19:32:23 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:58361 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S269610AbUJFX2f
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 19:28:35 -0400
Date: Wed, 06 Oct 2004 16:29:06 -0700
From: Hanna Linder <hannal@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>
cc: Hanna Linder <hannal@us.ibm.com>,
       kernel-janitors <kernel-janitors@lists.osdl.org>, greg@kroah.com,
       paulus@samba.org, benh@kernel.crashing.org
Subject: Re: [PATCH 2.6] [3/12] gemini_pci.c replace pci_find_device with pci_get_device
Message-ID: <56110000.1097105346@w-hlinder.beaverton.ibm.com>
In-Reply-To: <307270000.1096934114@w-hlinder.beaverton.ibm.com>
References: <307270000.1096934114@w-hlinder.beaverton.ibm.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--On Monday, October 04, 2004 04:55:14 PM -0700 Hanna Linder <hannal@us.ibm.com> wrote:

> As pci_find_device is going away I have replaced this call with pci_get_device.
> If someone with a PPC system could verify it I would appreciate it.
> 
> Hanna Linder
> IBM Linux Technology Center
> 
> Signed-off-by: Hanna Linder <hannal@us.ibm.com>

Reroll this patch to use new macro

diff -Nrup linux-2.6.9-rc3-mm2cln/arch/ppc/platforms/gemini_pci.c linux-2.6.9-rc3-mm2patch2/arch/ppc/platforms/gemini_pci.c
--- linux-2.6.9-rc3-mm2cln/arch/ppc/platforms/gemini_pci.c	2004-09-29 20:04:25.000000000 -0700
+++ linux-2.6.9-rc3-mm2patch2/arch/ppc/platforms/gemini_pci.c	2004-10-06 16:22:53.979890256 -0700
@@ -15,7 +15,7 @@ void __init gemini_pcibios_fixup(void)
 	int i;
 	struct pci_dev *dev = NULL;
 	
-	while ((dev = pci_find_device(PCI_ANY_ID, PCI_ANY_ID, dev)) != NULL) {
+	for_each_pci_dev(dev) {
 		for(i = 0; i < 6; i++) {
 			if (dev->resource[i].flags & IORESOURCE_IO) {
 				dev->resource[i].start |= (0xfe << 24);

