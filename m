Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162241AbWKPCom@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162241AbWKPCom (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 21:44:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162234AbWKPCol
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 21:44:41 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:30607 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1162243AbWKPCoY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 21:44:24 -0500
Message-Id: <20061116024535.519058000@sous-sol.org>
References: <20061116024332.124753000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Wed, 15 Nov 2006 18:43:41 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, Yvan Seth <bugzilla.kernel.org@malignity.net>,
       Corey Minyard <minyard@acm.org>
Subject: [patch 09/30] ipmi_si_intf.c sets bad class_mask with PCI_DEVICE_CLASS
Content-Disposition: inline; filename=ipmi_si_intf.c-sets-bad-class_mask-with-pci_device_class.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

From: Yvan Seth <bugzilla.kernel.org@malignity.net>

Taken from http://bugzilla.kernel.org/show_bug.cgi?id=7439

It looks like device registration in drivers/char/ipmi/ipmi_si_intf.c was
cleaned up and a small error was made when setting the class_mask.  The fix
is simple as the correct mask value is defined in the code but is not used.

Acked-by: Corey Minyard <minyard@acm.org>
Cc: <stable@kernel.org>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Linus Torvalds <torvalds@osdl.org>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---
 drivers/char/ipmi/ipmi_si_intf.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.18.2.orig/drivers/char/ipmi/ipmi_si_intf.c
+++ linux-2.6.18.2/drivers/char/ipmi/ipmi_si_intf.c
@@ -1845,7 +1845,7 @@ static int ipmi_pci_resume(struct pci_de
 
 static struct pci_device_id ipmi_pci_devices[] = {
 	{ PCI_DEVICE(PCI_HP_VENDOR_ID, PCI_MMC_DEVICE_ID) },
-	{ PCI_DEVICE_CLASS(PCI_ERMC_CLASSCODE, PCI_ERMC_CLASSCODE) }
+	{ PCI_DEVICE_CLASS(PCI_ERMC_CLASSCODE, PCI_ERMC_CLASSCODE_MASK) }
 };
 MODULE_DEVICE_TABLE(pci, ipmi_pci_devices);
 

--
