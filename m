Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265015AbUETHHx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265015AbUETHHx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 May 2004 03:07:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265021AbUETHHx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 May 2004 03:07:53 -0400
Received: from ozlabs.org ([203.10.76.45]:42380 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S265015AbUETHHt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 May 2004 03:07:49 -0400
Subject: [TRIVIAL] fix compile of PCI-debugging for i386 and x86_64
From: Rusty Russell <rusty@rustcorp.com.au>
To: Andrew Morton <akpm@osdl.org>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1085033533.24935.78.camel@bach>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 20 May 2004 17:07:15 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Either pull in pirq_table or remove the debug cruft^Wstuff
  from sis_router_probe altogether... 
  Attached does the former. Trivial latter upon request.


--- trivial-2.6.6-bk6/arch/i386/pci/irq.c.orig	2004-05-20 15:59:00.000000000 +1000
+++ trivial-2.6.6-bk6/arch/i386/pci/irq.c	2004-05-20 15:59:00.000000000 +1000
@@ -535,6 +535,9 @@
 
 static __init int sis_router_probe(struct irq_router *r, struct pci_dev *router, u16 device)
 {
+#ifdef DEBUG
+	struct irq_routing_table *rt = pirq_table;
+#endif
 	if (device != PCI_DEVICE_ID_SI_503)
 		return 0;
 		
-- 
  What is this? http://www.kernel.org/pub/linux/kernel/people/rusty/trivial/
  Don't blame me: the Monkey is driving
  File: Bernhard Fischer <berny.f@aon.at>: [patchlet] fix compile of PCI-debugging for i386 and x86_64

