Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161085AbVICBrm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161085AbVICBrm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 21:47:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751364AbVICBrm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 21:47:42 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:47373 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751355AbVICBrl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 21:47:41 -0400
Date: Sat, 3 Sep 2005 03:47:31 +0200
From: Adrian Bunk <bunk@stusta.de>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] IrDA prototype fixes
Message-ID: <20050903014731.GH3657@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Every file should #include the header files containing the prototypes of
it's global functions.

In this case this showed that the prototype of irlan_print_filter() was 
wrong which is also corrected in this patch.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 include/net/irda/irlan_filter.h |    2 +-
 net/irda/irlan/irlan_filter.c   |    1 +
 net/irda/qos.c                  |    1 +
 3 files changed, 3 insertions(+), 1 deletion(-)

--- linux-2.6.13-mm1-full/net/irda/qos.c.old	2005-09-03 02:23:07.000000000 +0200
+++ linux-2.6.13-mm1-full/net/irda/qos.c	2005-09-03 02:23:31.000000000 +0200
@@ -37,6 +37,7 @@
 #include <net/irda/parameters.h>
 #include <net/irda/qos.h>
 #include <net/irda/irlap.h>
+#include <net/irda/irlap_frame.h>
 
 /*
  * Maximum values of the baud rate we negociate with the other end.
--- linux-2.6.13-mm1-full/include/net/irda/irlan_filter.h.old	2005-09-03 02:43:20.000000000 +0200
+++ linux-2.6.13-mm1-full/include/net/irda/irlan_filter.h	2005-09-03 02:43:29.000000000 +0200
@@ -28,6 +28,6 @@
 void irlan_check_command_param(struct irlan_cb *self, char *param, 
 			       char *value);
 void irlan_filter_request(struct irlan_cb *self, struct sk_buff *skb);
-int irlan_print_filter(struct seq_file *seq, int filter_type);
+void irlan_print_filter(struct seq_file *seq, int filter_type);
 
 #endif /* IRLAN_FILTER_H */
--- linux-2.6.13-mm1-full/net/irda/irlan/irlan_filter.c.old	2005-09-03 02:25:06.000000000 +0200
+++ linux-2.6.13-mm1-full/net/irda/irlan/irlan_filter.c	2005-09-03 02:25:24.000000000 +0200
@@ -27,6 +27,7 @@
 #include <linux/seq_file.h>
 
 #include <net/irda/irlan_common.h>
+#include <net/irda/irlan_filter.h>
 
 /*
  * Function irlan_filter_request (self, skb)

