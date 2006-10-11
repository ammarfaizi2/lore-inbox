Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161477AbWJKVOe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161477AbWJKVOe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 17:14:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161467AbWJKVOd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 17:14:33 -0400
Received: from av1.karneval.cz ([81.27.192.123]:29461 "EHLO av1.karneval.cz")
	by vger.kernel.org with ESMTP id S1161491AbWJKVOb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 17:14:31 -0400
Message-id: <32432w23aaa423@karneval.cz>
Subject: [PATCH 4/4] Char: mxser_new, clean macros
From: Jiri Slaby <jirislaby@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>, <support@moxa.com.tw>
Date: Wed, 11 Oct 2006 23:14:17 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mxser_new, clean macros

Celan redundant macros.

Signed-off-by: Jiri Slaby <jirislaby@gmail.com>

---
commit b2090dd621f58423950e8e79b0959889d26a8227
tree 5ebc4d2634f17976de978d236ae5f59d28c7ef06
parent f745e78bdca36ec5e27de25694a4417a45ffb5de
author Jiri Slaby <jirislaby@gmail.com> Wed, 11 Oct 2006 22:59:14 +0200
committer Jiri Slaby <jirislaby@gmail.com> Wed, 11 Oct 2006 22:59:14 +0200

 drivers/char/mxser_new.c |   12 ++----------
 1 files changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/char/mxser_new.c b/drivers/char/mxser_new.c
index 8c62f80..d212ae6 100644
--- a/drivers/char/mxser_new.c
+++ b/drivers/char/mxser_new.c
@@ -54,11 +54,10 @@ #define	MXSERMAJOR	 174
 #define	MXSERCUMAJOR	 175
 
 #define	MXSER_EVENT_TXLOW	1
-#define	MXSER_EVENT_HANGUP	2
 
 #define MXSER_BOARDS		4	/* Max. boards */
-#define MXSER_PORTS		32	/* Max. ports */
 #define MXSER_PORTS_PER_BOARD	8	/* Max. ports per board */
+#define MXSER_PORTS		(MXSER_BOARDS * MXSER_PORTS_PER_BOARD)
 #define MXSER_ISR_PASS_LIMIT	99999L
 
 #define	MXSER_ERR_IOADDR	-1
@@ -66,9 +65,6 @@ #define	MXSER_ERR_IRQ		-2
 #define	MXSER_ERR_IRQ_CONFLIT	-3
 #define	MXSER_ERR_VECTOR	-4
 
-#define SERIAL_TYPE_NORMAL	1
-#define SERIAL_TYPE_CALLOUT	2
-
 #define WAKEUP_CHARS		256
 
 #define UART_MCR_AFE		0x20
@@ -365,14 +361,10 @@ static void process_txrx_fifo(struct mxs
 static void mxser_do_softint(void *private_)
 {
 	struct mxser_port *info = private_;
-	struct tty_struct *tty;
-
-	tty = info->tty;
+	struct tty_struct *tty = info->tty;
 
 	if (test_and_clear_bit(MXSER_EVENT_TXLOW, &info->event))
 		tty_wakeup(tty);
-	if (test_and_clear_bit(MXSER_EVENT_HANGUP, &info->event))
-		tty_hangup(tty);
 }
 
 static unsigned char mxser_get_msr(int baseaddr, int mode, int port)
