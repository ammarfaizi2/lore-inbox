Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314514AbSGYNjA>; Thu, 25 Jul 2002 09:39:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314083AbSGYNhz>; Thu, 25 Jul 2002 09:37:55 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:7165 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S313687AbSGYNhf>; Thu, 25 Jul 2002 09:37:35 -0400
From: Alan Cox <alan@irongate.swansea.linux.org.uk>
Message-Id: <200207251454.g6PEslAc010520@irongate.swansea.linux.org.uk>
Subject: PATCH: 2.5.28 Make the tulip compile again
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Date: Thu, 25 Jul 2002 15:54:47 +0100 (BST)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.28/drivers/net/tulip/de2104x.c linux-2.5.28-ac1/drivers/net/tulip/de2104x.c
--- linux-2.5.28/drivers/net/tulip/de2104x.c	Thu Jul 25 11:09:41 2002
+++ linux-2.5.28-ac1/drivers/net/tulip/de2104x.c	Thu Jul 25 12:15:28 2002
@@ -2178,7 +2178,7 @@
 		/* Update the error counts. */
 		__de_get_stats(de);
 
-		synchronize_irq();
+		synchronize_irq(dev->irq);
 		de_clean_rings(de);
 
 		de_adapter_sleep(de);
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.28/drivers/net/tulip/de4x5.c linux-2.5.28-ac1/drivers/net/tulip/de4x5.c
--- linux-2.5.28/drivers/net/tulip/de4x5.c	Thu Jul 25 10:48:25 2002
+++ linux-2.5.28-ac1/drivers/net/tulip/de4x5.c	Thu Jul 25 12:19:02 2002
@@ -1522,7 +1522,7 @@
     outl(omr|OMR_ST, DE4X5_OMR);
 
     /* Poll for setup frame completion (adapter interrupts are disabled now) */
-    sti();                                       /* Ensure timer interrupts */
+
     for (j=0, i=0;(i<500) && (j==0);i++) {       /* Upto 500ms delay */
 	mdelay(1);
 	if ((s32)le32_to_cpu(lp->tx_ring[lp->tx_new].status) >= 0) j=1;
@@ -1644,7 +1644,7 @@
     if (test_and_set_bit(MASK_INTERRUPTS, (void*) &lp->interrupt))
 	printk("%s: Re-entering the interrupt handler.\n", dev->name);
 
-    synchronize_irq();
+    synchronize_irq(dev->irq);
 	
     for (limit=0; limit<8; limit++) {
 	sts = inl(DE4X5_STS);            /* Read IRQ status */
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.28/drivers/net/tulip/winbond-840.c linux-2.5.28-ac1/drivers/net/tulip/winbond-840.c
--- linux-2.5.28/drivers/net/tulip/winbond-840.c	Thu Jul 25 10:48:25 2002
+++ linux-2.5.28-ac1/drivers/net/tulip/winbond-840.c	Thu Jul 25 12:19:16 2002
@@ -1674,7 +1674,7 @@
 		spin_unlock_irq(&np->lock);
 
 		spin_unlock_wait(&dev->xmit_lock);
-		synchronize_irq();
+		synchronize_irq(dev->irq);
 	
 		np->stats.rx_missed_errors += readl(ioaddr + RxMissed) & 0xffff;
 
