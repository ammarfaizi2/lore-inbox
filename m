Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262898AbVCQAAV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262898AbVCQAAV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 19:00:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262895AbVCPX7Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 18:59:24 -0500
Received: from fire.osdl.org ([65.172.181.4]:63378 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262885AbVCPX5G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 18:57:06 -0500
Date: Wed, 16 Mar 2005 15:55:53 -0800
From: Chris Wright <chrisw@osdl.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: khc@pm.waw.pl, jgarzik@pobox.com, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, jmforbes@linuxtx.org, zwane@arm.linux.org.uk,
       cliffw@osdl.org, tytso@mit.edu, rddunlap@osdl.org
Subject: [9/9] Fix kernel panic on receive with WAN Hitachi SCA HD6457x
Message-ID: <20050316235553.GH5389@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050316235336.GY5389@shell0.pdx.osdl.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

----

From: Krzysztof Halasa <khc@pm.waw.pl>

Another patch for 2.6.11.x: already in main tree, fixes kernel panic on
receive with WAN cards based on Hitachi SCA/SCA-II: N2, C101, PCI200SYN.
The attached patch fixes NULL pointer dereference on RX.

Signed-off-by: Krzysztof Halasa <khc@pm.waw.pl>
Acked-by: Jeff Garzik <jgarzik@pobox.com>
Signed-off-by: Chris Wright <chrisw@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

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


