Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270434AbUJUDpX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270434AbUJUDpX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 23:45:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270527AbUJUDlw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 23:41:52 -0400
Received: from ozlabs.org ([203.10.76.45]:3794 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S270434AbUJUDhX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 23:37:23 -0400
Date: Thu, 21 Oct 2004 13:36:17 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Andrew Morton <akpm@osdl.org>
Cc: Anton Blanchard <anton@samba.org>, Paul Mackerras <paulus@samba.org>,
       linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PPC64] xmon sparse cleanups
Message-ID: <20041021033617.GK17760@zax>
Mail-Followup-To: David Gibson <david@gibson.dropbear.id.au>,
	Andrew Morton <akpm@osdl.org>, Anton Blanchard <anton@samba.org>,
	Paul Mackerras <paulus@samba.org>, linuxppc64-dev@ozlabs.org,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew, please apply:

This patch removes many sparse warnings from the xmon code.  Mostly
K&R function declarations and 0-instead-of-NULLs.  There are still a
whole bunch of warnings in xmon/ppc-opc.c, which is a copy of a file
from binutils.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Index: working-2.6/arch/ppc64/xmon/xmon.c
===================================================================
--- working-2.6.orig/arch/ppc64/xmon/xmon.c	2004-09-24 10:14:09.000000000 +1000
+++ working-2.6/arch/ppc64/xmon/xmon.c	2004-10-05 16:31:01.822963256 +1000
@@ -645,7 +645,7 @@
 	for (i = 0; i < NBPTS; ++i, ++bp)
 		if (bp->enabled && pc == bp->address)
 			return bp;
-	return 0;
+	return NULL;
 }
 
 static struct bpt *in_breakpoint_table(unsigned long nip, unsigned long *offp)
@@ -1582,7 +1582,7 @@
 extern char dec_exc;
 
 void
-super_regs()
+super_regs(void)
 {
 	int cmd;
 	unsigned long val;
@@ -1816,7 +1816,7 @@
     "";
 
 void
-memex()
+memex(void)
 {
 	int cmd, inc, i, nslash;
 	unsigned long n;
@@ -1967,7 +1967,7 @@
 }
 
 int
-bsesc()
+bsesc(void)
 {
 	int c;
 
@@ -1985,7 +1985,7 @@
 			 || ('a' <= (c) && (c) <= 'f') \
 			 || ('A' <= (c) && (c) <= 'F'))
 void
-dump()
+dump(void)
 {
 	int c;
 
@@ -2150,7 +2150,7 @@
 static unsigned mask;
 
 void
-memlocate()
+memlocate(void)
 {
 	unsigned a, n;
 	unsigned char val[4];
@@ -2183,7 +2183,7 @@
 static unsigned long mlim = 0xffffffff;
 
 void
-memzcan()
+memzcan(void)
 {
 	unsigned char v;
 	unsigned a;
@@ -2212,7 +2212,7 @@
 
 /* Input scanning routines */
 int
-skipbl()
+skipbl(void)
 {
 	int c;
 
@@ -2237,8 +2237,7 @@
 };
 
 int
-scanhex(vp)
-unsigned long *vp;
+scanhex(unsigned long *vp)
 {
 	int c, d;
 	unsigned long v;
@@ -2322,7 +2321,7 @@
 }
 
 void
-scannl()
+scannl(void)
 {
 	int c;
 
@@ -2365,13 +2364,13 @@
 static char *lineptr;
 
 void
-flush_input()
+flush_input(void)
 {
 	lineptr = NULL;
 }
 
 int
-inchar()
+inchar(void)
 {
 	if (lineptr == NULL || *lineptr == 0) {
 		if (fgets(line, sizeof(line), stdin) == NULL) {
@@ -2384,8 +2383,7 @@
 }
 
 void
-take_input(str)
-char *str;
+take_input(char *str)
 {
 	lineptr = str;
 }
Index: working-2.6/arch/ppc64/xmon/start.c
===================================================================
--- working-2.6.orig/arch/ppc64/xmon/start.c	2004-08-09 09:51:38.000000000 +1000
+++ working-2.6/arch/ppc64/xmon/start.c	2004-10-05 16:33:50.355028808 +1000
@@ -173,7 +173,7 @@
 		c = xmon_getchar();
 		if (c == -1) {
 			if (p == str)
-				return 0;
+				return NULL;
 			break;
 		}
 		*p++ = c;


-- 
David Gibson			| For every complex problem there is a
david AT gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson
