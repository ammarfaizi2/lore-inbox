Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129388AbRB0BNl>; Mon, 26 Feb 2001 20:13:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129389AbRB0BNV>; Mon, 26 Feb 2001 20:13:21 -0500
Received: from 2-113.cwb-adsl.telepar.net.br ([200.193.161.113]:52206 "HELO
	brinquedo.distro.conectiva") by vger.kernel.org with SMTP
	id <S129388AbRB0BNR>; Mon, 26 Feb 2001 20:13:17 -0500
Date: Mon, 26 Feb 2001 20:33:59 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, davies@maniac.ultranet.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] de4x5.c: don't reference skb after passing it to netif_rx
Message-ID: <20010226203359.D8692@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, davies@maniac.ultranet.com,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.14i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

	I've just read davem's post at netdev about the brokeness of
referencing skbs after passing it to netif_rx, so please consider applying
this patch. Ah, this was just added to the Janitor's TODO list at
http://bazar.conectiva.com.br/~acme/TODO and I'm doing a quick audit in the
net drivers searching for this, maybe some more patches will follow.

- Arnaldo

--- linux-2.4.2/drivers/net/de4x5.c	Fri Feb  9 17:40:02 2001
+++ linux-2.4.2.acme/drivers/net/de4x5.c	Mon Feb 26 22:02:50 2001
@@ -1731,13 +1731,13 @@
 
 		    /* Push up the protocol stack */
 		    skb->protocol=eth_type_trans(skb,dev);
+		    de4x5_local_stats(dev, skb->data, pkt_len);
 		    netif_rx(skb);
 		    
 		    /* Update stats */
 		    dev->last_rx = jiffies;
 		    lp->stats.rx_packets++;
  		    lp->stats.rx_bytes += pkt_len;
-		    de4x5_local_stats(dev, skb->data, pkt_len);
 		}
 	    }
 	    
