Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135318AbRAFXgF>; Sat, 6 Jan 2001 18:36:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135290AbRAFXf4>; Sat, 6 Jan 2001 18:35:56 -0500
Received: from brutus.conectiva.com.br ([200.250.58.146]:59896 "HELO
	brinquedo.distro.conectiva") by vger.kernel.org with SMTP
	id <S135293AbRAFXfQ>; Sat, 6 Jan 2001 18:35:16 -0500
Date: Sat, 6 Jan 2001 21:35:08 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] bagetlance using freed skb
Message-ID: <20010106213508.R736@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan,

	Paul Gortmaker found a similar one for lance, so I'm looking at
some other drivers to see if this happens, bagetlance has it as well,
here is the patch.

	- Arnaldo

--- linux-2.4.0-ac2/drivers/net/bagetlance.c	Tue Dec 19 11:25:40 2000
+++ linux-2.4.0-ac2.acme/drivers/net/bagetlance.c	Sat Jan  6 21:27:50 2001
@@ -930,9 +930,9 @@
 #else
     SET_FLAG(head,(TMD1_OWN_CHIP | TMD1_ENP | TMD1_STP));
 #endif
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
