Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129562AbRB0EXz>; Mon, 26 Feb 2001 23:23:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129565AbRB0EXq>; Mon, 26 Feb 2001 23:23:46 -0500
Received: from 2-113.cwb-adsl.telepar.net.br ([200.193.161.113]:3312 "HELO
	brinquedo.distro.conectiva") by vger.kernel.org with SMTP
	id <S129562AbRB0EX2>; Mon, 26 Feb 2001 23:23:28 -0500
Date: Mon, 26 Feb 2001 23:44:10 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] sealevel: update last_rx after netif_rx
Message-ID: <20010226234410.K8692@conectiva.com.br>
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

--- linux-2.4.2/drivers/net/wan/sealevel.c	Sun Aug 13 18:57:35 2000
+++ linux-2.4.2.acme/drivers/net/wan/sealevel.c	Tue Feb 27 01:07:31 2001
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
+	c->netdevice->last_rx = jiffies;
 }
  
 /*
