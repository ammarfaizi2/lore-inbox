Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262607AbUKEFYG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262607AbUKEFYG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Nov 2004 00:24:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262611AbUKEFYG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Nov 2004 00:24:06 -0500
Received: from ozlabs.org ([203.10.76.45]:48288 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S262607AbUKEFX7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Nov 2004 00:23:59 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16779.3533.966547.590634@cargo.ozlabs.ibm.com>
Date: Fri, 5 Nov 2004 16:21:17 +1100
From: Paul Mackerras <paulus@samba.org>
To: akpm@osdl.org, torvalds@osdl.org
Cc: hannal@us.ibm.com, anton@samba.org, linux-kernel@vger.kernel.org
Subject: [PATCH] PPC64 pSeries_pci.c use for_each_pci_dev()
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is from Hanna Linder.

As pci_find_device is going away using the new for_each_pci_dev macro.

Signed-off-by: Hanna Linder <hannal@us.ibm.com>
Signed-off-by: Maximilian Attems <janitor@sternwelten.at>
Signed-off-by: Paul Mackerras <paulus@samba.org>

diff -urN linux-2.5/arch/ppc64/kernel/pSeries_pci.c test/arch/ppc64/kernel/pSeries_pci.c
--- linux-2.5/arch/ppc64/kernel/pSeries_pci.c	2004-10-27 07:32:57.000000000 +1000
+++ test/arch/ppc64/kernel/pSeries_pci.c	2004-11-05 13:16:26.000000000 +1100
@@ -548,7 +548,7 @@
 
 	check_s7a();
 
-	while ((dev = pci_find_device(PCI_ANY_ID, PCI_ANY_ID, dev)) != NULL) {
+	for_each_pci_dev(dev) {
 		pci_read_irq_line(dev);
 		if (s7a_workaround) {
 			if (dev->irq > 16) {
