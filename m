Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264600AbUFGMXL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264600AbUFGMXL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jun 2004 08:23:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264610AbUFGMW3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jun 2004 08:22:29 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:8065 "EHLO midnight.ucw.cz")
	by vger.kernel.org with ESMTP id S264600AbUFGL4U convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jun 2004 07:56:20 -0400
To: torvalds@osdl.org, akpm@osdl.org, vojtech@ucw.cz,
       linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
Message-Id: <10866093543447@twilight.ucw.cz>
From: Vojtech Pavlik <vojtech@suse.cz>
Content-Type: text/plain; charset=US-ASCII
In-Reply-To: <108660935415@twilight.ucw.cz>
Mime-Version: 1.0
Date: Mon, 7 Jun 2004 13:55:54 +0200
Subject: [PATCH 23/39] input: kbd98io_interrupt should return irqreturn_t
X-Mailer: gregkh_patchbomb_levon_offspring
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You can pull this changeset from:
	bk://kernel.bkbits.net/vojtech/input-for-linus

===================================================================

ChangeSet@1.1587.27.3, 2004-05-10 01:25:24-05:00, dtor_core@ameritech.net
  Input: kbd98io_interrupt should return irqreturn_t


 98kbd-io.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

===================================================================

diff -Nru a/drivers/input/serio/98kbd-io.c b/drivers/input/serio/98kbd-io.c
--- a/drivers/input/serio/98kbd-io.c	2004-06-07 13:11:46 +02:00
+++ b/drivers/input/serio/98kbd-io.c	2004-06-07 13:11:46 +02:00
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

