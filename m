Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751162AbVHGHCK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751162AbVHGHCK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Aug 2005 03:02:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751173AbVHGHCK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Aug 2005 03:02:10 -0400
Received: from mail26.sea5.speakeasy.net ([69.17.117.28]:10696 "EHLO
	mail26.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S1751162AbVHGHCJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Aug 2005 03:02:09 -0400
Subject: [PATCH] make visual workstation subarch link again
From: Tom Duffy <thomas.duffy.99@alumni.brown.edu>
To: akpm@osdl.org
Cc: pazke@orbita1.ru, linux-visws-devel@lists.sourceforge.net,
       ebiederm@xmission.com, linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Sun, 07 Aug 2005 00:04:07 -0700
Message-Id: <1123398247.6813.13.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch add stubs to allow the visws subarch to link again.  Also
needs Eric W. Biederman's patch adding machine_emergency_restart() and
machine_shutdown() sent earlier today to link properly:

http://marc.theaimsgroup.com/?l=linux-kernel&m=112335772219837&w=2

Signed-off-by: Tom Duffy <thomas.duffy.99@alumni.brown.edu>

diff -Nur -X /home/tduffy/dontdiff linux-2.6.13-rc5/arch/i386/mach-visws/setup.c linux-2.6.13-rc5/arch/i386/mach-visws/setup.c
--- linux-2.6.13-rc5/arch/i386/mach-visws/setup.c	2005-08-06 08:46:46.138055928 -0700
+++ linux-2.6.13-rc5/arch/i386/mach-visws/setup.c	2005-08-06 08:47:26.509918472 -0700
@@ -14,6 +14,8 @@
 #include "cobalt.h"
 #include "piix4.h"
 
+int no_broadcast;
+
 char visws_board_type = -1;
 char visws_board_rev = -1;
 
diff -Nur -X /home/tduffy/dontdiff linux-2.6.13-rc5/arch/i386/pci/visws.c linux-2.6.13-rc5/arch/i386/pci/visws.c
--- linux-2.6.13-rc5/arch/i386/pci/visws.c	2005-08-06 00:56:45.843152392 -0700
+++ linux-2.6.13-rc5/arch/i386/pci/visws.c	2005-08-06 08:58:02.475237048 -0700
@@ -18,8 +18,10 @@
 extern struct pci_raw_ops pci_direct_conf1;
 
 static int pci_visws_enable_irq(struct pci_dev *dev) { return 0; }
+static void pci_visws_disable_irq(struct pci_dev *dev) { }
 
 int (*pcibios_enable_irq)(struct pci_dev *dev) = &pci_visws_enable_irq;
+void (*pcibios_disable_irq)(struct pci_dev *dev) = &pci_visws_disable_irq;
 
 void __init pcibios_penalize_isa_irq(int irq, int active) {}
 


