Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261969AbTERFJ1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 May 2003 01:09:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261970AbTERFJ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 May 2003 01:09:27 -0400
Received: from p13109-ipadfx01funabasi.chiba.ocn.ne.jp ([220.96.188.109]:31616
	"HELO mail.achurch.org") by vger.kernel.org with SMTP
	id S261969AbTERFJZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 May 2003 01:09:25 -0400
From: achurch@achurch.org (Andrew Church)
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Fixes for gcc 3.3
Date: Fri, 16 May 2003 01:44:11 JST
Content-Type: text/plain; charset=ISO-2022-JP
X-Mailer: MMail v5.11
Message-ID: <3ec3c4bf.50762@mail.achurch.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Note: I am not subscribed to the list; please CC: me on responses.]

     The following is a short set of modifications I had to make to the
2.4.20 source to get it to compile under gcc 3.3.  There may be more; these
are just the ones that showed up under my configuration.  If anyone is
working on (or planning to work on) kernel/gcc-3.3 compatibility issues,
feel free to use this as a starting point.

  --Andrew Church
    achurch@achurch.org
    http://achurch.org/

---------------------------------------------------------------------------

--- linux-2.4.20-orig/drivers/ide/ide-cd.h	2002-12-10 17:46:28 +0900
+++ linux-2.4.20/drivers/ide/ide-cd.h	2003-05-16 00:59:53 +0900
@@ -437,7 +437,7 @@
 
 	byte     curlba[3];
 	byte     nslots;
-	__u8 short slot_tablelen;
+	__u8     slot_tablelen;
 };
 
 
--- linux-2.4.20-orig/drivers/scsi/aic7xxx/aic7xxx_osm.c	2002-08-03 09:39:44 +0900
+++ linux-2.4.20/drivers/scsi/aic7xxx/aic7xxx_osm.c	2003-05-16 01:21:40 +0900
@@ -417,25 +417,25 @@
 MODULE_LICENSE("Dual BSD/GPL");
 #endif
 MODULE_PARM(aic7xxx, "s");
-MODULE_PARM_DESC(aic7xxx, "period delimited, options string.
-	verbose			Enable verbose/diagnostic logging
-	no_probe		Disable EISA/VLB controller probing
-	no_reset		Supress initial bus resets
-	extended		Enable extended geometry on all controllers
-	periodic_otag		Send an ordered tagged transaction periodically
-				to prevent tag starvation.  This may be
-				required by some older disk drives/RAID arrays. 
-	reverse_scan		Sort PCI devices highest Bus/Slot to lowest
-	tag_info:<tag_str>	Set per-target tag depth
-	seltime:<int>		Selection Timeout(0/256ms,1/128ms,2/64ms,3/32ms)
-
-	Sample /etc/modules.conf line:
-		Enable verbose logging
-		Disable EISA/VLB probing
-		Set tag depth on Controller 2/Target 2 to 10 tags
-		Shorten the selection timeout to 128ms from its default of 256
-
-	options aic7xxx='\"verbose.no_probe.tag_info:{{}.{}.{..10}}.seltime:1\"'
+MODULE_PARM_DESC(aic7xxx, "period delimited, options string.\n\
+	verbose			Enable verbose/diagnostic logging\n\
+	no_probe		Disable EISA/VLB controller probing\n\
+	no_reset		Supress initial bus resets\n\
+	extended		Enable extended geometry on all controllers\n\
+	periodic_otag		Send an ordered tagged transaction periodically\n\
+				to prevent tag starvation.  This may be\n\
+				required by some older disk drives/RAID arrays. \n\
+	reverse_scan		Sort PCI devices highest Bus/Slot to lowest\n\
+	tag_info:<tag_str>	Set per-target tag depth\n\
+	seltime:<int>		Selection Timeout(0/256ms,1/128ms,2/64ms,3/32ms)\n\
+\n\
+	Sample /etc/modules.conf line:\n\
+		Enable verbose logging\n\
+		Disable EISA/VLB probing\n\
+		Set tag depth on Controller 2/Target 2 to 10 tags\n\
+		Shorten the selection timeout to 128ms from its default of 256\n\
+\n\
+	options aic7xxx='\"verbose.no_probe.tag_info:{{}.{}.{..10}}.seltime:1\"'\n\
 ");
 #endif
 
--- linux-2.4.20-orig/net/core/rtnetlink.c	2002-12-09 16:38:46 +0900
+++ linux-2.4.20/net/core/rtnetlink.c	2003-05-16 01:31:20 +0900
@@ -394,7 +394,7 @@
  * Malformed skbs with wrong lengths of messages are discarded silently.
  */
 
-extern __inline__ int rtnetlink_rcv_skb(struct sk_buff *skb)
+__inline__ int rtnetlink_rcv_skb(struct sk_buff *skb)
 {
 	int err;
 	struct nlmsghdr * nlh;
