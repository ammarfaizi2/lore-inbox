Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268685AbUJDXII@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268685AbUJDXII (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 19:08:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268690AbUJDXGp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 19:06:45 -0400
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:15627 "EHLO
	pollux.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S268688AbUJDW5A
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 18:57:00 -0400
Date: Mon, 4 Oct 2004 23:56:59 +0100 (BST)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: netdev@oss.sgi.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH RESEND] 2.[46]: Set ARP hw type correctly for BOOTP over FDDI
Message-ID: <Pine.LNX.4.58L.0410040310550.22545@blysk.ds.pg.gda.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

 Using the Ethernet ARP hw type for FDDI networks is mandated by RFC 1390
(STD 36) and that code is already used by Linux elsewhere, but not for
BOOTP requests sent for IPv4 autoconfiguration.  Here is a patch for both
2.4 and 2.6 that fixes the problem for me.  Please apply.

 Applies both to 2.4.27 and to 2.6.8.1.

  Maciej

Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>

patch-ipconfig-fddi-0
diff -up --recursive --new-file linux.macro/net/ipv4/ipconfig.c linux/net/ipv4/ipconfig.c
--- linux.macro/net/ipv4/ipconfig.c	2003-11-17 04:00:34.000000000 +0000
+++ linux/net/ipv4/ipconfig.c	2004-08-12 00:03:32.000000000 +0000
@@ -689,6 +689,8 @@ static void __init ic_bootp_send_if(stru
 		b->htype = dev->type;
 	else if (dev->type == ARPHRD_IEEE802_TR) /* fix for token ring */
 		b->htype = ARPHRD_IEEE802;
+	else if (dev->type == ARPHRD_FDDI)
+		b->htype = ARPHRD_ETHER;
 	else {
 		printk("Unknown ARP type 0x%04x for device %s\n", dev->type, dev->name);
 		b->htype = dev->type; /* can cause undefined behavior */
