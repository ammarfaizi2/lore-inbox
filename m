Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751093AbVJCPTc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751093AbVJCPTc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 11:19:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751101AbVJCPTc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 11:19:32 -0400
Received: from webapps.arcom.com ([194.200.159.168]:23817 "EHLO
	webapps.arcom.com") by vger.kernel.org with ESMTP id S1751093AbVJCPTb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 11:19:31 -0400
Message-ID: <43414BFB.3090206@arcom.com>
Date: Mon, 03 Oct 2005 16:19:23 +0100
From: David Vrabel <dvrabel@arcom.com>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051001)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [patch] yenta: fix YENTA && !CARDBUS build
Content-Type: multipart/mixed;
 boundary="------------020102010505010402020107"
X-OriginalArrivalTime: 03 Oct 2005 15:19:21.0796 (UTC) FILETIME=[D4B9D840:01C5C82D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020102010505010402020107
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi,

yenta_socket no longer builds if CONFIG_CARDBUS is disabled.  It doesn't
look like ene_tune_bridge is relevant in the !CARDBUS configuration so
I've just disabled it.

David Vrabel
-- 
David Vrabel, Design Engineer

Arcom, Clifton Road           Tel: +44 (0)1223 411200 ext. 3233
Cambridge CB1 7EA, UK         Web: http://www.arcom.com/


--------------020102010505010402020107
Content-Type: text/plain;
 name="yenta-not-CARDBUS-build-fix"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="yenta-not-CARDBUS-build-fix"

yenta: fix build if YENTA && !CARDBUS

(struct pcmcia_socket).tune_bridge only exists if CONFIG_CARDBUS is set but
building yenta_socket without CardBus is valid.

Signed-off-by: David Vrabel <dvrabel@arcom.com>

Index: linux-2.6-working/drivers/pcmcia/ti113x.h
===================================================================
--- linux-2.6-working.orig/drivers/pcmcia/ti113x.h	2005-10-03 14:44:14.000000000 +0100
+++ linux-2.6-working/drivers/pcmcia/ti113x.h	2005-10-03 15:05:12.000000000 +0100
@@ -899,6 +899,7 @@
 	{}
 };
 
+#ifdef CONFIG_CARDBUS
 static void ene_tune_bridge(struct pcmcia_socket *sock, struct pci_bus *bus)
 {
 	struct yenta_socket *socket = container_of(sock, struct yenta_socket, socket);
@@ -927,7 +928,6 @@
 	config_writeb(socket, ENE_TEST_C9, test_c9);
 }
 
-
 static int ene_override(struct yenta_socket *socket)
 {
 	/* install tune_bridge() function */
@@ -935,6 +935,9 @@
 
 	return ti1250_override(socket);
 }
+#else
+#  define ene_override ti1250_override
+#endif
 
 #endif /* _LINUX_TI113X_H */
 

--------------020102010505010402020107--
