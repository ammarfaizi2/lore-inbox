Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261928AbUDNWVo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 18:21:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261918AbUDNWTk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 18:19:40 -0400
Received: from palrel10.hp.com ([156.153.255.245]:31202 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S261914AbUDNWTG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 18:19:06 -0400
Date: Wed, 14 Apr 2004 15:19:04 -0700
To: "David S. Miller" <davem@redhat.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.6 IrDA] irlan - change handle_filter_request to irlan_filter_request
Message-ID: <20040414221904.GF5434@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

irXXX_irlan_handle_filter.diff :
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
		<Patch from Stephen Hemminger>
	o [FEATURE] Change name of handle_filter_request to
		irlan_filter_request to avoid namespace pollution.


diff -Nru a/include/net/irda/irlan_filter.h b/include/net/irda/irlan_filter.h
--- a/include/net/irda/irlan_filter.h	Fri Mar 19 11:29:21 2004
+++ b/include/net/irda/irlan_filter.h	Fri Mar 19 11:29:21 2004
@@ -27,7 +27,7 @@
 
 void irlan_check_command_param(struct irlan_cb *self, char *param, 
 			       char *value);
-void handle_filter_request(struct irlan_cb *self, struct sk_buff *skb);
+void irlan_filter_request(struct irlan_cb *self, struct sk_buff *skb);
 int irlan_print_filter(struct seq_file *seq, int filter_type);
 
 #endif /* IRLAN_FILTER_H */
diff -Nru a/net/irda/irlan/irlan_filter.c b/net/irda/irlan/irlan_filter.c
--- a/net/irda/irlan/irlan_filter.c	Fri Mar 19 11:29:21 2004
+++ b/net/irda/irlan/irlan_filter.c	Fri Mar 19 11:29:21 2004
@@ -29,12 +29,12 @@
 #include <net/irda/irlan_common.h>
 
 /*
- * Function handle_filter_request (self, skb)
+ * Function irlan_filter_request (self, skb)
  *
  *    Handle filter request from client peer device
  *
  */
-void handle_filter_request(struct irlan_cb *self, struct sk_buff *skb)
+void irlan_filter_request(struct irlan_cb *self, struct sk_buff *skb)
 {
 	ASSERT(self != NULL, return;);
 	ASSERT(self->magic == IRLAN_MAGIC, return;);
diff -Nru a/net/irda/irlan/irlan_provider.c b/net/irda/irlan/irlan_provider.c
--- a/net/irda/irlan/irlan_provider.c	Fri Mar 19 11:29:21 2004
+++ b/net/irda/irlan/irlan_provider.c	Fri Mar 19 11:29:21 2004
@@ -358,7 +358,7 @@
 					 12);
 		break;
 	case CMD_FILTER_OPERATION:
-		handle_filter_request(self, skb);
+		irlan_filter_request(self, skb);
 		break;
 	default:
 		IRDA_DEBUG(2, "%s(), Unknown command!\n", __FUNCTION__ );
