Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263346AbVCKO4h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263346AbVCKO4h (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 09:56:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263348AbVCKO4g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 09:56:36 -0500
Received: from khc.piap.pl ([195.187.100.11]:2820 "EHLO khc.piap.pl")
	by vger.kernel.org with ESMTP id S263346AbVCKO4A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 09:56:00 -0500
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.11.2
References: <20050309083923.GA20461@kroah.com>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Fri, 11 Mar 2005 15:53:53 +0100
In-Reply-To: <20050309083923.GA20461@kroah.com> (Greg KH's message of "Wed,
 9 Mar 2005 00:39:23 -0800")
Message-ID: <m3acpa9qta.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=

Hi,

Another patch for 2.6.11.x: already in main tree, fixes kernel panic
on receive with WAN cards based on Hitachi SCA/SCA-II: N2, C101,
PCI200SYN.
Also a documentation change fixing user-panic can-t-find-required-software
failure (just the same patch as in mainline) :-)

Please apply, thanks.
-- 
Krzysztof Halasa

--=-=-=
Content-Type: text/x-patch
Content-Disposition: inline; filename=hdlc-skb-dev.patch

--- linux/drivers/net/wan/hd6457x.c	28 Oct 2004 06:16:08 -0000	1.15
+++ linux/drivers/net/wan/hd6457x.c	1 Mar 2005 00:58:08 -0000
@@ -315,7 +315,7 @@
 #endif
 	stats->rx_packets++;
 	stats->rx_bytes += skb->len;
-	skb->dev->last_rx = jiffies;
+	dev->last_rx = jiffies;
 	skb->protocol = hdlc_type_trans(skb, dev);
 	netif_rx(skb);
 }
--- linux/drivers/net/wan/Kconfig	15 Jan 2005 23:46:55 -0000	1.25
+++ linux/drivers/net/wan/Kconfig	1 Mar 2005 00:58:08 -0000
@@ -155,7 +155,8 @@
 	  Network) card supported by this driver and you are planning to
 	  connect the box to a WAN.
 
-	  You will need supporting software from <http://hq.pm.waw.pl/hdlc/>.
+	  You will need supporting software from
+	  <http://www.kernel.org/pub/linux/utils/net/hdlc/>.
 	  Generic HDLC driver currently supports raw HDLC, Cisco HDLC, Frame
 	  Relay, synchronous Point-to-Point Protocol (PPP) and X.25.
 
@@ -225,7 +226,7 @@
 	  Driver for PCI200SYN cards by Goramo sp. j.
 
 	  If you have such a card, say Y here and see
-	  <http://hq.pm.waw.pl/hdlc/>.
+	  <http://www.kernel.org/pub/linux/utils/net/hdlc/>.
 
 	  To compile this as a module, choose M here: the
 	  module will be called pci200syn.
@@ -239,7 +240,7 @@
 	  Driver for wanXL PCI cards by SBE Inc.
 
 	  If you have such a card, say Y here and see
-	  <http://hq.pm.waw.pl/hdlc/>.
+	  <http://www.kernel.org/pub/linux/utils/net/hdlc/>.
 
 	  To compile this as a module, choose M here: the
 	  module will be called wanxl.
@@ -292,7 +293,7 @@
 	  SDL Communications Inc.
 
 	  If you have such a card, say Y here and see
-	  <http://hq.pm.waw.pl/hdlc/>.
+	  <http://www.kernel.org/pub/linux/utils/net/hdlc/>.
 
 	  Note that N2csu and N2dds cards are not supported by this driver.
 
@@ -308,7 +309,7 @@
 	  Driver for C101 SuperSync ISA cards by Moxa Technologies Co., Ltd.
 
 	  If you have such a card, say Y here and see
-	  <http://hq.pm.waw.pl/pub/hdlc/>
+	  <http://www.kernel.org/pub/linux/utils/net/hdlc/>.
 
 	  To compile this driver as a module, choose M here: the
 	  module will be called c101.
--- linux/MAINTAINERS	26 Jan 2005 16:47:14 -0000	1.332
+++ linux/MAINTAINERS	1 Mar 2005 00:58:08 -0000
@@ -910,10 +910,10 @@
 W:	http://www.icp-vortex.com/
 S:	Supported
 
-GENERIC HDLC DRIVER, N2 AND C101 DRIVERS
+GENERIC HDLC DRIVER, N2, C101, PCI200SYN and WANXL DRIVERS
 P:	Krzysztof Halasa
 M:	khc@pm.waw.pl
-W:	http://hq.pm.waw.pl/hdlc/
+W:	http://www.kernel.org/pub/linux/utils/net/hdlc/
 S:	Maintained
 
 HAYES ESP SERIAL DRIVER

--=-=-=--
