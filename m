Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030268AbWI0RAZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030268AbWI0RAZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 13:00:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030244AbWI0Q7x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 12:59:53 -0400
Received: from nat-132.atmel.no ([80.232.32.132]:40652 "EHLO relay.atmel.no")
	by vger.kernel.org with ESMTP id S1030245AbWI0Q7s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 12:59:48 -0400
From: Haavard Skinnemoen <hskinnemoen@atmel.com>
To: Andrew Victor <andrew@sanpeople.com>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>, linux-kernel@vger.kernel.org,
       hskinnemoen@atmel.com
Subject: [PATCH 7/8] serial: Rename PORT_AT91 -> PORT_ATMEL
Reply-To: Haavard Skinnemoen <hskinnemoen@atmel.com>
Date: Wed, 27 Sep 2006 18:58:04 +0200
Message-Id: <1159376285621-git-send-email-hskinnemoen@atmel.com>
X-Mailer: git-send-email 1.4.1.1
In-Reply-To: <11593762851494-git-send-email-hskinnemoen@atmel.com>
References: <1159376285670-git-send-email-hskinnemoen@atmel.com> <115937628584-git-send-email-hskinnemoen@atmel.com> <11593762852168-git-send-email-hskinnemoen@atmel.com> <11593762851735-git-send-email-hskinnemoen@atmel.com> <11593762853931-git-send-email-hskinnemoen@atmel.com> <11593762851544-git-send-email-hskinnemoen@atmel.com> <11593762851494-git-send-email-hskinnemoen@atmel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The at91_serial driver can be used with both AT32 and AT91 devices
from Atmel and has therefore been renamed atmel_serial. The only
thing left is to rename PORT_AT91 PORT_ATMEL.

Signed-off-by: Haavard Skinnemoen <hskinnemoen@atmel.com>
---
 drivers/serial/atmel_serial.c |    6 +++---
 include/linux/serial_core.h   |    4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/serial/atmel_serial.c b/drivers/serial/atmel_serial.c
index 9cfa63d..420921d 100644
--- a/drivers/serial/atmel_serial.c
+++ b/drivers/serial/atmel_serial.c
@@ -581,7 +581,7 @@ static void atmel_set_termios(struct uar
  */
 static const char *atmel_type(struct uart_port *port)
 {
-	return (port->type == PORT_AT91) ? "ATMEL_SERIAL" : NULL;
+	return (port->type == PORT_ATMEL) ? "ATMEL_SERIAL" : NULL;
 }
 
 /*
@@ -628,7 +628,7 @@ static int atmel_request_port(struct uar
 static void atmel_config_port(struct uart_port *port, int flags)
 {
 	if (flags & UART_CONFIG_TYPE) {
-		port->type = PORT_AT91;
+		port->type = PORT_ATMEL;
 		atmel_request_port(port);
 	}
 }
@@ -639,7 +639,7 @@ static void atmel_config_port(struct uar
 static int atmel_verify_port(struct uart_port *port, struct serial_struct *ser)
 {
 	int ret = 0;
-	if (ser->type != PORT_UNKNOWN && ser->type != PORT_AT91)
+	if (ser->type != PORT_UNKNOWN && ser->type != PORT_ATMEL)
 		ret = -EINVAL;
 	if (port->irq != ser->irq)
 		ret = -EINVAL;
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index 86501a3..e5c44aa 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -67,8 +67,8 @@ #define PORT_DZ		47
 /* Parisc type numbers. */
 #define PORT_MUX	48
 
-/* Atmel AT91xxx SoC */
-#define PORT_AT91	49
+/* Atmel AT91 / AT32 SoC */
+#define PORT_ATMEL	49
 
 /* Macintosh Zilog type numbers */
 #define PORT_MAC_ZILOG	50	/* m68k : not yet implemented */
-- 
1.4.1.1

