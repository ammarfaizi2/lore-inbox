Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261608AbVEYXW7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261608AbVEYXW7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 May 2005 19:22:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261610AbVEYXW7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 May 2005 19:22:59 -0400
Received: from fire.osdl.org ([65.172.181.4]:20636 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261608AbVEYXWq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 May 2005 19:22:46 -0400
Date: Wed, 25 May 2005 16:23:18 -0700
From: Andrew Morton <akpm@osdl.org>
To: Alexandre Buisse <alexandre.buisse@ens-lyon.fr>
Cc: linux-kernel@vger.kernel.org, pcaulfie@redhat.com, teigland@redhat.com
Subject: Re: dlm-lockspaces-callbacks-directory-fix.patch added to -mm tree
Message-Id: <20050525162318.511cdc9b.akpm@osdl.org>
In-Reply-To: <4294F718.8040107@ens-lyon.fr>
References: <200505252249.j4PMnN4q021004@shell0.pdx.osdl.net>
	<4294F718.8040107@ens-lyon.fr>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexandre Buisse <alexandre.buisse@ens-lyon.fr> wrote:
>
> I just noticed that the line 'extern const int
> dlm_lvb_operations[8][8];' had been removed in the inline patch you just
> mailed.

?  I see not such removal.

diff -puN drivers/dlm/lock.c~dlm-lockspaces-callbacks-directory-fix drivers/dlm/lock.c
--- 25/drivers/dlm/lock.c~dlm-lockspaces-callbacks-directory-fix	Wed May 25 15:49:54 2005
+++ 25-akpm/drivers/dlm/lock.c	Wed May 25 15:49:54 2005
@@ -104,6 +104,29 @@ const int __dlm_compat_matrix[8][8] = {
         {0, 0, 0, 0, 0, 0, 0, 0}        /* PD */
 };
 
+/*
+ * This defines the direction of transfer of LVB data.
+ * Granted mode is the row; requested mode is the column.
+ * Usage: matrix[grmode+1][rqmode+1]
+ * 1 = LVB is returned to the caller
+ * 0 = LVB is written to the resource
+ * -1 = nothing happens to the LVB
+ */
+
+
+const int dlm_lvb_operations[8][8] = {
+        /* UN   NL  CR  CW  PR  PW  EX  PD*/
+        {  -1,  1,  1,  1,  1,  1,  1, -1 }, /* UN */
+        {  -1,  1,  1,  1,  1,  1,  1,  0 }, /* NL */
+        {  -1, -1,  1,  1,  1,  1,  1,  0 }, /* CR */
+        {  -1, -1, -1,  1,  1,  1,  1,  0 }, /* CW */
+        {  -1, -1, -1, -1,  1,  1,  1,  0 }, /* PR */
+        {  -1,  0,  0,  0,  0,  0,  1,  0 }, /* PW */
+        {  -1,  0,  0,  0,  0,  0,  0,  0 }, /* EX */
+        {  -1,  0,  0,  0,  0,  0,  0,  0 }  /* PD */
+};
+
+
 #define modes_compat(gr, rq) \
 	__dlm_compat_matrix[(gr)->lkb_grmode + 1][(rq)->lkb_rqmode + 1]
 
diff -puN drivers/dlm/lvb_table.h~dlm-lockspaces-callbacks-directory-fix drivers/dlm/lvb_table.h
--- 25/drivers/dlm/lvb_table.h~dlm-lockspaces-callbacks-directory-fix	Wed May 25 15:49:54 2005
+++ 25-akpm/drivers/dlm/lvb_table.h	Wed May 25 15:49:54 2005
@@ -13,26 +13,4 @@
 #ifndef __LVB_TABLE_DOT_H__
 #define __LVB_TABLE_DOT_H__
 
-/*
- * This defines the direction of transfer of LVB data.
- * Granted mode is the row; requested mode is the column.
- * Usage: matrix[grmode+1][rqmode+1]
- * 1 = LVB is returned to the caller
- * 0 = LVB is written to the resource
- * -1 = nothing happens to the LVB
- */
-
-const int dlm_lvb_operations[8][8] = {
-        /* UN   NL  CR  CW  PR  PW  EX  PD*/
-        {  -1,  1,  1,  1,  1,  1,  1, -1 }, /* UN */
-        {  -1,  1,  1,  1,  1,  1,  1,  0 }, /* NL */
-        {  -1, -1,  1,  1,  1,  1,  1,  0 }, /* CR */
-        {  -1, -1, -1,  1,  1,  1,  1,  0 }, /* CW */
-        {  -1, -1, -1, -1,  1,  1,  1,  0 }, /* PR */
-        {  -1,  0,  0,  0,  0,  0,  1,  0 }, /* PW */
-        {  -1,  0,  0,  0,  0,  0,  0,  0 }, /* EX */
-        {  -1,  0,  0,  0,  0,  0,  0,  0 }  /* PD */
-};
-
 #endif
-
_

