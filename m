Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264940AbTFTVyK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jun 2003 17:54:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264942AbTFTVyK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jun 2003 17:54:10 -0400
Received: from air-2.osdl.org ([65.172.181.6]:41875 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264940AbTFTVx7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jun 2003 17:53:59 -0400
Date: Fri, 20 Jun 2003 15:07:56 -0700
From: Bob Miller <rem@osdl.org>
To: trivial@rustcorp.com.au
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH TRIVIAL 2.5.72] Remove 3 compiler warnings from rio_linux.c
Message-ID: <20030620220756.GC2063@doc.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add a return value to a return statement in the ISR and remove/rename
several labels.

--
Bob Miller                                      Email: rem@osdl.org
Open Source Development Lab                     Phone: 503.626.2455 Ext. 17

diff -Nru a/drivers/char/rio/rio_linux.c b/drivers/char/rio/rio_linux.c
--- a/drivers/char/rio/rio_linux.c	Fri Jun 20 13:57:08 2003
+++ b/drivers/char/rio/rio_linux.c	Fri Jun 20 13:57:08 2003
@@ -465,7 +465,7 @@
     rio_reset_interrupt (HostP);
   }
 
-  if ((HostP->Flags & RUN_STATE) != RC_RUNNING) return;
+  if ((HostP->Flags & RUN_STATE) != RC_RUNNING) return IRQ_NONE;
 
   if (test_and_set_bit (RIO_BOARD_INTR_LOCK, &HostP->locks)) {
     printk (KERN_ERR "Recursive interrupt! (host %d/irq%d)\n", 
@@ -980,7 +980,7 @@
   for (i = 0; i < RIO_PORTS; i++) {
     port = p->RIOPortp[i] = ckmalloc (sizeof (struct Port));
     if (!port) {
-      goto free6;
+      goto free3;
     }
     rio_dprintk (RIO_DEBUG_INIT, "initing port %d (%d)\n", i, port->Mapped);
     port->PortNum = i;
@@ -1009,11 +1009,9 @@
   func_exit();
   return 0;
 
- free6:for (i--;i>=0;i--)
+ free3:for (i--;i>=0;i--)
         kfree (p->RIOPortp[i]);
-/*free5: */
- free4:
- free3:kfree (p->RIOPortp);
+  kfree (p->RIOPortp);
  free2:kfree (p->RIOHosts);
  free1:
   rio_dprintk (RIO_DEBUG_INIT, "Not enough memory! %p %p %p\n", 

