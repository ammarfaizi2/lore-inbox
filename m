Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268381AbUHWX0g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268381AbUHWX0g (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 19:26:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268378AbUHWXZm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 19:25:42 -0400
Received: from delerium.kernelslacker.org ([81.187.208.145]:16533 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S268330AbUHWXXk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 19:23:40 -0400
Date: Tue, 24 Aug 2004 00:23:20 +0100
From: Dave Jones <davej@redhat.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, ak@suse.de
Subject: Fix MTRR strings definition.
Message-ID: <20040823232320.GA1875@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linus Torvalds <torvalds@osdl.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>, ak@suse.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of deleting the extern from include/asm/mtrr.h, I believe
the correct fix would be to move the strings back to the include file
where they belong.
The reason behind this, is that there are userspace apps (admittedly
few, but we even ship two in Documentation/mtrr.txt) that rely upon
these definitions being in that header.  This has been broken for
all 2.6 releases so far. Patch below fixes things back the way it
was in 2.4

Andi, I don't have gcc 3.5 to hand, I trust this fixes whatever
problem you saw there too ?

		Dave

Restore mtrr_strings header definitions to how things were in 2.4

Signed-off-by: Dave Jones <davej@redhat.com>


--- latest-FC2/arch/i386/kernel/cpu/mtrr/if.c~	2004-08-24 00:13:41.419631072 +0100
+++ latest-FC2/arch/i386/kernel/cpu/mtrr/if.c	2004-08-24 00:14:13.639732872 +0100
@@ -6,6 +6,7 @@
 #include <asm/uaccess.h>
 
 #define LINE_SIZE 80
+#define MTRR_NEED_STRINGS
 
 #include <asm/mtrr.h>
 #include "mtrr.h"
@@ -16,17 +17,6 @@
 
 #define FILE_FCOUNT(f) (((struct seq_file *)((f)->private_data))->private)
 
-static char *mtrr_strings[MTRR_NUM_TYPES] =
-{
-    "uncachable",               /* 0 */
-    "write-combining",          /* 1 */
-    "?",                        /* 2 */
-    "?",                        /* 3 */
-    "write-through",            /* 4 */
-    "write-protect",            /* 5 */
-    "write-back",               /* 6 */
-};
-
 char *mtrr_attrib_to_str(int x)
 {
 	return (x <= 6) ? mtrr_strings[x] : "?";
--- latest-FC2/include/asm-i386/mtrr.h~	2004-08-24 00:02:40.000000000 +0100
+++ latest-FC2/include/asm-i386/mtrr.h	2004-08-24 00:18:08.537023056 +0100
@@ -65,6 +65,19 @@
 #define MTRR_TYPE_WRBACK     6
 #define MTRR_NUM_TYPES       7
 
+#ifdef MTRR_NEED_STRINGS
+static char *mtrr_strings[MTRR_NUM_TYPES] =
+{
+	"uncachable",		/* 0 */
+	"write-combining",	/* 1 */
+	"?",			/* 2 */
+	"?",			/* 3 */
+	"write-through",	/* 4 */
+	"write-protect",	/* 5 */
+	"write-back",		/* 6 */
+};
+#endif
+
 #ifdef __KERNEL__
 
 /*  The following functions are for use by other drivers  */

--- latest-FC2/include/asm-x86_64/mtrr.h~	2004-08-24 00:20:17.377436336 +0100
+++ latest-FC2/include/asm-x86_64/mtrr.h	2004-08-24 00:21:04.137327752 +0100
@@ -69,6 +69,19 @@
 #define MTRR_TYPE_WRBACK     6
 #define MTRR_NUM_TYPES       7
 
+#ifdef MTRR_NEED_STRINGS
+static char *mtrr_strings[MTRR_NUM_TYPES] =
+{
+	"uncachable",		/* 0 */
+	"write-combining",	/* 1 */
+	"?",			/* 2 */
+	"?",			/* 3 */
+	"write-through",	/* 4 */
+	"write-protect",	/* 5 */
+	"write-back",		/* 6 */
+};
+#endif
+
 #ifdef __KERNEL__
 
 extern char *mtrr_strings[MTRR_NUM_TYPES];
