Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129428AbRB0Bg4>; Mon, 26 Feb 2001 20:36:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129408AbRB0Bgr>; Mon, 26 Feb 2001 20:36:47 -0500
Received: from 2-113.cwb-adsl.telepar.net.br ([200.193.161.113]:63470 "HELO
	brinquedo.distro.conectiva") by vger.kernel.org with SMTP
	id <S129428AbRB0Bgi>; Mon, 26 Feb 2001 20:36:38 -0500
Date: Mon, 26 Feb 2001 20:57:32 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, Jaroslav Kysela <perex@suse.cz>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] hp100.c: don't reference skb after passing it to netif_rx
Message-ID: <20010226205732.J8692@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Jaroslav Kysela <perex@suse.cz>, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.14i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hey, its a flood! 8)

Em Mon, Feb 26, 2001 at 08:33:59PM -0300, Arnaldo Carvalho de Melo escreveu:
Hi,

	I've just read davem's post at netdev about the brokeness of
referencing skbs after passing it to netif_rx, so please consider applying
this patch. Ah, this was just added to the Janitor's TODO list at
http://bazar.conectiva.com.br/~acme/TODO and I'm doing a quick audit in the
net drivers searching for this, maybe some more patches will follow.

- Arnaldo

--- linux-2.4.2/drivers/net/hp100.c	Tue Feb 13 19:15:05 2001
+++ linux-2.4.2.acme/drivers/net/hp100.c	Mon Feb 26 22:30:32 2001
@@ -1967,11 +1967,6 @@
 	    insl( ioaddr + HP100_REG_DATA32, ptr, pkt_len >> 2 );
       
 	  skb->protocol = eth_type_trans( skb, dev );
-
-	  netif_rx( skb );
-	  dev->last_rx = jiffies;
-	  lp->stats.rx_packets++;
-	  lp->stats.rx_bytes += pkt_len;
       
 #ifdef HP100_DEBUG_RX
 	  printk( "hp100: %s: rx: %02x %02x %02x %02x %02x %02x %02x %02x %02x %02x %02x %02x\n",
@@ -1979,6 +1974,10 @@
 		  ptr[ 0 ], ptr[ 1 ], ptr[ 2 ], ptr[ 3 ], ptr[ 4 ], ptr[ 5 ],
 		  ptr[ 6 ], ptr[ 7 ], ptr[ 8 ], ptr[ 9 ], ptr[ 10 ], ptr[ 11 ] );
 #endif
+	  netif_rx( skb );
+	  dev->last_rx = jiffies;
+	  lp->stats.rx_packets++;
+	  lp->stats.rx_bytes += pkt_len;
 	}
   
       /* Indicate the card that we have got the packet */
