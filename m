Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267084AbSLEA1w>; Wed, 4 Dec 2002 19:27:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267119AbSLEA1w>; Wed, 4 Dec 2002 19:27:52 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:36370 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S267084AbSLEA1u>;
	Wed, 4 Dec 2002 19:27:50 -0500
Message-ID: <3DEE9F2C.5090607@pobox.com>
Date: Wed, 04 Dec 2002 19:34:52 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [BK PATCH] add __exit_p to complement __devexit_p
Content-Type: multipart/mixed;
 boundary="------------090002070307030607040206"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090002070307030607040206
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Full GNU patch attached after description for easy review

--------------090002070307030607040206
Content-Type: text/plain;
 name="exitp-2.5.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="exitp-2.5.txt"

Linus, please do a

	bk pull bk://kernel.bkbits.net/jgarzik/exitp-2.5

This will update the following files:

 drivers/net/tulip/de2104x.c |    3 +--
 include/linux/init.h        |   13 ++++++++++++-
 2 files changed, 13 insertions(+), 3 deletions(-)

through these ChangeSets:

<wli@holomorphy.com> (02/12/02 1.797.1.172)
   Add __exit_p() to match existing __devexit_p().
   
   This patch fixes de2104x net driver up by doing the following things:
   (1) add __exit_p() to <linux/init.h>
   (2) add the unused attributed to __exit routines for non-modules
   (3) use __exit_p() to refer to de_remove_one()


--------------090002070307030607040206
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

# --------------------------------------------
# 02/12/02	wli@holomorphy.com	1.797.1.172
# Add __exit_p() to match existing __devexit_p().
# 
# This patch fixes de2104x net driver up by doing the following things:
# (1) add __exit_p() to <linux/init.h>
# (2) add the unused attributed to __exit routines for non-modules
# (3) use __exit_p() to refer to de_remove_one()
# --------------------------------------------
#
diff -Nru a/drivers/net/tulip/de2104x.c b/drivers/net/tulip/de2104x.c
--- a/drivers/net/tulip/de2104x.c	Wed Dec  4 19:31:56 2002
+++ b/drivers/net/tulip/de2104x.c	Wed Dec  4 19:31:56 2002
@@ -2217,8 +2217,7 @@
 	.name		= DRV_NAME,
 	.id_table	= de_pci_tbl,
 	.probe		= de_init_one,
-#warning only here to fix build.  should be __exit_p not __devexit_p.
-	.remove		= __devexit_p(de_remove_one),
+	.remove		= __exit_p(de_remove_one),
 #ifdef CONFIG_PM
 	.suspend	= de_suspend,
 	.resume		= de_resume,
diff -Nru a/include/linux/init.h b/include/linux/init.h
--- a/include/linux/init.h	Wed Dec  4 19:31:56 2002
+++ b/include/linux/init.h	Wed Dec  4 19:31:56 2002
@@ -42,10 +42,15 @@
    discard it in modules) */
 #define __init		__attribute__ ((__section__ (".init.text")))
 #define __initdata	__attribute__ ((__section__ (".init.data")))
-#define __exit		__attribute__ ((__section__(".exit.text")))
 #define __exitdata	__attribute__ ((__section__(".exit.data")))
 #define __exit_call	__attribute__ ((unused,__section__ (".exitcall.exit")))
 
+#ifdef MODULE
+#define __exit		__attribute__ ((__section__(".exit.text")))
+#else
+#define __exit		__attribute__ ((unused,__section__(".exit.text")))
+#endif
+
 /* For assembly routines */
 #define __INIT		.section	".init.text","ax"
 #define __FINIT		.previous
@@ -183,6 +188,12 @@
 #define __devexit_p(x) x
 #else
 #define __devexit_p(x) NULL
+#endif
+
+#ifdef MODULE
+#define __exit_p(x) x
+#else
+#define __exit_p(x) NULL
 #endif
 
 #endif /* _LINUX_INIT_H */

--------------090002070307030607040206--

