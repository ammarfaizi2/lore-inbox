Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129398AbRB0BYW>; Mon, 26 Feb 2001 20:24:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129402AbRB0BYM>; Mon, 26 Feb 2001 20:24:12 -0500
Received: from 2-113.cwb-adsl.telepar.net.br ([200.193.161.113]:57582 "HELO
	brinquedo.distro.conectiva") by vger.kernel.org with SMTP
	id <S129398AbRB0BYE>; Mon, 26 Feb 2001 20:24:04 -0500
Date: Mon, 26 Feb 2001 20:44:58 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, Mika Kuoppala <miku@iki.fi>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] eth16i.c: don't reference skb after passing it to netif_rx
Message-ID: <20010226204457.F8692@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, Mika Kuoppala <miku@iki.fi>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.14i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

yet another one. 8)

Em Mon, Feb 26, 2001 at 08:33:59PM -0300, Arnaldo Carvalho de Melo escreveu:
Hi,

	I've just read davem's post at netdev about the brokeness of
referencing skbs after passing it to netif_rx, so please consider applying
this patch. Ah, this was just added to the Janitor's TODO list at
http://bazar.conectiva.com.br/~acme/TODO and I'm doing a quick audit in the
net drivers searching for this, maybe some more patches will follow.

- Arnaldo

--- linux-2.4.2/drivers/net/eth16i.c	Tue Feb 13 19:15:05 2001
+++ linux-2.4.2.acme/drivers/net/eth16i.c	Mon Feb 26 22:16:19 2001
@@ -1195,10 +1195,6 @@
 			}
 
 			skb->protocol=eth_type_trans(skb, dev);
-			netif_rx(skb);
-			dev->last_rx = jiffies;
-			lp->stats.rx_packets++;
-			lp->stats.rx_bytes += pkt_len;
 
 			if( eth16i_debug > 5 ) {
 				int i;
@@ -1208,6 +1204,10 @@
 					printk(KERN_DEBUG " %02x", skb->data[i]);
 				printk(KERN_DEBUG ".\n");
 			}
+			netif_rx(skb);
+			dev->last_rx = jiffies;
+			lp->stats.rx_packets++;
+			lp->stats.rx_bytes += pkt_len;
 
 		} /* else */
 
