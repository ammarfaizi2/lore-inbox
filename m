Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262444AbTJIWWA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Oct 2003 18:22:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262564AbTJIWWA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Oct 2003 18:22:00 -0400
Received: from hq.pm.waw.pl ([195.116.170.10]:46293 "EHLO hq.pm.waw.pl")
	by vger.kernel.org with ESMTP id S262444AbTJIWV6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Oct 2003 18:21:58 -0400
To: Linus Torvalds <torvalds@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: [TRIVIAL] [PATCH] generic HDLC Cisco bugfix
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: 10 Oct 2003 00:13:46 +0200
Message-ID: <m3ismyvz39.fsf@defiant.pm.waw.pl>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=

Hi,

The attached patch fixes transmitted headers with generic HDLC + Cisco
encapsulation. Please apply. Thanks.
-- 
Krzysztof Halasa, B*FH

--=-=-=
Content-Type: text/x-patch
Content-Disposition: attachment; filename=hdlc-2.6.0test7.patch

--- linux-2.6.orig/drivers/net/wan/hdlc_cisco.c	2003-08-09 06:34:37.000000000 +0200
+++ linux-2.6/drivers/net/wan/hdlc_cisco.c	2003-10-09 23:40:00.000000000 +0200
@@ -311,7 +311,9 @@
 		hdlc->proto.id = IF_PROTO_CISCO;
 		dev->hard_start_xmit = hdlc->xmit;
 		dev->hard_header = cisco_hard_header;
+		dev->hard_header_cache = NULL;
 		dev->type = ARPHRD_CISCO;
+		dev->flags = IFF_POINTOPOINT | IFF_NOARP;
 		dev->addr_len = 0;
 		return 0;
 	}

--=-=-=--
