Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750934AbWDEDQw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750934AbWDEDQw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 23:16:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751065AbWDEDQw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 23:16:52 -0400
Received: from xenotime.net ([66.160.160.81]:215 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1750934AbWDEDQv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 23:16:51 -0400
Date: Tue, 4 Apr 2006 20:15:11 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: lkml <linux-kernel@vger.kernel.org>
Cc: rgooch@atnf.csiro.au, akpm <akpm@osdl.org>
Subject: [PATCH] Doc; fix mtrr userspace programs to build cleanly
Message-Id: <20060404201511.6859070a.rdunlap@xenotime.net>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@xenotime.net>

Fix mtrr-add.c and mtrr-show.c in Doc/mtrr.txt to build cleanly.

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---
 Documentation/mtrr.txt |   23 +++++++++++++++++++++--
 1 files changed, 21 insertions(+), 2 deletions(-)

--- linux-2617-rc1-docsrc.orig/Documentation/mtrr.txt
+++ linux-2617-rc1-docsrc/Documentation/mtrr.txt
@@ -138,19 +138,29 @@ Reading MTRRs from a C program using ioc
 
 */
 #include <stdio.h>
+#include <stdlib.h>
 #include <string.h>
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <fcntl.h>
 #include <sys/ioctl.h>
 #include <errno.h>
-#define MTRR_NEED_STRINGS
 #include <asm/mtrr.h>
 
 #define TRUE 1
 #define FALSE 0
 #define ERRSTRING strerror (errno)
 
+static char *mtrr_strings[MTRR_NUM_TYPES] =
+{
+    "uncachable",               /* 0 */
+    "write-combining",          /* 1 */
+    "?",                        /* 2 */
+    "?",                        /* 3 */
+    "write-through",            /* 4 */
+    "write-protect",            /* 5 */
+    "write-back",               /* 6 */
+};
 
 int main ()
 {
@@ -232,13 +242,22 @@ Creating MTRRs from a C programme using 
 #include <fcntl.h>
 #include <sys/ioctl.h>
 #include <errno.h>
-#define MTRR_NEED_STRINGS
 #include <asm/mtrr.h>
 
 #define TRUE 1
 #define FALSE 0
 #define ERRSTRING strerror (errno)
 
+static char *mtrr_strings[MTRR_NUM_TYPES] =
+{
+    "uncachable",               /* 0 */
+    "write-combining",          /* 1 */
+    "?",                        /* 2 */
+    "?",                        /* 3 */
+    "write-through",            /* 4 */
+    "write-protect",            /* 5 */
+    "write-back",               /* 6 */
+};
 
 int main (int argc, char **argv)
 {


---
