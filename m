Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129511AbRB0Cv1>; Mon, 26 Feb 2001 21:51:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129524AbRB0CvS>; Mon, 26 Feb 2001 21:51:18 -0500
Received: from 2-113.cwb-adsl.telepar.net.br ([200.193.161.113]:32495 "HELO
	brinquedo.distro.conectiva") by vger.kernel.org with SMTP
	id <S129511AbRB0Cu5>; Mon, 26 Feb 2001 21:50:57 -0500
Date: Mon, 26 Feb 2001 22:11:51 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, Mike McLagan <mike.mclagan@linux.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] dlci: update last_rx after netif_rx
Message-ID: <20010226221151.X8692@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Mike McLagan <mike.mclagan@linux.org>, linux-kernel@vger.kernel.org
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

--- linux-2.4.2/drivers/net/wan/dlci.c	Tue Feb 13 19:15:05 2001
+++ linux-2.4.2.acme/drivers/net/wan/dlci.c	Mon Feb 26 23:43:25 2001
@@ -205,7 +205,7 @@
 
 			case FRAD_P_IP:
 				header = sizeof(hdr->control) + sizeof(hdr->IP_NLPID);
-				skb->protocol = htons(ETH_P_IP);
+				skb->protocol = __constant_htons(ETH_P_IP);
 				process = 1;
 				break;
 
@@ -229,6 +229,7 @@
 		skb_pull(skb, header);
 		netif_rx(skb);
 		dlp->stats.rx_packets++;
+		dev->last_rx = jiffies;
 	}
 	else
 		dev_kfree_skb(skb);
