Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270060AbUJHSQ3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270060AbUJHSQ3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 14:16:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270058AbUJHSPz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 14:15:55 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:30867 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S270060AbUJHRtZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 13:49:25 -0400
Date: Fri, 08 Oct 2004 10:49:58 -0700
From: Hanna Linder <hannal@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>,
       kernel-janitors <kernel-janitors@lists.osdl.org>
cc: Hanna Linder <hannal@us.ibm.com>, greg@kroah.com, paulus@samba.org,
       anton@samba.org
Subject: Re: [PATCH 2.6] pSeries_iommu.c replace pci_find_device with pci_get_device
Message-ID: <72580000.1097257798@w-hlinder.beaverton.ibm.com>
In-Reply-To: <70740000.1097257219@w-hlinder.beaverton.ibm.com>
References: <70740000.1097257219@w-hlinder.beaverton.ibm.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--On Friday, October 08, 2004 10:40:19 AM -0700 Hanna Linder <hannal@us.ibm.com> wrote:

> As pci_find_device is going away I've replaced it with pci_get_device.
> If someone with a PPC64 system could test it I would appreciate it.
> 
> Thanks.
> 
> Hanna Linder
> IBM Linux Technology Center
> 
> Signed-off-by: Hanna Linder <hannal@us.ibm.com>

Ooops. Included the wrong patch. Should be:

diff -Nrup linux-2.6.9-rc3-mm3cln/arch/ppc64/kernel/pSeries_iommu.c linux-2.6.9-rc3-mm3patch2/arch/ppc64/kernel/pSeries_iommu.c
--- linux-2.6.9-rc3-mm3cln/arch/ppc64/kernel/pSeries_iommu.c	2004-09-29 20:04:16.000000000 -0700
+++ linux-2.6.9-rc3-mm3patch2/arch/ppc64/kernel/pSeries_iommu.c	2004-10-08 10:22:35.448365008 -0700
@@ -427,7 +427,7 @@ void iommu_setup_pSeries(void)
 	 * pci device_node.  This means get_iommu_table() won't need to search
 	 * up the device tree to find it.
 	 */
-	while ((dev = pci_find_device(PCI_ANY_ID, PCI_ANY_ID, dev)) != NULL) {
+	for_each_pci_dev(dev) {
 		mydn = dn = PCI_GET_DN(dev);
 
 		while (dn && dn->iommu_table == NULL)

