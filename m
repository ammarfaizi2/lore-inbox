Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129408AbRB0BoJ>; Mon, 26 Feb 2001 20:44:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129417AbRB0Bn5>; Mon, 26 Feb 2001 20:43:57 -0500
Received: from 2-113.cwb-adsl.telepar.net.br ([200.193.161.113]:1007 "HELO
	brinquedo.distro.conectiva") by vger.kernel.org with SMTP
	id <S129408AbRB0Bnr>; Mon, 26 Feb 2001 20:43:47 -0500
Date: Mon, 26 Feb 2001 21:04:41 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, becker@scyld.com,
        linux-kernel@vger.kernel.org
Subject: PATCH] via-rhine.c: don't reference skb after passing it to netif_rx
Message-ID: <20010226210441.K8692@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, becker@scyld.com,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.14i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

humm, almost finishing... 8)

Em Mon, Feb 26, 2001 at 08:33:59PM -0300, Arnaldo Carvalho de Melo escreveu:
Hi,

	I've just read davem's post at netdev about the brokeness of
referencing skbs after passing it to netif_rx, so please consider applying
this patch. Ah, this was just added to the Janitor's TODO list at
http://bazar.conectiva.com.br/~acme/TODO and I'm doing a quick audit in the
net drivers searching for this, maybe some more patches will follow.

- Arnaldo

--- linux-2.4.2/drivers/net/via-rhine.c	Mon Dec 11 19:38:29 2000
+++ linux-2.4.2.acme/drivers/net/via-rhine.c	Mon Feb 26 22:36:18 2001
@@ -1147,9 +1147,9 @@
 								 np->rx_buf_sz, PCI_DMA_FROMDEVICE);
 			}
 			skb->protocol = eth_type_trans(skb, dev);
+			np->stats.rx_bytes += skb->len;
 			netif_rx(skb);
 			dev->last_rx = jiffies;
-			np->stats.rx_bytes += skb->len;
 			np->stats.rx_packets++;
 		}
 		entry = (++np->cur_rx) % RX_RING_SIZE;
