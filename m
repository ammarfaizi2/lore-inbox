Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270072AbUJHRqf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270072AbUJHRqf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 13:46:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270075AbUJHRpS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 13:45:18 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:58824 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S270050AbUJHRj3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 13:39:29 -0400
Date: Fri, 08 Oct 2004 10:39:59 -0700
From: Hanna Linder <hannal@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>,
       kernel-janitors <kernel-janitors@lists.osdl.org>
cc: paulus@samba.org, anton@samba.org, greg@kroah.com, hannal@us.ibm.com
Subject: [PATCH 2.6] pSeries_pci.c replace pci_find_device with pci_get_device
Message-ID: <70640000.1097257199@w-hlinder.beaverton.ibm.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As pci_find_device is going away I've replaced it with pci_get_device.
If someone with a PPC64 system could test it I would appreciate it.

Thanks.

Hanna Linder
IBM Linux Technology Center

Signed-off-by: Hanna Linder <hannal@us.ibm.com>

---
diff -Nrup linux-2.6.9-rc3-mm3cln/arch/ppc64/kernel/pSeries_pci.c linux-2.6.9-rc3-mm3patch3/arch/ppc64/kernel/pSeries_pci.c
--- linux-2.6.9-rc3-mm3cln/arch/ppc64/kernel/pSeries_pci.c	2004-10-07 15:54:30.000000000 -0700
+++ linux-2.6.9-rc3-mm3patch3/arch/ppc64/kernel/pSeries_pci.c	2004-10-08 10:24:00.064501400 -0700
@@ -646,7 +646,7 @@ void __init pSeries_final_fixup(void)
 
 	check_s7a();
 
-	while ((dev = pci_find_device(PCI_ANY_ID, PCI_ANY_ID, dev)) != NULL) {
+	for_each_pci_dev(dev) {
 		pci_read_irq_line(dev);
 		if (s7a_workaround) {
 			if (dev->irq > 16) {

