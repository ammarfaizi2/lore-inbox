Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261422AbSJHTK5>; Tue, 8 Oct 2002 15:10:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261420AbSJHTK2>; Tue, 8 Oct 2002 15:10:28 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:21776 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S263239AbSJHTE6>; Tue, 8 Oct 2002 15:04:58 -0400
Subject: PATCH: make tcic work again
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Date: Tue, 8 Oct 2002 20:02:08 +0100 (BST)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17yzcO-0004tg-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.2.5.41/drivers/pcmcia/tcic.c linux.2.5.41-ac1/drivers/pcmcia/tcic.c
--- linux.2.5.41/drivers/pcmcia/tcic.c	2002-10-07 22:12:24.000000000 +0100
+++ linux.2.5.41-ac1/drivers/pcmcia/tcic.c	2002-10-07 22:53:04.000000000 +0100
@@ -516,17 +516,12 @@
 
 static void __exit exit_tcic(void)
 {
-    u_long flags;
     unregister_ss_entry(&tcic_operations);
-    save_flags(flags);
-    cli();
+    del_timer_sync(&poll_timer);
     if (cs_irq != 0) {
 	tcic_aux_setw(TCIC_AUX_SYSCFG, TCIC_SYSCFG_AUTOBUSY|0x0a00);
 	free_irq(cs_irq, tcic_interrupt);
     }
-    if (tcic_timer_pending)
-	del_timer(&poll_timer);
-    restore_flags(flags);
     release_region(tcic_base, 16);
 } /* exit_tcic */
 
