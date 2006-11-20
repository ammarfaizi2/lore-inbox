Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933867AbWKTCyv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933867AbWKTCyv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Nov 2006 21:54:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756819AbWKTCyv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Nov 2006 21:54:51 -0500
Received: from agminet01.oracle.com ([141.146.126.228]:9820 "EHLO
	agminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1756594AbWKTCyu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Nov 2006 21:54:50 -0500
Date: Sun, 19 Nov 2006 18:51:24 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: akpm <akpm@osdl.org>
Subject: [PATCH] parport: section mismatches with HOTPLUG=n
Message-Id: <20061119185124.dc429c6b.randy.dunlap@oracle.com>
Organization: Oracle Linux Eng.
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <randy.dunlap@oracle.com>

When CONFIG_HOTPLUG=n, parport_pc calls some __devinit == __init code
that could be discarded.  These calls are made from parport_irq_probe(),
which is called from parport_pc_probe_port(), which is an exported
symbol, so the calls could (possibly) happen after init time.

WARNING: drivers/parport/parport_pc.o - Section mismatch: reference to .init.text: from .text between 'parport_irq_probe' (at offset 0x31d) and 'parport_pc_probe_port'
WARNING: drivers/parport/parport_pc.o - Section mismatch: reference to .init.text: from .text between 'parport_irq_probe' (at offset 0x346) and 'parport_pc_probe_port'

Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
---
 drivers/parport/parport_pc.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- linux-2619-rc6g2.orig/drivers/parport/parport_pc.c
+++ linux-2619-rc6g2/drivers/parport/parport_pc.c
@@ -1975,7 +1975,7 @@ static int __devinit parport_ECPPS2_supp
 /* --- IRQ detection -------------------------------------- */
 
 /* Only if supports ECP mode */
-static int __devinit programmable_irq_support(struct parport *pb)
+static int programmable_irq_support(struct parport *pb)
 {
 	int irq, intrLine;
 	unsigned char oecr = inb (ECONTROL (pb));
@@ -1992,7 +1992,7 @@ static int __devinit programmable_irq_su
 	return irq;
 }
 
-static int __devinit irq_probe_ECP(struct parport *pb)
+static int irq_probe_ECP(struct parport *pb)
 {
 	int i;
 	unsigned long irqs;
@@ -2020,7 +2020,7 @@ static int __devinit irq_probe_ECP(struc
  * This detection seems that only works in National Semiconductors
  * This doesn't work in SMC, LGS, and Winbond 
  */
-static int __devinit irq_probe_EPP(struct parport *pb)
+static int irq_probe_EPP(struct parport *pb)
 {
 #ifndef ADVANCED_DETECT
 	return PARPORT_IRQ_NONE;
@@ -2059,7 +2059,7 @@ static int __devinit irq_probe_EPP(struc
 #endif /* Advanced detection */
 }
 
-static int __devinit irq_probe_SPP(struct parport *pb)
+static int irq_probe_SPP(struct parport *pb)
 {
 	/* Don't even try to do this. */
 	return PARPORT_IRQ_NONE;


---
