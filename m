Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262309AbUJ0GQr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262309AbUJ0GQr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 02:16:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261698AbUJ0GOk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 02:14:40 -0400
Received: from pimout3-ext.prodigy.net ([207.115.63.102]:42403 "EHLO
	pimout3-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S262215AbUJ0GKQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 02:10:16 -0400
Date: Tue, 26 Oct 2004 23:09:18 -0700
To: LKML <linux-kernel@vger.kernel.org>
Cc: Chris Wedgwood <cw@taniwha.stupidest.org>,
       David Woodhouse <dwmw2@infradead.org>
Subject: [RFC] Rename SECTOR_SIZE to DOC_SECTOR_SIZE
Message-ID: <20041027060918.GD32396@taniwha.stupidest.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
From: cw@f00f.org (Chris Wedgwood)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The token SECTOR_SIZE is used in multiple places that have (almost)
the same defintion everywhere.

How do people feel about rename this vague token?



===== drivers/mtd/devices/docecc.c 1.7 vs edited =====
--- 1.7/drivers/mtd/devices/docecc.c	2003-05-28 08:01:02 -07:00
+++ edited/drivers/mtd/devices/docecc.c	2004-10-26 17:10:26 -07:00
@@ -431,9 +431,9 @@ eras_dec_rs(dtype Alpha_to[NN + 1], dtyp
 /***************************************************************************/
 /* The DOC specific code begins here */
 
-#define SECTOR_SIZE 512
+#define DOC_SECTOR_SIZE 512
 /* The sector bytes are packed into NB_DATA MM bits words */
-#define NB_DATA (((SECTOR_SIZE + 1) * 8 + 6) / MM)
+#define NB_DATA (((DOC_SECTOR_SIZE + 1) * 8 + 6) / MM)
 
 /* 
  * Correct the errors in 'sector[]' by using 'ecc1[]' which is the
@@ -441,7 +441,7 @@ eras_dec_rs(dtype Alpha_to[NN + 1], dtyp
  * the ECC. Return the number of errors corrected (and correct them in
  * sector), or -1 if error 
  */
-int doc_decode_ecc(unsigned char sector[SECTOR_SIZE], unsigned char ecc1[6])
+int doc_decode_ecc(unsigned char sector[DOC_SECTOR_SIZE], unsigned char ecc1[6])
 {
     int parity, i, nb_errors;
     gf bb[NN - KK + 1];
@@ -488,22 +488,22 @@ int doc_decode_ecc(unsigned char sector[
                can be modified since pos is even */
             index = (pos >> 3) ^ 1;
             bitpos = pos & 7;
-            if ((index >= 0 && index < SECTOR_SIZE) || 
-                index == (SECTOR_SIZE + 1)) {
+            if ((index >= 0 && index < DOC_SECTOR_SIZE) || 
+                index == (DOC_SECTOR_SIZE + 1)) {
                 val = error_val[i] >> (2 + bitpos);
                 parity ^= val;
-                if (index < SECTOR_SIZE)
+                if (index < DOC_SECTOR_SIZE)
                     sector[index] ^= val;
             }
             index = ((pos >> 3) + 1) ^ 1;
             bitpos = (bitpos + 10) & 7;
             if (bitpos == 0)
                 bitpos = 8;
-            if ((index >= 0 && index < SECTOR_SIZE) || 
-                index == (SECTOR_SIZE + 1)) {
+            if ((index >= 0 && index < DOC_SECTOR_SIZE) || 
+                index == (DOC_SECTOR_SIZE + 1)) {
                 val = error_val[i] << (8 - bitpos);
                 parity ^= val;
-                if (index < SECTOR_SIZE)
+                if (index < DOC_SECTOR_SIZE)
                     sector[index] ^= val;
             }
         }
===== drivers/mtd/nand/diskonchip.c 1.6 vs edited =====
--- 1.6/drivers/mtd/nand/diskonchip.c	2004-10-20 16:34:39 -07:00
+++ edited/drivers/mtd/nand/diskonchip.c	2004-10-26 17:10:26 -07:00
@@ -128,9 +128,9 @@ MODULE_PARM_DESC(doc_config_location, "P
 
 
 /* Sector size for HW ECC */
-#define SECTOR_SIZE 512
+#define DOC_SECTOR_SIZE 512
 /* The sector bytes are packed into NB_DATA 10 bit words */
-#define NB_DATA (((SECTOR_SIZE + 1) * 8 + 6) / 10)
+#define NB_DATA (((DOC_SECTOR_SIZE + 1) * 8 + 6) / 10)
 /* Number of roots */
 #define NROOTS 4
 /* First consective root */
@@ -208,22 +208,22 @@ static int doc_ecc_decode (struct rs_con
 			   can be modified since pos is even */
 			index = (pos >> 3) ^ 1;
 			bitpos = pos & 7;
-			if ((index >= 0 && index < SECTOR_SIZE) || 
-			    index == (SECTOR_SIZE + 1)) {
+			if ((index >= 0 && index < DOC_SECTOR_SIZE) || 
+			    index == (DOC_SECTOR_SIZE + 1)) {
 				val = (uint8_t) (errval[i] >> (2 + bitpos));
 				parity ^= val;
-				if (index < SECTOR_SIZE)
+				if (index < DOC_SECTOR_SIZE)
 					data[index] ^= val;
 			}
 			index = ((pos >> 3) + 1) ^ 1;
 			bitpos = (bitpos + 10) & 7;
 			if (bitpos == 0)
 				bitpos = 8;
-			if ((index >= 0 && index < SECTOR_SIZE) || 
-			    index == (SECTOR_SIZE + 1)) {
+			if ((index >= 0 && index < DOC_SECTOR_SIZE) || 
+			    index == (DOC_SECTOR_SIZE + 1)) {
 				val = (uint8_t)(errval[i] << (8 - bitpos));
 				parity ^= val;
-				if (index < SECTOR_SIZE)
+				if (index < DOC_SECTOR_SIZE)
 					data[index] ^= val;
 			}
 		}
