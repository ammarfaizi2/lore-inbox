Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270720AbTHOTCP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Aug 2003 15:02:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270707AbTHOSeU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Aug 2003 14:34:20 -0400
Received: from mail.kroah.org ([65.200.24.183]:61058 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S270713AbTHOSZg convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Aug 2003 14:25:36 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10609719484044@kroah.com>
Subject: Re: [PATCH] Driver Core fixes for 2.6.0-test3
In-Reply-To: <10609719481470@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 15 Aug 2003 11:25:48 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1152.2.4, 2003/08/14 16:53:55-07:00, greg@kroah.com

Remove usage of struct device.name from pcmcia layer


 drivers/pcmcia/i82365.c       |    3 ---
 drivers/pcmcia/tcic.c         |    3 ---
 drivers/pcmcia/yenta_socket.c |    2 +-
 3 files changed, 1 insertion(+), 7 deletions(-)


diff -Nru a/drivers/pcmcia/i82365.c b/drivers/pcmcia/i82365.c
--- a/drivers/pcmcia/i82365.c	Fri Aug 15 11:16:00 2003
+++ b/drivers/pcmcia/i82365.c	Fri Aug 15 11:16:00 2003
@@ -1361,9 +1361,6 @@
 static struct platform_device i82365_device = {
 	.name = "i82365",
 	.id = 0,
-	.dev = {
-		.name = "i82365",
-	},
 };
 
 static int __init init_i82365(void)
diff -Nru a/drivers/pcmcia/tcic.c b/drivers/pcmcia/tcic.c
--- a/drivers/pcmcia/tcic.c	Fri Aug 15 11:16:00 2003
+++ b/drivers/pcmcia/tcic.c	Fri Aug 15 11:16:00 2003
@@ -372,9 +372,6 @@
 static struct platform_device tcic_device = {
 	.name = "tcic-pcmcia",
 	.id = 0,
-	.dev = {
-		.name = "tcic-pcmcia",
-	},
 };
 
 
diff -Nru a/drivers/pcmcia/yenta_socket.c b/drivers/pcmcia/yenta_socket.c
--- a/drivers/pcmcia/yenta_socket.c	Fri Aug 15 11:16:00 2003
+++ b/drivers/pcmcia/yenta_socket.c	Fri Aug 15 11:16:00 2003
@@ -899,7 +899,7 @@
 
 	/* We must finish initialization here */
 
-	if (!socket->cb_irq || request_irq(socket->cb_irq, yenta_interrupt, SA_SHIRQ, socket->dev->dev.name, socket)) {
+	if (!socket->cb_irq || request_irq(socket->cb_irq, yenta_interrupt, SA_SHIRQ, pci_name(socket->dev), socket)) {
 		/* No IRQ or request_irq failed. Poll */
 		socket->cb_irq = 0; /* But zero is a valid IRQ number. */
 		init_timer(&socket->poll_timer);

