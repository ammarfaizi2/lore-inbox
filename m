Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262626AbRE3Fqb>; Wed, 30 May 2001 01:46:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262616AbRE3FqV>; Wed, 30 May 2001 01:46:21 -0400
Received: from [203.143.19.4] ([203.143.19.4]:47890 "EHLO kitul.learn.ac.lk")
	by vger.kernel.org with ESMTP id <S262615AbRE3FqO>;
	Wed, 30 May 2001 01:46:14 -0400
Date: Wed, 30 May 2001 01:06:25 +0600 (LKT)
From: Anuradha Ratnaweera <anuradha@gnu.org>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] compiler warning fixes in 8139too.c
Message-ID: <Pine.LNX.4.21.0105300102280.424-100000@presario>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The following patch fixes some warnings when 8139 driver is compiled
without 8129 support.

Regards,

Anuradha

----------------------------------
http://www.bee.lk/people/anuradha/


diff -rua linux-2.4.5/drivers/net/8139too.c linux/drivers/net/8139too.c
--- linux-2.4.5/drivers/net/8139too.c	Tue May 29 23:41:48 2001
+++ linux/drivers/net/8139too.c	Wed May 30 01:00:21 2001
@@ -1150,6 +1150,7 @@
 	0
 };
 
+#ifdef CONFIG_8139TOO_8129
 
 /* Syncronize the MII management interface by shifting 32 one bits out. */
 static void mdio_sync (void *mdio_addr)
@@ -1168,14 +1169,18 @@
 	DPRINTK ("EXIT\n");
 }
 
+#endif
 
 static int mdio_read (struct net_device *dev, int phy_id, int location)
 {
 	struct rtl8139_private *tp = dev->priv;
+	int retval = 0;
+
+#ifdef CONFIG_8139TOO_8129
 	void *mdio_addr = tp->mmio_addr + Config4;
 	int mii_cmd = (0xf6 << 10) | (phy_id << 5) | location;
-	int retval = 0;
 	int i;
+#endif
 
 	DPRINTK ("ENTER\n");
 
@@ -1216,9 +1221,12 @@
 			int value)
 {
 	struct rtl8139_private *tp = dev->priv;
+
+#ifdef CONFIG_8139TOO_8129
 	void *mdio_addr = tp->mmio_addr + Config4;
 	int mii_cmd = (0x5002 << 16) | (phy_id << 23) | (location << 18) | value;
 	int i;
+#endif
 
 	DPRINTK ("ENTER\n");
 

