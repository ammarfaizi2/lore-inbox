Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318184AbSHZRkT>; Mon, 26 Aug 2002 13:40:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318188AbSHZRkT>; Mon, 26 Aug 2002 13:40:19 -0400
Received: from pD9E2394F.dip.t-dialin.net ([217.226.57.79]:12466 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S318184AbSHZRkS>; Mon, 26 Aug 2002 13:40:18 -0400
From: Lightweight Patch Manager <patch@luckynet.dynu.com>
To: Linus Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH][2.5] macro madness for Linux 2.5.31
X-Mailer: Lightweight Patch Manager
Message-ID: <20020826174430.A02677@hawkeye.luckynet.adm>
MIME-Version: 1.0
User-Agent: Lightweight Patch Manager/1.04
Date: Mon, 26 Aug 2002 17:44:30 +0000
X-Priority: I really don't care.
Content-Type: text/plain; charset=US-ASCII
Organization: Lightweight Networking
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch reduces  macro madness with old compilers  that didn't know
that one  can even  write the comma  directly after  the __FUNCTION__,
like I did in this sentence. Can you parse it? If no, you'll need this
patch either.

diff -Nurp -x SCCS -x CVS -x .deps -x ChangeSet -x BitKeeper linus-2.5/arch/arm/mach-sa1100/system3.c thunder-2.5/arch/arm/mach-sa1100/system3.c
--- linus-2.5/arch/arm/mach-sa1100/system3.c	Sat Aug 24 04:50:21 2002
+++ thunder-2.5/arch/arm/mach-sa1100/system3.c	Mon Aug 26 11:35:32 2002
@@ -62,7 +62,7 @@
 #define DEBUG 1
 
 #ifdef DEBUG
-#	define DPRINTK( x, args... )	printk( "%s: line %d: "x, __FUNCTION__, __LINE__, ## args  );
+#	define DPRINTK( x, args... )	printk( "%s: line %d: " x, __FUNCTION__ , __LINE__ , ## args );
 #else
 #	define DPRINTK( x, args... )	/* nix */
 #endif
diff -Nurp -x SCCS -x CVS -x .deps -x ChangeSet -x BitKeeper linus-2.5/drivers/ieee1394/sbp2.c thunder-2.5/drivers/ieee1394/sbp2.c
--- linus-2.5/drivers/ieee1394/sbp2.c	Sat Aug 24 04:52:05 2002
+++ thunder-2.5/drivers/ieee1394/sbp2.c	Mon Aug 26 11:37:04 2002
@@ -449,7 +449,7 @@ MODULE_DEVICE_TABLE(ieee1394, sbp2_id_ta
 /* #define CONFIG_IEEE1394_SBP2_PACKET_DUMP */
 
 #ifdef CONFIG_IEEE1394_SBP2_DEBUG_ORBS
-#define SBP2_ORB_DEBUG(fmt, args...)	HPSB_ERR("sbp2(%s): "fmt, __FUNCTION__, ## args)
+#define SBP2_ORB_DEBUG(fmt, args...)	HPSB_ERR("sbp2(%s): " fmt, __FUNCTION__ , ## args)
 static u32 global_outstanding_command_orbs = 0;
 #define outstanding_orb_incr global_outstanding_command_orbs++
 #define outstanding_orb_decr global_outstanding_command_orbs--
diff -Nurp -x SCCS -x CVS -x .deps -x ChangeSet -x BitKeeper linus-2.5/drivers/pcmcia/sa1100_system3.c thunder-2.5/drivers/pcmcia/sa1100_system3.c
--- linus-2.5/drivers/pcmcia/sa1100_system3.c	Sat Aug 24 04:52:54 2002
+++ thunder-2.5/drivers/pcmcia/sa1100_system3.c	Mon Aug 26 11:37:39 2002
@@ -40,7 +40,7 @@
 #define DEBUG 0
 
 #ifdef DEBUG
-#	define DPRINTK( x, args... )	printk( "%s: line %d: "x, __FUNCTION__, __LINE__, ## args  );
+#	define DPRINTK( x, args... )	printk( "%s: line %d: " x, __FUNCTION__ , __LINE__ , ## args  );
 #else
 #	define DPRINTK( x, args... )	/* nix */
 #endif
diff -Nurp -x SCCS -x CVS -x .deps -x ChangeSet -x BitKeeper linus-2.5/drivers/video/aty128fb.c thunder-2.5/drivers/video/aty128fb.c
--- linus-2.5/drivers/video/aty128fb.c	Sat Aug 24 04:53:33 2002
+++ thunder-2.5/drivers/video/aty128fb.c	Mon Aug 26 11:36:03 2002
@@ -87,7 +87,7 @@
 #undef DEBUG
 
 #ifdef DEBUG
-#define DBG(fmt, args...)		printk(KERN_DEBUG "aty128fb: %s " fmt, __FUNCTION__, ##args);
+#define DBG(fmt, args...)		printk(KERN_DEBUG "aty128fb: %s " fmt, __FUNCTION__ , ##args);
 #else
 #define DBG(fmt, args...)
 #endif

-- 
Lightweight Patch Manager, without pine.
If you have any objections (apart from who I am), tell me

