Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129460AbRB0B7a>; Mon, 26 Feb 2001 20:59:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129458AbRB0B7Q>; Mon, 26 Feb 2001 20:59:16 -0500
Received: from mail3.atl.bellsouth.net ([205.152.0.38]:61622 "EHLO
	mail3.atl.bellsouth.net") by vger.kernel.org with ESMTP
	id <S129446AbRB0B64>; Mon, 26 Feb 2001 20:58:56 -0500
Message-ID: <3A9B0991.F34AF284@mandrakesoft.com>
Date: Mon, 26 Feb 2001 20:57:37 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, shingo@flab.fujitsu.co.jp,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fmvj18x_cs: don't reference skb after passing it to netif_rx
In-Reply-To: <20010226211403.N8692@conectiva.com.br>
Content-Type: multipart/mixed;
 boundary="------------C7DB0BF7082135058F1EC68F"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------C7DB0BF7082135058F1EC68F
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Ditto...
-- 
Jeff Garzik       | "You see, in this world there's two kinds of
Building 1024     |  people, my friend: Those with loaded guns
MandrakeSoft      |  and those who dig. You dig."  --Blondie
--------------C7DB0BF7082135058F1EC68F
Content-Type: text/plain; charset=us-ascii;
 name="fmv.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fmv.patch"

Index: drivers/net/pcmcia/fmvj18x_cs.c
===================================================================
RCS file: /cvsroot/gkernel/linux_2_4/drivers/net/pcmcia/fmvj18x_cs.c,v
retrieving revision 1.1.1.14.2.2
diff -u -r1.1.1.14.2.2 fmvj18x_cs.c
--- drivers/net/pcmcia/fmvj18x_cs.c	2001/02/23 03:37:00	1.1.1.14.2.2
+++ drivers/net/pcmcia/fmvj18x_cs.c	2001/02/27 01:57:16
@@ -1080,8 +1080,9 @@
 #endif
 
 	    netif_rx(skb);
+	    dev->last_rx = jiffies;
 	    lp->stats.rx_packets++;
-	    lp->stats.rx_bytes += skb->len;
+	    lp->stats.rx_bytes += pkt_len;
 	}
 	if (--boguscount <= 0)
 	    break;

--------------C7DB0BF7082135058F1EC68F--

