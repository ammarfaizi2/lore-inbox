Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267330AbUIJJpk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267330AbUIJJpk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 05:45:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267335AbUIJJpk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 05:45:40 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:48901 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S267330AbUIJJpV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 05:45:21 -0400
Date: Fri, 10 Sep 2004 10:45:15 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>
Subject: [PATCH] Fix DHCP ipconfig.c
Message-ID: <20040910104515.A22599@flint.arm.linux.org.uk>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

bk-curr seems to be a little sick here:

  CC      net/ipv4/ipconfig.o
net/ipv4/ipconfig.c: In function `ic_bootp_recv':
net/ipv4/ipconfig.c:969: error: `i' undeclared (first use in this function)
net/ipv4/ipconfig.c:969: error: (Each undeclared identifier is reported only once
net/ipv4/ipconfig.c:969: error: for each function it appears in.)

and here's the medicine:

===== net/ipv4/ipconfig.c 1.41 vs edited =====
--- 1.41/net/ipv4/ipconfig.c	2004-09-07 23:33:17 +01:00
+++ edited/net/ipv4/ipconfig.c	2004-09-10 10:43:31 +01:00
@@ -913,7 +913,7 @@
 #ifdef IPCONFIG_DHCP
 		if (ic_proto_enabled & IC_USE_DHCP) {
 			u32 server_id = INADDR_NONE;
-			int mt = 0;
+			int mt = 0, i;
 
 			ext = &b->exten[4];
 			while (ext < end && *ext != 0xff) {


-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
