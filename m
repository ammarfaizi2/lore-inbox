Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030514AbWJJVrO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030514AbWJJVrO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 17:47:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030510AbWJJVqt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 17:46:49 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:23227 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1030507AbWJJVqS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 17:46:18 -0400
To: torvalds@osdl.org
Subject: [PATCH] ia64/hp NULL noise removal
Cc: linux-kernel@vger.kernel.org
Message-Id: <E1GXPQX-0007MH-8y@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Tue, 10 Oct 2006 22:46:17 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/ia64/hp/sim/simeth.c    |    2 +-
 arch/ia64/hp/sim/simscsi.c   |    2 +-
 arch/ia64/hp/sim/simserial.c |   10 +++++-----
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/ia64/hp/sim/simeth.c b/arch/ia64/hp/sim/simeth.c
index be769ef..424e925 100644
--- a/arch/ia64/hp/sim/simeth.c
+++ b/arch/ia64/hp/sim/simeth.c
@@ -87,7 +87,7 @@ static int simeth_debug;		/* set to 1 to
  */
 static struct notifier_block simeth_dev_notifier = {
 	simeth_device_event,
-	0
+	NULL
 };
 
 
diff --git a/arch/ia64/hp/sim/simscsi.c b/arch/ia64/hp/sim/simscsi.c
index 8f0a16a..bb87682 100644
--- a/arch/ia64/hp/sim/simscsi.c
+++ b/arch/ia64/hp/sim/simscsi.c
@@ -103,7 +103,7 @@ simscsi_interrupt (unsigned long val)
 
 	while ((sc = queue[rd].sc) != 0) {
 		atomic_dec(&num_reqs);
-		queue[rd].sc = 0;
+		queue[rd].sc = NULL;
 		if (DBG)
 			printk("simscsi_interrupt: done with %ld\n", sc->serial_number);
 		(*sc->scsi_done)(sc);
diff --git a/arch/ia64/hp/sim/simserial.c b/arch/ia64/hp/sim/simserial.c
index 5095778..caab986 100644
--- a/arch/ia64/hp/sim/simserial.c
+++ b/arch/ia64/hp/sim/simserial.c
@@ -92,7 +92,7 @@ static struct serial_uart_config uart_co
 	{ "ST16650V2", 32, UART_CLEAR_FIFO | UART_USE_FIFO |
 		  UART_STARTECH },
 	{ "TI16750", 64, UART_CLEAR_FIFO | UART_USE_FIFO},
-	{ 0, 0}
+	{ NULL, 0}
 };
 
 struct tty_driver *hp_simserial_driver;
@@ -555,7 +555,7 @@ #endif
 
 		if (info->xmit.buf) {
 			free_page((unsigned long) info->xmit.buf);
-			info->xmit.buf = 0;
+			info->xmit.buf = NULL;
 		}
 
 		if (info->tty) set_bit(TTY_IO_ERROR, &info->tty->flags);
@@ -628,7 +628,7 @@ #endif
 	if (tty->driver->flush_buffer) tty->driver->flush_buffer(tty);
 	if (tty->ldisc.flush_buffer) tty->ldisc.flush_buffer(tty);
 	info->event = 0;
-	info->tty = 0;
+	info->tty = NULL;
 	if (info->blocked_open) {
 		if (info->close_delay)
 			schedule_timeout_interruptible(info->close_delay);
@@ -668,7 +668,7 @@ #endif
 	info->event = 0;
 	state->count = 0;
 	info->flags &= ~ASYNC_NORMAL_ACTIVE;
-	info->tty = 0;
+	info->tty = NULL;
 	wake_up_interruptible(&info->open_wait);
 }
 
@@ -769,7 +769,7 @@ #endif
 	/*
 	 * Insert serial port into IRQ chain.
 	 */
-	info->prev_port = 0;
+	info->prev_port = NULL;
 	info->next_port = IRQ_ports[state->irq];
 	if (info->next_port)
 		info->next_port->prev_port = info;
-- 
1.4.2.GIT


