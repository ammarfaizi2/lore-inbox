Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132901AbQLHVUn>; Fri, 8 Dec 2000 16:20:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132818AbQLHVUd>; Fri, 8 Dec 2000 16:20:33 -0500
Received: from 213.237.12.194.adsl.brh.worldonline.dk ([213.237.12.194]:55917
	"HELO firewall.jaquet.dk") by vger.kernel.org with SMTP
	id <S132901AbQLHVUZ>; Fri, 8 Dec 2000 16:20:25 -0500
Date: Fri, 8 Dec 2000 21:49:52 +0100
From: Rasmus Andersen <rasmus@jaquet.dk>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] remove warning from drivers/net/rclanmtl.c
Message-ID: <20001208214952.I599@jaquet.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

(Does anyone know the maintainer of this code?)

When compiling drivers/net/rclanmtl.c (240t12p3) I get a warning about
incompatible pointer assignment. As far as I can tell it has appeared
because PU32 has been changed to __u32* since test9 (where it was an
unsigned long*). The following patch fixes this by changing the
offending lvalue to a PU32 instead of an unsigned long*, which is
my unqualified guess at a fix.


--- linux-240-t12-pre3-clean/drivers/net/rclanmtl.c	Sat Nov  4 23:27:08 2000
+++ linux/drivers/net/rclanmtl.c	Fri Dec  1 22:36:49 2000
@@ -1561,7 +1561,7 @@
 RCResetLANCard(U16 AdapterID, U16 ResourceFlags, PU32 ReturnAddr, PFNCALLBACK CallbackFunction)
 {
     unsigned long off;
-    unsigned long *pMsg;
+    PU32 pMsg;
     PPAB pPab;
     int i;
     long timeout = 0;

-- 
        Rasmus(rasmus@jaquet.dk)

"There are also enough rocks on Earth to kill the world's population several
times over."
	-- Lt. General Daniel Graham, DIA, explaining why it's necessary to
	   have more than enough nukes
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
