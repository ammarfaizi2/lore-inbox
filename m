Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270509AbUJUBkh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270509AbUJUBkh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 21:40:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270482AbUJUBio
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 21:38:44 -0400
Received: from ozlabs.org ([203.10.76.45]:50382 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S270659AbUJUBgw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 21:36:52 -0400
Date: Thu, 21 Oct 2004 11:35:49 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Andrew Morton <akpm@osdl.org>
Cc: Anton Blanchard <anton@samba.org>, Paul Mackerras <paulus@samba.org>,
       linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org,
       trivial@rustcorp.com.au
Subject: [PPC64] Trivial sparse cleanups
Message-ID: <20041021013549.GI17760@zax>
Mail-Followup-To: David Gibson <david@gibson.dropbear.id.au>,
	Andrew Morton <akpm@osdl.org>, Anton Blanchard <anton@samba.org>,
	Paul Mackerras <paulus@samba.org>, linuxppc64-dev@ozlabs.org,
	linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew, please apply:

This patch squashes a handful of assorted sparse warnings in the ppc64
code.  Should be pretty much trivial and self explanatory.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Index: working-2.6/arch/ppc64/kernel/nvram.c
===================================================================
--- working-2.6.orig/arch/ppc64/kernel/nvram.c	2004-09-24 10:14:09.000000000 +1000
+++ working-2.6/arch/ppc64/kernel/nvram.c	2004-10-21 11:34:39.057902952 +1000
@@ -77,7 +77,7 @@
 }
 
 
-static ssize_t dev_nvram_read(struct file *file, char *buf,
+static ssize_t dev_nvram_read(struct file *file, char __user *buf,
 			  size_t count, loff_t *ppos)
 {
 	ssize_t len;
@@ -117,7 +117,7 @@
 
 }
 
-static ssize_t dev_nvram_write(struct file *file, const char *buf,
+static ssize_t dev_nvram_write(struct file *file, const char __user *buf,
 			   size_t count, loff_t *ppos)
 {
 	ssize_t len;
Index: working-2.6/arch/ppc64/kernel/setup.c
===================================================================
--- working-2.6.orig/arch/ppc64/kernel/setup.c	2004-10-05 10:08:10.000000000 +1000
+++ working-2.6/arch/ppc64/kernel/setup.c	2004-10-21 11:34:39.059902648 +1000
@@ -1111,7 +1111,7 @@
 {
 	/* ensure xmon is enabled */
 	xmon_init();
-	debugger(0);
+	debugger(NULL);
 
 	return 0;
 }
Index: working-2.6/arch/ppc64/mm/hugetlbpage.c
===================================================================
--- working-2.6.orig/arch/ppc64/mm/hugetlbpage.c	2004-10-20 10:52:39.000000000 +1000
+++ working-2.6/arch/ppc64/mm/hugetlbpage.c	2004-10-21 11:34:39.060902496 +1000
@@ -249,7 +249,7 @@
 {
 	if (within_hugepage_high_range(addr, len))
 		return 0;
-	else if ((addr < 0x100000000) && ((addr+len) < 0x100000000)) {
+	else if ((addr < 0x100000000UL) && ((addr+len) < 0x100000000UL)) {
 		int err;
 		/* Yes, we need both tests, in case addr+len overflows
 		 * 64-bit arithmetic */
Index: working-2.6/arch/ppc64/mm/hash_utils.c
===================================================================
--- working-2.6.orig/arch/ppc64/mm/hash_utils.c	2004-09-28 10:22:13.000000000 +1000
+++ working-2.6/arch/ppc64/mm/hash_utils.c	2004-10-21 11:34:39.060902496 +1000
@@ -401,7 +401,7 @@
 		info.si_signo = SIGBUS;
 		info.si_errno = 0;
 		info.si_code = BUS_ADRERR;
-		info.si_addr = (void *)address;
+		info.si_addr = (void __user *)address;
 		force_sig_info(SIGBUS, &info, current);
 		return;
 	}



-- 
David Gibson			| For every complex problem there is a
david AT gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson
