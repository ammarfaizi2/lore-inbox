Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129389AbRB0BSc>; Mon, 26 Feb 2001 20:18:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129402AbRB0BSW>; Mon, 26 Feb 2001 20:18:22 -0500
Received: from 2-113.cwb-adsl.telepar.net.br ([200.193.161.113]:55022 "HELO
	brinquedo.distro.conectiva") by vger.kernel.org with SMTP
	id <S129397AbRB0BSO>; Mon, 26 Feb 2001 20:18:14 -0500
Date: Mon, 26 Feb 2001 20:39:08 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, stefani@lkg.dec.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH] defxx.c: don't reference skb after passing it to netif_rx
Message-ID: <20010226203908.E8692@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, stefani@lkg.dec.com,
	linux-kernel@vger.kernel.org
In-Reply-To: <20010226203359.D8692@conectiva.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.14i
In-Reply-To: <20010226203359.D8692@conectiva.com.br>; from acme@conectiva.com.br on Mon, Feb 26, 2001 at 08:33:59PM -0300
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

one more.

Em Mon, Feb 26, 2001 at 08:33:59PM -0300, Arnaldo Carvalho de Melo escreveu:
Hi,

	I've just read davem's post at netdev about the brokeness of
referencing skbs after passing it to netif_rx, so please consider applying
this patch. Ah, this was just added to the Janitor's TODO list at
http://bazar.conectiva.com.br/~acme/TODO and I'm doing a quick audit in the
net drivers searching for this, maybe some more patches will follow.

- Arnaldo

--- linux-2.4.2/drivers/net/defxx.c	Tue Feb 13 19:15:05 2001
+++ linux-2.4.2.acme/drivers/net/defxx.c	Mon Feb 26 22:09:29 2001
@@ -2858,6 +2858,7 @@
 					skb->dev = bp->dev;		/* pass up device pointer */
 
 					skb->protocol = fddi_type_trans(skb, bp->dev);
+					bp->rcv_total_bytes += skb->len;
 					netif_rx(skb);
 
 					/* Update the rcv counters */
@@ -2865,8 +2866,6 @@
 					bp->rcv_total_frames++;
 					if (*(p_buff + RCV_BUFF_K_DA) & 0x01)
 						bp->rcv_multicast_frames++;
-				 
-					bp->rcv_total_bytes += skb->len;
 				}
 			}
 			}
