Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261900AbUDNWT1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 18:19:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261918AbUDNWT0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 18:19:26 -0400
Received: from palrel10.hp.com ([156.153.255.245]:48609 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S261900AbUDNWSP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 18:18:15 -0400
Date: Wed, 14 Apr 2004 15:18:13 -0700
To: "David S. Miller" <davem@redhat.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.6 IrDA] irlan -- print_ret_code
Message-ID: <20040414221813.GE5434@bougret.hpl.hp.com>
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

irXXX_irlan_print_ret.diff :
~~~~~~~~~~~~~~~~~~~~~~~~~~
		<Patch from Stephen Hemminger>
	o [FEATURE] Move print_ret_code from a global to local to avoid
		namespace pollution.


diff -Nru a/include/net/irda/irlan_common.h b/include/net/irda/irlan_common.h
--- a/include/net/irda/irlan_common.h	Fri Mar 19 11:29:08 2004
+++ b/include/net/irda/irlan_common.h	Fri Mar 19 11:29:08 2004
@@ -219,7 +219,6 @@
 			     __u16 value_len);
 
 int irlan_extract_param(__u8 *buf, char *name, char *value, __u16 *len);
-void print_ret_code(__u8 code);
 
 #endif
 
diff -Nru a/net/irda/irlan/irlan_client.c b/net/irda/irlan/irlan_client.c
--- a/net/irda/irlan/irlan_client.c	Fri Mar 19 11:29:08 2004
+++ b/net/irda/irlan/irlan_client.c	Fri Mar 19 11:29:08 2004
@@ -343,6 +343,52 @@
 	irttp_data_request(self->client.tsap_ctrl, skb);	
 }
 
+
+/*
+ * Function print_ret_code (code)
+ *
+ *    Print return code of request to peer IrLAN layer.
+ *
+ */
+static void print_ret_code(__u8 code) 
+{
+	switch(code) {
+	case 0:
+		printk(KERN_INFO "Success\n");
+		break;
+	case 1:
+		WARNING("IrLAN: Insufficient resources\n");
+		break;
+	case 2:
+		WARNING("IrLAN: Invalid command format\n");
+		break;
+	case 3:
+		WARNING("IrLAN: Command not supported\n");
+		break;
+	case 4:
+		WARNING("IrLAN: Parameter not supported\n");
+		break;
+	case 5:
+		WARNING("IrLAN: Value not supported\n");
+		break;
+	case 6:
+		WARNING("IrLAN: Not open\n");
+		break;
+	case 7:
+		WARNING("IrLAN: Authentication required\n");
+		break;
+	case 8:
+		WARNING("IrLAN: Invalid password\n");
+		break;
+	case 9:
+		WARNING("IrLAN: Protocol error\n");
+		break;
+	case 255:
+		WARNING("IrLAN: Asynchronous status\n");
+		break;
+	}
+}
+
 /*
  * Function irlan_client_parse_response (self, skb)
  *
diff -Nru a/net/irda/irlan/irlan_common.c b/net/irda/irlan/irlan_common.c
--- a/net/irda/irlan/irlan_common.c	Fri Mar 19 11:29:08 2004
+++ b/net/irda/irlan/irlan_common.c	Fri Mar 19 11:29:08 2004
@@ -1168,51 +1168,6 @@
 }
 #endif
 
-/*
- * Function print_ret_code (code)
- *
- *    Print return code of request to peer IrLAN layer.
- *
- */
-void print_ret_code(__u8 code) 
-{
-	switch(code) {
-	case 0:
-		printk(KERN_INFO "Success\n");
-		break;
-	case 1:
-		WARNING("IrLAN: Insufficient resources\n");
-		break;
-	case 2:
-		WARNING("IrLAN: Invalid command format\n");
-		break;
-	case 3:
-		WARNING("IrLAN: Command not supported\n");
-		break;
-	case 4:
-		WARNING("IrLAN: Parameter not supported\n");
-		break;
-	case 5:
-		WARNING("IrLAN: Value not supported\n");
-		break;
-	case 6:
-		WARNING("IrLAN: Not open\n");
-		break;
-	case 7:
-		WARNING("IrLAN: Authentication required\n");
-		break;
-	case 8:
-		WARNING("IrLAN: Invalid password\n");
-		break;
-	case 9:
-		WARNING("IrLAN: Protocol error\n");
-		break;
-	case 255:
-		WARNING("IrLAN: Asynchronous status\n");
-		break;
-	}
-}
-
 MODULE_AUTHOR("Dag Brattli <dagb@cs.uit.no>");
 MODULE_DESCRIPTION("The Linux IrDA LAN protocol"); 
 MODULE_LICENSE("GPL");
