Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129758AbQKPKSd>; Thu, 16 Nov 2000 05:18:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129875AbQKPKSY>; Thu, 16 Nov 2000 05:18:24 -0500
Received: from finch-post-11.mail.demon.net ([194.217.242.39]:62737 "EHLO
	finch-post-11.mail.demon.net") by vger.kernel.org with ESMTP
	id <S129758AbQKPKSL>; Thu, 16 Nov 2000 05:18:11 -0500
Date: Thu, 16 Nov 2000 09:46:53 +0000
To: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Small tidyup patch to drivers/net/Space.c
Message-ID: <20001116094652.A9861@alfie.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
From: Nick.Holloway@pyrites.org.uk (Nick Holloway)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A tidyup patch I've been meaning to do for a while.  Following the move
of dev->name from char* to char[], the need for padding of the strings
when initialising dev->name is no longer required.

Patch is against 2.4.0-test10.  The patch is only required to remove a
potential source of confusion from the source.

--- linux-2.4/drivers/net/Space.c~	Thu Nov 16 08:49:43 2000
+++ linux-2.4/drivers/net/Space.c	Thu Nov 16 09:41:17 2000
@@ -459,14 +459,6 @@
 #endif
 
 
-/* Pad device name to IFNAMSIZ=16. F.e. __PAD6 is string of 9 zeros. */
-#define __PAD6 "\0\0\0\0\0\0\0\0\0"
-#define __PAD5 __PAD6 "\0"
-#define __PAD4 __PAD5 "\0"
-#define __PAD3 __PAD4 "\0"
-#define __PAD2 __PAD3 "\0"
-
-
 #ifdef CONFIG_NET_FC
 static int fcif_probe(struct net_device *dev)
 {
@@ -486,14 +478,14 @@
 
 
 #ifdef CONFIG_ETHERTAP
-    static struct net_device tap0_dev = { "tap0" __PAD4, 0, 0, 0, 0, NETLINK_TAPBASE, 0, 0, 0, 0, NEXT_DEV, ethertap_probe, };
+    static struct net_device tap0_dev = { "tap0", 0, 0, 0, 0, NETLINK_TAPBASE, 0, 0, 0, 0, NEXT_DEV, ethertap_probe, };
 #   undef NEXT_DEV
 #   define NEXT_DEV	(&tap0_dev)
 #endif
 
 #ifdef CONFIG_SDLA
     extern int sdla_init(struct net_device *);
-    static struct net_device sdla0_dev = { "sdla0" __PAD5, 0, 0, 0, 0, 0, 0, 0, 0, 0, NEXT_DEV, sdla_init, };
+    static struct net_device sdla0_dev = { "sdla0", 0, 0, 0, 0, 0, 0, 0, 0, 0, NEXT_DEV, sdla_init, };
 
 #   undef NEXT_DEV
 #   define NEXT_DEV	(&sdla0_dev)
@@ -502,7 +494,7 @@
 #if defined(CONFIG_LTPC)
     extern int ltpc_probe(struct net_device *);
     static struct net_device dev_ltpc = {
-        "lt0" __PAD3,
+        "lt0",
                 0, 0, 0, 0,
                 0x0, 0,
                 0, 0, 0, NEXT_DEV, ltpc_probe };
@@ -512,9 +504,9 @@
 
 #if defined(CONFIG_COPS)
     extern int cops_probe(struct net_device *);
-    static struct net_device cops2_dev = { "lt2" __PAD3, 0, 0, 0, 0, 0x0, 0, 0, 0, 0, NEXT_DEV, cops_probe };
-    static struct net_device cops1_dev = { "lt1" __PAD3, 0, 0, 0, 0, 0x0, 0, 0, 0, 0, &cops2_dev, cops_probe };
-    static struct net_device cops0_dev = { "lt0" __PAD3, 0, 0, 0, 0, 0x0, 0, 0, 0, 0, &cops1_dev, cops_probe };
+    static struct net_device cops2_dev = { "lt2", 0, 0, 0, 0, 0x0, 0, 0, 0, 0, NEXT_DEV, cops_probe };
+    static struct net_device cops1_dev = { "lt1", 0, 0, 0, 0, 0x0, 0, 0, 0, 0, &cops2_dev, cops_probe };
+    static struct net_device cops0_dev = { "lt0", 0, 0, 0, 0, 0x0, 0, 0, 0, 0, &cops1_dev, cops_probe };
 #   undef NEXT_DEV
 #   define NEXT_DEV     (&cops0_dev)
 #endif  /* COPS */
@@ -535,22 +527,22 @@
 #define ETH_NOPROBE_ADDR 0xffe0
 
 static struct net_device eth7_dev = {
-    "eth%d" __PAD5, 0,0,0,0,ETH_NOPROBE_ADDR /* I/O base*/, 0,0,0,0, NEXT_DEV, ethif_probe };
+    "eth%d", 0,0,0,0,ETH_NOPROBE_ADDR /* I/O base*/, 0,0,0,0, NEXT_DEV, ethif_probe };
 static struct net_device eth6_dev = {
-    "eth%d" __PAD5, 0,0,0,0,ETH_NOPROBE_ADDR /* I/O base*/, 0,0,0,0, &eth7_dev, ethif_probe };
+    "eth%d", 0,0,0,0,ETH_NOPROBE_ADDR /* I/O base*/, 0,0,0,0, &eth7_dev, ethif_probe };
 static struct net_device eth5_dev = {
-    "eth%d" __PAD5, 0,0,0,0,ETH_NOPROBE_ADDR /* I/O base*/, 0,0,0,0, &eth6_dev, ethif_probe };
+    "eth%d", 0,0,0,0,ETH_NOPROBE_ADDR /* I/O base*/, 0,0,0,0, &eth6_dev, ethif_probe };
 static struct net_device eth4_dev = {
-    "eth%d" __PAD5, 0,0,0,0,ETH_NOPROBE_ADDR /* I/O base*/, 0,0,0,0, &eth5_dev, ethif_probe };
+    "eth%d", 0,0,0,0,ETH_NOPROBE_ADDR /* I/O base*/, 0,0,0,0, &eth5_dev, ethif_probe };
 static struct net_device eth3_dev = {
-    "eth%d" __PAD5, 0,0,0,0,ETH_NOPROBE_ADDR /* I/O base*/, 0,0,0,0, &eth4_dev, ethif_probe };
+    "eth%d", 0,0,0,0,ETH_NOPROBE_ADDR /* I/O base*/, 0,0,0,0, &eth4_dev, ethif_probe };
 static struct net_device eth2_dev = {
-    "eth%d" __PAD5, 0,0,0,0,ETH_NOPROBE_ADDR /* I/O base*/, 0,0,0,0, &eth3_dev, ethif_probe };
+    "eth%d", 0,0,0,0,ETH_NOPROBE_ADDR /* I/O base*/, 0,0,0,0, &eth3_dev, ethif_probe };
 static struct net_device eth1_dev = {
-    "eth%d" __PAD5, 0,0,0,0,ETH_NOPROBE_ADDR /* I/O base*/, 0,0,0,0, &eth2_dev, ethif_probe };
+    "eth%d", 0,0,0,0,ETH_NOPROBE_ADDR /* I/O base*/, 0,0,0,0, &eth2_dev, ethif_probe };
 
 static struct net_device eth0_dev = {
-    "eth%d" __PAD5, 0, 0, 0, 0, ETH0_ADDR, ETH0_IRQ, 0, 0, 0, &eth1_dev, ethif_probe };
+    "eth%d", 0, 0, 0, 0, ETH0_ADDR, ETH0_IRQ, 0, 0, 0, &eth1_dev, ethif_probe };
 
 #   undef NEXT_DEV
 #   define NEXT_DEV	(&eth0_dev)
@@ -582,21 +574,21 @@
     return 0;
 }
 static struct net_device tr7_dev = {
-    "tr%d" __PAD3,0,0,0,0,0,0,0,0,0, NEXT_DEV, trif_probe };
+    "tr%d",0,0,0,0,0,0,0,0,0, NEXT_DEV, trif_probe };
 static struct net_device tr6_dev = {
-    "tr%d" __PAD3,0,0,0,0,0,0,0,0,0, &tr7_dev, trif_probe };
+    "tr%d",0,0,0,0,0,0,0,0,0, &tr7_dev, trif_probe };
 static struct net_device tr5_dev = {
-    "tr%d" __PAD3,0,0,0,0,0,0,0,0,0, &tr6_dev, trif_probe };
+    "tr%d",0,0,0,0,0,0,0,0,0, &tr6_dev, trif_probe };
 static struct net_device tr4_dev = {
-    "tr%d" __PAD3,0,0,0,0,0,0,0,0,0, &tr5_dev, trif_probe };
+    "tr%d",0,0,0,0,0,0,0,0,0, &tr5_dev, trif_probe };
 static struct net_device tr3_dev = {
-    "tr%d" __PAD3,0,0,0,0,0,0,0,0,0, &tr4_dev, trif_probe };
+    "tr%d",0,0,0,0,0,0,0,0,0, &tr4_dev, trif_probe };
 static struct net_device tr2_dev = {
-    "tr%d" __PAD3,0,0,0,0,0,0,0,0,0, &tr3_dev, trif_probe };
+    "tr%d",0,0,0,0,0,0,0,0,0, &tr3_dev, trif_probe };
 static struct net_device tr1_dev = {
-    "tr%d" __PAD3,0,0,0,0,0,0,0,0,0, &tr2_dev, trif_probe };
+    "tr%d",0,0,0,0,0,0,0,0,0, &tr2_dev, trif_probe };
 static struct net_device tr0_dev = {
-    "tr%d" __PAD3,0,0,0,0,0,0,0,0,0, &tr1_dev, trif_probe };
+    "tr%d",0,0,0,0,0,0,0,0,0, &tr1_dev, trif_probe };
 #   undef       NEXT_DEV
 #   define      NEXT_DEV        (&tr0_dev)
 
@@ -604,21 +596,21 @@
 
 #ifdef CONFIG_FDDI
 	static struct net_device fddi7_dev =
-		{"fddi7" __PAD5, 0, 0, 0, 0, 0, 0, 0, 0, 0, NEXT_DEV, fddiif_probe};
+		{"fddi7", 0, 0, 0, 0, 0, 0, 0, 0, 0, NEXT_DEV, fddiif_probe};
 	static struct net_device fddi6_dev =
-		{"fddi6" __PAD5, 0, 0, 0, 0, 0, 0, 0, 0, 0, &fddi7_dev, fddiif_probe};
+		{"fddi6", 0, 0, 0, 0, 0, 0, 0, 0, 0, &fddi7_dev, fddiif_probe};
 	static struct net_device fddi5_dev =
-		{"fddi5" __PAD5, 0, 0, 0, 0, 0, 0, 0, 0, 0, &fddi6_dev, fddiif_probe};
+		{"fddi5", 0, 0, 0, 0, 0, 0, 0, 0, 0, &fddi6_dev, fddiif_probe};
 	static struct net_device fddi4_dev =
-		{"fddi4" __PAD5, 0, 0, 0, 0, 0, 0, 0, 0, 0, &fddi5_dev, fddiif_probe};
+		{"fddi4", 0, 0, 0, 0, 0, 0, 0, 0, 0, &fddi5_dev, fddiif_probe};
 	static struct net_device fddi3_dev =
-		{"fddi3" __PAD5, 0, 0, 0, 0, 0, 0, 0, 0, 0, &fddi4_dev, fddiif_probe};
+		{"fddi3", 0, 0, 0, 0, 0, 0, 0, 0, 0, &fddi4_dev, fddiif_probe};
 	static struct net_device fddi2_dev =
-		{"fddi2" __PAD5, 0, 0, 0, 0, 0, 0, 0, 0, 0, &fddi3_dev, fddiif_probe};
+		{"fddi2", 0, 0, 0, 0, 0, 0, 0, 0, 0, &fddi3_dev, fddiif_probe};
 	static struct net_device fddi1_dev =
-		{"fddi1" __PAD5, 0, 0, 0, 0, 0, 0, 0, 0, 0, &fddi2_dev, fddiif_probe};
+		{"fddi1", 0, 0, 0, 0, 0, 0, 0, 0, 0, &fddi2_dev, fddiif_probe};
 	static struct net_device fddi0_dev =
-		{"fddi0" __PAD5, 0, 0, 0, 0, 0, 0, 0, 0, 0, &fddi1_dev, fddiif_probe};
+		{"fddi0", 0, 0, 0, 0, 0, 0, 0, 0, 0, &fddi1_dev, fddiif_probe};
 #undef	NEXT_DEV
 #define	NEXT_DEV	(&fddi0_dev)
 #endif 

-- 
 `O O'  | Nick.Holloway@pyrites.org.uk
// ^ \\ | http://www.pyrites.org.uk/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
