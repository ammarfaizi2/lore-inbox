Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261423AbSJHTK5>; Tue, 8 Oct 2002 15:10:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261422AbSJHTKa>; Tue, 8 Oct 2002 15:10:30 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:21264 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S263238AbSJHTEd>; Tue, 8 Oct 2002 15:04:33 -0400
Subject: PATCH: Suppose we unload with the timer function live ?
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Date: Tue, 8 Oct 2002 20:01:42 +0100 (BST)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17yzby-0004tZ-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.2.5.41/drivers/pcmcia/i82365.c linux.2.5.41-ac1/drivers/pcmcia/i82365.c
--- linux.2.5.41/drivers/pcmcia/i82365.c	2002-10-07 22:12:24.000000000 +0100
+++ linux.2.5.41-ac1/drivers/pcmcia/i82365.c	2002-10-07 22:52:57.000000000 +0100
@@ -1631,7 +1631,7 @@
 #endif
     unregister_ss_entry(&pcic_operations);
     if (poll_interval != 0)
-	del_timer(&poll_timer);
+	del_timer_sync(&poll_timer);
 #ifdef CONFIG_ISA
     if (grab_irq != 0)
 	free_irq(cs_irq, pcic_interrupt);
