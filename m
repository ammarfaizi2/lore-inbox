Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130205AbQLPWiM>; Sat, 16 Dec 2000 17:38:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130117AbQLPWiB>; Sat, 16 Dec 2000 17:38:01 -0500
Received: from 213.237.12.194.adsl.brh.worldonline.dk ([213.237.12.194]:38742
	"HELO firewall.jaquet.dk") by vger.kernel.org with SMTP
	id <S130309AbQLPWho>; Sat, 16 Dec 2000 17:37:44 -0500
Date: Sat, 16 Dec 2000 23:07:01 +0100
From: Rasmus Andersen <rasmus@jaquet.dk>
To: dwmw2@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] link time error in drivers/mtd (240t13p2)
Message-ID: <20001216230701.E609@jaquet.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

Various files in drivers/mtd references cfi_probe (by way of do_cfi_probe).
This function is static and thus not shared. The following patch removes
the static declaration but if it is What Was Intended I do not know. It
makes the kernel link, however.


--- linux-240-t13-pre2-clean/drivers/mtd/cfi_probe.c	Wed Nov 22 22:41:39 2000
+++ linux/drivers/mtd/cfi_probe.c	Sat Dec 16 22:58:57 2000
@@ -17,7 +17,7 @@
 #include <linux/mtd/cfi.h>
 
 
-static struct mtd_info *cfi_probe(struct map_info *);
+struct mtd_info *cfi_probe(struct map_info *);
 
 static void print_cfi_ident(struct cfi_ident *);
 static void check_cmd_set(struct map_info *, int, unsigned long);
@@ -32,7 +32,7 @@
  * this module is non-zero, i.e. between inter_module_get and
  * inter_module_put.  Keith Owens <kaos@ocs.com.au> 29 Oct 2000.
  */
-static struct mtd_info *cfi_probe(struct map_info *map)
+struct mtd_info *cfi_probe(struct map_info *map)
 {
 	struct mtd_info *mtd = NULL;
 	struct cfi_private *cfi;

-- 
        Rasmus(rasmus@jaquet.dk)

The Holocaust was an obscene period in our nation's history. I mean
in this century's history. But we all lived in this century. I didn't
live in this century.
                -- Senator Dan Quayle, 9/15/88
                   (reported in Esquire, 8/92, The New Yorker, 10/10/88, p.102)
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
