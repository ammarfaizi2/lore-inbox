Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135254AbRAGAkB>; Sat, 6 Jan 2001 19:40:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135287AbRAGAjw>; Sat, 6 Jan 2001 19:39:52 -0500
Received: from brutus.conectiva.com.br ([200.250.58.146]:62204 "HELO
	brinquedo.distro.conectiva") by vger.kernel.org with SMTP
	id <S135254AbRAGAji>; Sat, 6 Jan 2001 19:39:38 -0500
Date: Sat, 6 Jan 2001 22:39:30 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] atarilance using freed skb
Message-ID: <20010106223930.T736@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
In-Reply-To: <20010106213508.R736@conectiva.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010106213508.R736@conectiva.com.br>; from acme@conectiva.com.br on Sat, Jan 06, 2001 at 09:35:08PM -0200
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sat, Jan 06, 2001 at 09:35:08PM -0200, Arnaldo Carvalho de Melo escreveu:
> Alan,
> 
> 	Paul Gortmaker found a similar one for lance, so I'm looking at
> some other drivers to see if this happens, bagetlance has it as well,
> here is the patch.

Another one:

--- linux-2.4.0-ac2/drivers/net/atarilance.c	Mon Jan  1 14:42:28 2001
+++ linux-2.4.0-ac2.acme/drivers/net/atarilance.c	Sat Jan  6 22:36:23 2001
@@ -820,9 +820,9 @@
 	head->misc = 0;
 	lp->memcpy_f( PKTBUF_ADDR(head), (void *)skb->data, skb->len );
 	head->flag = TMD1_OWN_CHIP | TMD1_ENP | TMD1_STP;
+	lp->stats.tx_bytes += skb->len;
 	dev_kfree_skb( skb );
 	lp->cur_tx++;
-	lp->stats.tx_bytes += skb->len;
 	while( lp->cur_tx >= TX_RING_SIZE && lp->dirty_tx >= TX_RING_SIZE ) {
 		lp->cur_tx -= TX_RING_SIZE;
 		lp->dirty_tx -= TX_RING_SIZE;
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
