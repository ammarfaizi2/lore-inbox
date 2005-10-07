Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932572AbVJGNnd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932572AbVJGNnd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Oct 2005 09:43:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932592AbVJGNnd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Oct 2005 09:43:33 -0400
Received: from webapps.arcom.com ([194.200.159.168]:2571 "EHLO
	webapps.arcom.com") by vger.kernel.org with ESMTP id S932572AbVJGNnc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Oct 2005 09:43:32 -0400
Message-ID: <43467B7A.2000903@cantab.net>
Date: Fri, 07 Oct 2005 14:43:22 +0100
From: David Vrabel <dvrabel@cantab.net>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051001)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
CC: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Subject: [patch] yenta: fix YENTA && !CARDBUS build
References: <43414BFB.3090206@arcom.com>
In-Reply-To: <43414BFB.3090206@arcom.com>
Content-Type: multipart/mixed;
 boundary="------------040606070608060705020007"
X-OriginalArrivalTime: 07 Oct 2005 13:43:29.0875 (UTC) FILETIME=[19F75A30:01C5CB45]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040606070608060705020007
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

(Previous patch left a warning.)

yenta_socket no longer builds if CONFIG_CARDBUS is disabled.  It doesn't
look like ene_tune_bridge is relevant in the !CARDBUS configuration so
I've just disabled it.

--------------040606070608060705020007
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
--- linux-2.6-working.orig/drivers/pcmcia/ti113x.h	2005-10-04 15:08:31.000000000 +0100
+++ linux-2.6-working/drivers/pcmcia/ti113x.h	2005-10-04 15:42:25.000000000 +0100
@@ -873,6 +873,7 @@
  * Some fixup code to make everybody happy (TM).
  */
 
+#ifdef CONFIG_CARDBUS
 /**
  * set/clear various test bits:
  * Defaults to clear the bit.
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
 

--------------040606070608060705020007--
