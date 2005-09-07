Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751263AbVIGWRH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751263AbVIGWRH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Sep 2005 18:17:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751298AbVIGWRH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Sep 2005 18:17:07 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:63719 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1751271AbVIGWRG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Sep 2005 18:17:06 -0400
Date: Wed, 7 Sep 2005 23:16:59 +0100
From: viro@ZenIV.linux.org.uk
To: Linus Torvalds <torvalds@osdl.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] -Wundef fixes (hamachi)
Message-ID: <20050907221659.GA13549@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All uses of ADDRLEN are comparisons with 64 (it's an address width).
added define to 32 (again, we only care about comparisons with 64)
if not defined.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
----
diff -urN RC13-git7-ncr5380/drivers/net/hamachi.c RC13-git7-hamachi/drivers/net/hamachi.c
--- RC13-git7-ncr5380/drivers/net/hamachi.c	2005-08-28 23:09:44.000000000 -0400
+++ RC13-git7-hamachi/drivers/net/hamachi.c	2005-09-07 13:55:45.000000000 -0400
@@ -204,6 +204,10 @@
 
 #define RUN_AT(x) (jiffies + (x))
 
+#ifndef ADDRLEN
+#define ADDRLEN 32
+#endif
+
 /* Condensed bus+endian portability operations. */
 #if ADDRLEN == 64
 #define cpu_to_leXX(addr)	cpu_to_le64(addr)
