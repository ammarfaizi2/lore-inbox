Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129496AbRB0Cbe>; Mon, 26 Feb 2001 21:31:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129491AbRB0CbY>; Mon, 26 Feb 2001 21:31:24 -0500
Received: from 2-113.cwb-adsl.telepar.net.br ([200.193.161.113]:24559 "HELO
	brinquedo.distro.conectiva") by vger.kernel.org with SMTP
	id <S129486AbRB0CbN>; Mon, 26 Feb 2001 21:31:13 -0500
Date: Mon, 26 Feb 2001 21:52:07 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, Gergely Madarasz <gorgo@itc.hu>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] comx-proto-lapb: update last_rx after netif_rx
Message-ID: <20010226215206.U8692@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Gergely Madarasz <gorgo@itc.hu>, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.14i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

	Please consider applying.

- Arnaldo

--- linux-2.4.2/drivers/net/wan/comx-proto-lapb.c	Sun Nov 12 01:02:39 2000
+++ linux-2.4.2.acme/drivers/net/wan/comx-proto-lapb.c	Mon Feb 26 23:23:15 2001
@@ -306,11 +306,12 @@
 		p = skb_put(skb,1);
 		*p = 0x01;		// link established
 		skb->dev = ch->dev;
-		skb->protocol = htons(ETH_P_X25);
+		skb->protocol = __constant_htons(ETH_P_X25);
 		skb->mac.raw = skb->data;
 		skb->pkt_type = PACKET_HOST;
 
 		netif_rx(skb);
+		ch->dev->last_rx = jiffies;
 	}
 
 	for (; comxdir; comxdir = comxdir->next) {
@@ -345,11 +346,12 @@
 		p = skb_put(skb,1);
 		*p = 0x02;		// link disconnected
 		skb->dev = ch->dev;
-		skb->protocol = htons(ETH_P_X25);
+		skb->protocol = __constant_htons(ETH_P_X25);
 		skb->mac.raw = skb->data;
 		skb->pkt_type = PACKET_HOST;
 
 		netif_rx(skb);
+		ch->dev->last_rx = jiffies;
 	}
 
 	for (; comxdir; comxdir = comxdir->next) {
