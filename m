Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131137AbRCGSM5>; Wed, 7 Mar 2001 13:12:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131138AbRCGSMs>; Wed, 7 Mar 2001 13:12:48 -0500
Received: from viper.haque.net ([64.0.249.226]:53378 "EHLO mail.haque.net")
	by vger.kernel.org with ESMTP id <S131137AbRCGSMe>;
	Wed, 7 Mar 2001 13:12:34 -0500
Message-ID: <3AA679FD.363E4BCD@haque.net>
Date: Wed, 07 Mar 2001 13:12:13 -0500
From: "Mohammad A. Haque" <mhaque@haque.net>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.4.3-pre3 -- KMALLOC_MAXSIZE & 3c509/3c515 compile fix
Content-Type: multipart/mixed;
 boundary="------------C88F74186E7FD798B95879F9"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------C88F74186E7FD798B95879F9
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit


-- 

=====================================================================
Mohammad A. Haque                              http://www.haque.net/ 
                                               mhaque@haque.net

  "Alcohol and calculus don't mix.             Project Lead
   Don't drink and derive." --Unknown          http://wm.themes.org/
                                               batmanppc@themes.org
=====================================================================
--------------C88F74186E7FD798B95879F9
Content-Type: text/plain; charset=us-ascii;
 name="2.4.x-KMALLOC_MAXSIZE.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="2.4.x-KMALLOC_MAXSIZE.diff"

--- linux/include/linux/slab.h.orig	Wed Mar  7 11:39:26 2001
+++ linux/include/linux/slab.h	Wed Mar  7 11:52:39 2001
@@ -55,6 +55,7 @@
 extern void *kmem_cache_alloc(kmem_cache_t *, int);
 extern void kmem_cache_free(kmem_cache_t *, void *);
 
+#define KMALLOC_MAXSIZE	131072UL	/* Maximum allowed request size */
 extern void *kmalloc(size_t, int);
 extern void kfree(const void *);
 

--------------C88F74186E7FD798B95879F9
Content-Type: text/plain; charset=us-ascii;
 name="2.4.3-p3-3c5xx.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="2.4.3-p3-3c5xx.diff"

--- linux/drivers/net/3c509.c.orig	Wed Mar  7 11:35:27 2001
+++ linux/drivers/net/3c509.c	Wed Mar  7 13:04:57 2001
@@ -327,7 +327,7 @@
 			irq = idev->irq_resource[0].start;
 			if (el3_debug > 3)
 				printk ("ISAPnP reports %s at i/o 0x%x, irq %d\n",
-					el3_isapnp_adapters[i].name, ioaddr, irq);
+					(char *) el3_isapnp_adapters[i].driver_data, ioaddr, irq);
 			EL3WINDOW(0);
 			for (j = 0; j < 3; j++)
 				el3_isapnp_phys_addr[pnp_cards][j] =
--- linux/drivers/net/3c515.c.orig	Wed Mar  7 11:35:27 2001
+++ linux/drivers/net/3c515.c	Wed Mar  7 13:06:42 2001
@@ -474,7 +474,7 @@
 			irq = idev->irq_resource[0].start;
 			if(corkscrew_debug)
 				printk ("ISAPNP reports %s at i/o 0x%x, irq %d\n",
-					corkscrew_isapnp_adapters[i].name,ioaddr, irq);
+					(char *) corkscrew_isapnp_adapters[i].driver_data, ioaddr, irq);
 					
 			if ((inw(ioaddr + 0x2002) & 0x1f0) != (ioaddr & 0x1f0))
 				continue;

--------------C88F74186E7FD798B95879F9--

