Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261184AbVDBH0Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261184AbVDBH0Q (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Apr 2005 02:26:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261196AbVDBH0Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Apr 2005 02:26:16 -0500
Received: from ozlabs.org ([203.10.76.45]:27031 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261184AbVDBH0L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Apr 2005 02:26:11 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16974.18698.304283.188321@cargo.ozlabs.ibm.com>
Date: Sat, 2 Apr 2005 17:26:02 +1000
From: Paul Mackerras <paulus@samba.org>
To: akpm@osdl.org
Cc: benh@kernel.crashing.org, trini@kernel.crashing.org,
       linux-kernel@vger.kernel.org
Subject: [PATCH] ppc: eliminate gcc warning in xmon.c
X-Mailer: VM 7.19 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch shuts up some more incorrect gcc warnings.

Signed-off-by: Paul Mackerras <paulus@samba.org>

diff -urN linux-2.5/arch/ppc/xmon/xmon.c testpmac/arch/ppc/xmon/xmon.c
--- linux-2.5/arch/ppc/xmon/xmon.c	2004-10-21 07:17:18.000000000 +1000
+++ testpmac/arch/ppc/xmon/xmon.c	2005-04-02 17:23:19.000000000 +1000
@@ -1033,9 +1033,9 @@
 	extern unsigned long Hash_size;
 	unsigned *htab = Hash;
 	unsigned hsize = Hash_size;
-	unsigned v, hmask, va, last_va;
+	unsigned v, hmask, va, last_va = 0;
 	int found, last_found, i;
-	unsigned *hg, w1, last_w2, last_va0;
+	unsigned *hg, w1, last_w2 = 0, last_va0 = 0;
 
 	last_found = 0;
 	hmask = hsize / 64 - 1;
@@ -1492,7 +1492,7 @@
 {
 	int nr, dotted;
 	unsigned first_adr;
-	unsigned long inst, last_inst;
+	unsigned long inst, last_inst = 0;
 	unsigned char val[4];
 
 	dotted = 0;
@@ -1959,7 +1959,7 @@
 xmon_symbol_to_addr(char* symbol)
 {
 	char *p, *cur;
-	char *match;
+	char *match = NULL;
 	int goodness = 0;
 	int result = 0;
 	
