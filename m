Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261771AbVACRku@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261771AbVACRku (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 12:40:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261757AbVACRkt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 12:40:49 -0500
Received: from holomorphy.com ([207.189.100.168]:43932 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S261614AbVACRkB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 12:40:01 -0500
Date: Mon, 3 Jan 2005 09:39:53 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org
Subject: [6/8] make IRDA string tables conditional on CONFIG_IRDA_DEBUG
Message-ID: <20050103173952.GH29332@holomorphy.com>
References: <20050103172013.GA29332@holomorphy.com> <20050103172303.GB29332@holomorphy.com> <20050103172615.GD29332@holomorphy.com> <20050103172839.GE29332@holomorphy.com> <20050103173406.GF29332@holomorphy.com> <20050103173643.GG29332@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050103173643.GG29332@holomorphy.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There are some string tables only used for debugging printk()'s in IRDA
that trip warnings when CONFIG_IRDA_DEBUG is not set.

This patch makes them conditional on CONFIG_IRDA_DEBUG to silence warnings.

Signed-off-by: William Irwin <wli@holomorphy.com>

Index: mm1-2.6.10/net/irda/ircomm/ircomm_event.c
===================================================================
--- mm1-2.6.10.orig/net/irda/ircomm/ircomm_event.c	2005-01-03 06:44:20.000000000 -0800
+++ mm1-2.6.10/net/irda/ircomm/ircomm_event.c	2005-01-03 08:19:38.000000000 -0800
@@ -57,6 +57,7 @@
 	"IRCOMM_CONN",
 };
 
+#ifdef CONFIG_IRDA_DEBUG
 static char *ircomm_event[] = {
 	"IRCOMM_CONNECT_REQUEST",
         "IRCOMM_CONNECT_RESPONSE",
@@ -75,6 +76,7 @@
         "IRCOMM_CONTROL_REQUEST",
         "IRCOMM_CONTROL_INDICATION",
 };
+#endif /* CONFIG_IRDA_DEBUG */
 
 static int (*state[])(struct ircomm_cb *self, IRCOMM_EVENT event,
 		      struct sk_buff *skb, struct ircomm_info *info) = 
Index: mm1-2.6.10/net/irda/ircomm/ircomm_tty_attach.c
===================================================================
--- mm1-2.6.10.orig/net/irda/ircomm/ircomm_tty_attach.c	2005-01-03 06:44:20.000000000 -0800
+++ mm1-2.6.10/net/irda/ircomm/ircomm_tty_attach.c	2005-01-03 08:18:48.000000000 -0800
@@ -91,6 +91,7 @@
 	"*** ERROR *** ",
 };
 
+#ifdef CONFIG_IRDA_DEBUG
 static char *ircomm_tty_event[] = {
 	"IRCOMM_TTY_ATTACH_CABLE",
 	"IRCOMM_TTY_DETACH_CABLE",
@@ -107,6 +108,7 @@
 	"IRCOMM_TTY_GOT_LSAPSEL",
 	"*** ERROR ****",
 };
+#endif /* CONFIG_IRDA_DEBUG */
 
 static int (*state[])(struct ircomm_tty_cb *self, IRCOMM_TTY_EVENT event,
 		      struct sk_buff *skb, struct ircomm_tty_info *info) = 
