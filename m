Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262381AbUEKG0W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262381AbUEKG0W (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 02:26:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262388AbUEKG0I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 02:26:08 -0400
Received: from smtp812.mail.sc5.yahoo.com ([66.163.170.82]:37240 "HELO
	smtp812.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262381AbUEKGZK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 02:25:10 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: [PATCH 1/9] New set of input patches - 02-kbd98io-interrupt.patch
Date: Tue, 11 May 2004 01:24:30 -0500
User-Agent: KMail/1.6.2
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <200405110101.42805.dtor_core@ameritech.net>
In-Reply-To: <200405110101.42805.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200405110124.30194.dtor_core@ameritech.net>
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


===================================================================


ChangeSet@1.1587.20.3, 2004-05-10 01:25:24-05:00, dtor_core@ameritech.net
  Input: kbd98io_interrupt should return irqreturn_t


 98kbd-io.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)


===================================================================



diff -Nru a/drivers/input/serio/98kbd-io.c b/drivers/input/serio/98kbd-io.c
--- a/drivers/input/serio/98kbd-io.c	Tue May 11 00:54:37 2004
+++ b/drivers/input/serio/98kbd-io.c	Tue May 11 00:54:37 2004
@@ -51,7 +51,7 @@
 static struct serio kbd98_port;
 extern struct pt_regs *kbd_pt_regs;
 
-static void kbd98io_interrupt(int irq, void *dev_id, struct pt_regs *regs);
+static irqreturn_t kbd98io_interrupt(int irq, void *dev_id, struct pt_regs *regs);
 
 /*
  * kbd98_flush() flushes all data that may be in the keyboard buffers
@@ -143,7 +143,7 @@
  * to the upper layers.
  */
 
-static void kbd98io_interrupt(int irq, void *dev_id, struct pt_regs *regs)
+static irqreturn_t kbd98io_interrupt(int irq, void *dev_id, struct pt_regs *regs)
 {
 	unsigned long flags;
 	unsigned char data;
@@ -154,6 +154,7 @@
 	spin_unlock_irqrestore(&kbd98io_lock, flags);
 	serio_interrupt(&kbd98_port, data, 0, regs);
 
+	return IRQ_HANDLED;
 }
 
 int __init kbd98io_init(void)
