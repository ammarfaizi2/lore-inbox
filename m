Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129409AbRB0Bu3>; Mon, 26 Feb 2001 20:50:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129417AbRB0BuT>; Mon, 26 Feb 2001 20:50:19 -0500
Received: from 2-113.cwb-adsl.telepar.net.br ([200.193.161.113]:4079 "HELO
	brinquedo.distro.conectiva") by vger.kernel.org with SMTP
	id <S129409AbRB0BuE>; Mon, 26 Feb 2001 20:50:04 -0500
Date: Mon, 26 Feb 2001 21:10:58 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, dahinds@users.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: [PATCH] 3c589_cs: don't reference skb after passing it to netif_rx
Message-ID: <20010226211058.M8692@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, dahinds@users.sourceforge.net,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.14i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

now to pcmcia ones

Em Mon, Feb 26, 2001 at 08:33:59PM -0300, Arnaldo Carvalho de Melo escreveu:
Hi,

	I've just read davem's post at netdev about the brokeness of
referencing skbs after passing it to netif_rx, so please consider applying
this patch. Ah, this was just added to the Janitor's TODO list at
http://bazar.conectiva.com.br/~acme/TODO and I'm doing a quick audit in the
net drivers searching for this, maybe some more patches will follow.

- Arnaldo

--- linux-2.4.2/drivers/net/pcmcia/3c589_cs.c	Tue Feb 13 19:15:05 2001
+++ linux-2.4.2.acme/drivers/net/pcmcia/3c589_cs.c	Mon Feb 26 22:44:00 2001
@@ -992,9 +992,9 @@
 			(pkt_len+3)>>2);
 		skb->protocol = eth_type_trans(skb, dev);
 		
+		lp->stats.rx_bytes += skb->len;
 		netif_rx(skb);
 		lp->stats.rx_packets++;
-		lp->stats.rx_bytes += skb->len;
 	    } else {
 		DEBUG(1, "%s: couldn't allocate a sk_buff of"
 		      " size %d.\n", dev->name, pkt_len);
