Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129524AbRB0Cz2>; Mon, 26 Feb 2001 21:55:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129525AbRB0CzS>; Mon, 26 Feb 2001 21:55:18 -0500
Received: from 2-113.cwb-adsl.telepar.net.br ([200.193.161.113]:34543 "HELO
	brinquedo.distro.conectiva") by vger.kernel.org with SMTP
	id <S129524AbRB0CzI>; Mon, 26 Feb 2001 21:55:08 -0500
Date: Mon, 26 Feb 2001 22:16:02 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] hostess_sv11: update last_rx after netif_rx
Message-ID: <20010226221602.Y8692@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
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

--- linux-2.4.2/drivers/net/wan/hostess_sv11.c	Sun Aug 13 18:57:35 2000
+++ linux-2.4.2.acme/drivers/net/wan/hostess_sv11.c	Mon Feb 26 23:48:32 2001
@@ -59,7 +59,7 @@
 {
 	/* Drop the CRC - its not a good idea to try and negotiate it ;) */
 	skb_trim(skb, skb->len-2);
-	skb->protocol=htons(ETH_P_WAN_PPP);
+	skb->protocol=__constant_htons(ETH_P_WAN_PPP);
 	skb->mac.raw=skb->data;
 	skb->dev=c->netdevice;
 	/*
@@ -67,6 +67,7 @@
 	 *	it right now.
 	 */
 	netif_rx(skb);
+	c->netdevice.last_rx = jiffies;
 }
  
 /*
