Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262766AbTCTWiL>; Thu, 20 Mar 2003 17:38:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263011AbTCTWhA>; Thu, 20 Mar 2003 17:37:00 -0500
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:51329 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id <S262704AbTCTWYk>; Thu, 20 Mar 2003 17:24:40 -0500
Date: Thu, 20 Mar 2003 23:35:42 +0100
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: linux-kernel@vger.kernel.org
Cc: netdev@oss.sgi.com, acme@conectiva.com.br
Subject: Re: [PATCH] clean up net/802/Makefile (large version)
Message-ID: <20030320223542.GC13641@wohnheim.fh-wedel.de>
References: <20030320223329.GB13641@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030320223329.GB13641@wohnheim.fh-wedel.de>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This one tries to clean up the other code as well.

Jörn

-- 
The cheapest, fastest and most reliable components of a computer
system are those that aren't there.
-- Gordon Bell, DEC labratories

--- linux-2.4.20/net/802/Makefile	Sat Aug  3 02:39:46 2002
+++ linux-2.4.20/net/802/Makefile.2	Thu Mar 20 23:26:22 2003
@@ -11,48 +11,26 @@
 
 export-objs = llc_macinit.o p8022.o psnap.o
 
+snap-objs = p8022.o psnap.o
+
 obj-y	= p8023.o
 
 obj-$(CONFIG_SYSCTL) += sysctl_net_802.o
-obj-$(CONFIG_LLC) += llc_sendpdu.o llc_utility.o cl2llc.o llc_macinit.o
-ifeq ($(CONFIG_SYSCTL),y)
-obj-y += sysctl_net_802.o
-endif
-
-ifeq ($(CONFIG_LLC),y)
-subdir-y += transit
-obj-y += llc_sendpdu.o llc_utility.o cl2llc.o llc_macinit.o
-SNAP = y
-endif
-
-ifdef CONFIG_TR
-obj-y += tr.o
-	SNAP=y
-endif
-
-ifdef CONFIG_NET_FC
-obj-y += fc.o
-endif
-
-ifdef CONFIG_FDDI
-obj-y += fddi.o
-endif
-
-ifdef CONFIG_HIPPI
-obj-y += hippi.o
-endif
-
-ifdef CONFIG_IPX
-	SNAP=y
-endif
-
-ifdef CONFIG_ATALK
-	SNAP=y
-endif
-
-ifeq ($(SNAP),y)
-obj-y += p8022.o psnap.o
-endif
+obj-$(CONFIG_LLC) += llc_sendpdu.o llc_utility.o cl2llc.o llc_macinit.o $(snap-objs)
+
+subdir-$(CONFIG_LLC) += transit
+
+obj-$(CONFIG_TR) += tr.o $(snap-objs)
+
+obj-$(CONFIG_NET_FC) += fc.o
+
+obj-$(CONFIG_FDDI) += fddi.o
+
+obj-$(CONFIG_HIPPI) += hippi.o
+
+obj-$(CONFIG_IPX) += $(snap-objs)
+
+obj-$(CONFIG_ATALK) += $(snap-objs)
 
 include $(TOPDIR)/Rules.make
 
