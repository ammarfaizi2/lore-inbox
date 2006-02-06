Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932248AbWBFR33@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932248AbWBFR33 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 12:29:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932249AbWBFR33
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 12:29:29 -0500
Received: from gate.crashing.org ([63.228.1.57]:1420 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S932248AbWBFR33 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 12:29:29 -0500
Date: Mon, 6 Feb 2006 11:20:15 -0600 (CST)
From: Kumar Gala <galak@kernel.crashing.org>
X-X-Sender: galak@gate.crashing.org
To: linux-kernel@vger.kernel.org
cc: Russell King <rmk+lkml@arm.linux.org.uk>, <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] Revert serial 8250 console fixes
Message-ID: <Pine.LNX.4.44.0602061116190.11785-100000@gate.crashing.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Revert Alan's SMP related console race fix as it breaks on some embedded
PowerPC's.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>

---
commit 50c58924f3ddde690f22ef7bad122c8c279a0273
tree 13b6a0761697718fb446ddc6d12fa47de24e5ab1
parent 17ec766166ea8211717f0a97bc3db532a54a499b
author Kumar Gala <galak@kernel.crashing.org> Mon, 06 Feb 2006 11:27:48 -0600
committer Kumar Gala <galak@kernel.crashing.org> Mon, 06 Feb 2006 11:27:48 -0600

 drivers/serial/8250.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/serial/8250.c b/drivers/serial/8250.c
index 179c1f0..141220f 100644
--- a/drivers/serial/8250.c
+++ b/drivers/serial/8250.c
@@ -2211,7 +2211,7 @@ serial8250_console_write(struct console 
 	 *	Now, do each character
 	 */
 	for (i = 0; i < count; i++, s++) {
-		wait_for_xmitr(up, UART_LSR_THRE);
+		wait_for_xmitr(up, BOTH_EMPTY);
 
 		/*
 		 *	Send the character out.
@@ -2219,7 +2219,7 @@ serial8250_console_write(struct console 
 		 */
 		serial_out(up, UART_TX, *s);
 		if (*s == 10) {
-			wait_for_xmitr(up, UART_LSR_THRE);
+			wait_for_xmitr(up, BOTH_EMPTY);
 			serial_out(up, UART_TX, 13);
 		}
 	}
@@ -2229,7 +2229,7 @@ serial8250_console_write(struct console 
 	 *	and restore the IER
 	 */
 	wait_for_xmitr(up, BOTH_EMPTY);
-	serial_out(up, UART_IER, ier | UART_IER_THRI);
+	serial_out(up, UART_IER, ier);
 }
 
 static int serial8250_console_setup(struct console *co, char *options)



