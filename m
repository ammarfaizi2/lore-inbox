Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129501AbRB0Ch4>; Mon, 26 Feb 2001 21:37:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129509AbRB0Chq>; Mon, 26 Feb 2001 21:37:46 -0500
Received: from 2-113.cwb-adsl.telepar.net.br ([200.193.161.113]:27119 "HELO
	brinquedo.distro.conectiva") by vger.kernel.org with SMTP
	id <S129501AbRB0Chh>; Mon, 26 Feb 2001 21:37:37 -0500
Date: Mon, 26 Feb 2001 21:58:31 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, Jan "Yenya" Kasprzak <kas@fi.muni.cz>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] cosa: update last_rx after netif_rx
Message-ID: <20010226215831.V8692@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Jan "Yenya" Kasprzak <kas@fi.muni.cz>, linux-kernel@vger.kernel.org
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

--- linux-2.4.2/drivers/net/wan/cosa.c	Tue Feb 13 19:15:05 2001
+++ linux-2.4.2.acme/drivers/net/wan/cosa.c	Mon Feb 26 23:28:40 2001
@@ -738,14 +738,14 @@
 		chan->stats.rx_frame_errors++;
 		return 0;
 	}
-	chan->rx_skb->protocol = htons(ETH_P_WAN_PPP);
+	chan->rx_skb->protocol = __constant_htons(ETH_P_WAN_PPP);
 	chan->rx_skb->dev = chan->pppdev.dev;
 	chan->rx_skb->mac.raw = chan->rx_skb->data;
 	chan->stats.rx_packets++;
 	chan->stats.rx_bytes += chan->cosa->rxsize;
 	netif_rx(chan->rx_skb);
 	chan->rx_skb = 0;
-	chan->pppdev.dev->trans_start = jiffies;
+	chan->pppdev.dev->last_rx = jiffies;
 	return 0;
 }
 
