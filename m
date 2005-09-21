Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750777AbVIUKvr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750777AbVIUKvr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 06:51:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750810AbVIUKvr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 06:51:47 -0400
Received: from relay02.mail-hub.dodo.com.au ([202.136.32.45]:28809 "EHLO
	relay02.mail-hub.dodo.com.au") by vger.kernel.org with ESMTP
	id S1750777AbVIUKvr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 06:51:47 -0400
From: Grant Coady <grant_lkml@dodo.com.au>
To: dwmw2@infradead.org
Cc: linux-kernel@vger.kernel.org
Subject: [RFC PATCH]DEBUG redefined in drivers/mtd/devices/docecc.c
Date: Wed, 21 Sep 2005 20:51:28 +1000
Organization: http://bugsplatter.mine.nu/
Reply-To: gcoady@gmail.com
Message-ID: <g3e2j1h79samn8v9funobflpgcbr3st1k1@4ax.com>
X-Mailer: Forte Agent 2.0/32.652
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

2.6.14-rc2 allmodconfig on x86:

drivers/mtd/devices/docecc.c:43:1: warning: "DEBUG" redefined
In file included from drivers/mtd/devices/docecc.c:40:
include/linux/mtd/mtd.h:219:1: warning: this is the location of the previous definition
drivers/mtd/devices/docecc.c:43:1: warning: "DEBUG" redefined
In file included from drivers/mtd/devices/docecc.c:40:
include/linux/mtd/mtd.h:219:1: warning: this is the location of the previous definition

the mtd.h version is different to docecc.c version, renaming the 
docecc.c version silences compiler warning.

Cheers,
Grant.


Signed-off-by: Grant Coady <gcoady@gmail.com>

---
 docecc.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

--- linux-2.6.14-rc2/drivers/mtd/devices/docecc.c	2005-08-29 09:41:01.000000000 +1000
+++ linux-2.6.14-rc2a/drivers/mtd/devices/docecc.c	2005-09-21 20:42:27.000000000 +1000
@@ -40,7 +40,7 @@
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/doc2000.h>
 
-#define DEBUG 0
+#define DEBUG_ECC 0
 /* need to undef it (from asm/termbits.h) */
 #undef B0
 
@@ -249,7 +249,7 @@ eras_dec_rs(dtype Alpha_to[NN + 1], dtyp
 	  lambda[j] ^= Alpha_to[modnn(u + tmp)];
       }
     }
-#if DEBUG >= 1
+#if DEBUG_ECC >= 1
     /* Test code that verifies the erasure locator polynomial just constructed
        Needed only for decoder debugging. */
     
@@ -276,7 +276,7 @@ eras_dec_rs(dtype Alpha_to[NN + 1], dtyp
       count = -1;
       goto finish;
     }
-#if DEBUG >= 2
+#if DEBUG_ECC >= 2
     printf("\n Erasure positions as determined by roots of Eras Loc Poly:\n");
     for (i = 0; i < count; i++)
       printf("%d ", loc[i]);
@@ -409,7 +409,7 @@ eras_dec_rs(dtype Alpha_to[NN + 1], dtyp
 	den ^= Alpha_to[modnn(lambda[i+1] + i * root[j])];
     }
     if (den == 0) {
-#if DEBUG >= 1
+#if DEBUG_ECC >= 1
       printf("\n ERROR: denominator = 0\n");
 #endif
       /* Convert to dual- basis */
