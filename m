Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261391AbVEYWhW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261391AbVEYWhW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 May 2005 18:37:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261415AbVEYWhV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 May 2005 18:37:21 -0400
Received: from postfix3-1.free.fr ([213.228.0.44]:55204 "EHLO
	postfix3-1.free.fr") by vger.kernel.org with ESMTP id S261391AbVEYWhG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 May 2005 18:37:06 -0400
Message-ID: <4294EFFD.3000607@ens-lyon.fr>
Date: Wed, 25 May 2005 23:37:01 +0200
From: Alexandre Buisse <alexandre.buisse@ens-lyon.fr>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050417)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-rc5-mm1
References: <20050525134933.5c22234a.akpm@osdl.org>
In-Reply-To: <20050525134933.5c22234a.akpm@osdl.org>
X-Enigmail-Version: 0.90.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------050100020107030309010102"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050100020107030309010102
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.12-rc5/2.6.12-rc5-mm1/

Hi Andrew,

missing extern in drivers/dlm/lvb_table.h.
The definition was moved into drivers/dlm/lock.c.
The attached patch fixes this.


Signed-off-by: Alexandre Buisse <Alexandre.Buisse@ens-lyon.fr>

Regards,
Alexandre

--------------050100020107030309010102
Content-Type: text/x-patch;
 name="fix-dlm-extern-lvb_table.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fix-dlm-extern-lvb_table.patch"

--- linux-2.6.12-rc5-mm1/drivers/dlm/lock.c.old	2005-05-25 23:30:10.000000000 +0200
+++ linux-2.6.12-rc5-mm1/drivers/dlm/lock.c	2005-05-25 23:30:21.000000000 +0200
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
 
--- linux-2.6.12-rc5-mm1/drivers/dlm/lvb_table.h.old	2005-05-25 23:30:34.000000000 +0200
+++ linux-2.6.12-rc5-mm1/drivers/dlm/lvb_table.h	2005-05-25 23:32:35.000000000 +0200
@@ -13,26 +13,7 @@
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
-extern const int dlm_lvb_operations[8][8] = {
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
+extern const int dlm_lvb_operations[8][8];
 
 #endif
 

--------------050100020107030309010102--
