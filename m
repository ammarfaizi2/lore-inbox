Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264569AbTF0Rot (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jun 2003 13:44:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264590AbTF0Rot
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jun 2003 13:44:49 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:23016 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S264569AbTF0Rop (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jun 2003 13:44:45 -0400
Date: Fri, 27 Jun 2003 19:58:53 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: lkml <linux-kernel@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [2.4 patch] some gcc 3.3 fixes from -ac
Message-ID: <20030627175853.GJ24661@fs.tum.de>
References: <Pine.LNX.4.55L.0306261858460.10651@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.55L.0306261858460.10651@freak.distro.conectiva>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo,

the patch below contains four trivial fixes for compile failures with 
gcc 3.3 stolen from -ac.

I've tested the compilation with 2.4.22-pre2.

diffstat output:

 drivers/net/irda/ma600.c     |    6 +++---
 drivers/net/wan/sdla_chdlc.c |    3 +--
 drivers/sound/cs46xx.c       |    4 ++--
 net/decnet/dn_table.c        |    3 +--
 4 files changed, 7 insertions(+), 9 deletions(-)


Please apply
Adrian


--- linux.vanilla/drivers/net/irda/ma600.c	2002-11-29 21:27:18.000000000 +0000
+++ linux.21-ac3/drivers/net/irda/ma600.c	2003-05-29 01:40:07.000000000 +0100
@@ -51,9 +51,9 @@
 	#undef ASSERT(expr, func)
 	#define ASSERT(expr, func) \
 	if(!(expr)) { \
-	        printk( "Assertion failed! %s,%s,%s,line=%d\n",\
-        	#expr,__FILE__,__FUNCTION__,__LINE__); \
-	        ##func}
+		printk( "Assertion failed! %s,%s,%s,line=%d\n",\
+		#expr,__FILE__,__FUNCTION__,__LINE__); \
+		func}
 #endif
 
 /* convert hex value to ascii hex */
--- linux.vanilla/drivers/net/wan/sdla_chdlc.c	2002-11-29 21:27:18.000000000 +0000
+++ linux.21-ac3/drivers/net/wan/sdla_chdlc.c	2003-05-28 15:35:56.000000000 +0100
@@ -591,8 +591,7 @@
 	
 
 		if (chdlc_set_intr_mode(card, APP_INT_ON_TIMER)){
-			printk (KERN_INFO "%s: 
-				Failed to set interrupt triggers!\n",
+			printk (KERN_INFO "%s: Failed to set interrupt triggers!\n",
 				card->devname);
 			return -EIO;	
         	}
--- linux.vanilla/drivers/sound/cs46xx.c	2003-06-14 00:11:37.000000000 +0100
+++ linux.21-ac3/drivers/sound/cs46xx.c	2003-06-22 13:36:11.000000000 +0100
@@ -947,8 +950,8 @@
 
 struct InitStruct
 {
-    u32 long off;
-    u32 long val;
+    u32 off;
+    u32 val;
 } InitArray[] = { {0x00000040, 0x3fc0000f},
                   {0x0000004c, 0x04800000},
 
--- linux.vanilla/net/decnet/dn_table.c	2001-12-21 17:42:05.000000000 +0000
+++ linux.21-ac3/net/decnet/dn_table.c	2003-05-28 15:37:27.000000000 +0100
@@ -836,8 +836,7 @@
                 return NULL;
 
         if (in_interrupt() && net_ratelimit()) {
-                printk(KERN_DEBUG "DECnet: BUG! Attempt to create routing table 
-from interrupt\n"); 
+                printk(KERN_DEBUG "DECnet: BUG! Attempt to create routing table from interrupt\n"); 
                 return NULL;
         }
         if ((t = kmalloc(sizeof(struct dn_fib_table), GFP_KERNEL)) == NULL)
