Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129509AbRB0Cpr>; Mon, 26 Feb 2001 21:45:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129511AbRB0Cp2>; Mon, 26 Feb 2001 21:45:28 -0500
Received: from 2-113.cwb-adsl.telepar.net.br ([200.193.161.113]:30191 "HELO
	brinquedo.distro.conectiva") by vger.kernel.org with SMTP
	id <S129509AbRB0Cp1>; Mon, 26 Feb 2001 21:45:27 -0500
Date: Mon, 26 Feb 2001 22:06:20 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] cycx_x25: update last_rx after netif_rx
Message-ID: <20010226220620.W8692@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.14i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Feb 26, 2001 at 09:58:31PM -0300, Arnaldo Carvalho de Melo escreveu:
Hi,

	Please apply. This one I maintain. 8)

- Arnaldo

--- linux-2.4.2/drivers/net/wan/cycx_x25.c	Tue Feb 13 19:15:05 2001
+++ linux-2.4.2.acme/drivers/net/wan/cycx_x25.c	Mon Feb 26 23:38:48 2001
@@ -812,7 +812,6 @@
 	if (bitm)
 		return; /* more data is coming */
 
-	dev->last_rx = jiffies;		/* timestamp */
 	chan->rx_skb = NULL;		/* dequeue packet */
 
 	++chan->ifstats.rx_packets;
@@ -820,6 +819,7 @@
 
 	skb->mac.raw = skb->data;
 	netif_rx(skb);
+	dev->last_rx = jiffies;		/* timestamp */
 }
 
 /* Connect interrupt handler. */
@@ -1454,11 +1454,12 @@
         *ptr = event;
 
         skb->dev = dev;
-        skb->protocol = htons(ETH_P_X25);
+        skb->protocol = __constant_htons(ETH_P_X25);
         skb->mac.raw = skb->data;
         skb->pkt_type = PACKET_HOST;
 
         netif_rx(skb);
+	dev->last_rx = jiffies;		/* timestamp */
 }
 
 /* Convert line speed in bps to a number used by cyclom 2x code. */
