Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262604AbTANMh7>; Tue, 14 Jan 2003 07:37:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262646AbTANMh7>; Tue, 14 Jan 2003 07:37:59 -0500
Received: from mail6.bluewin.ch ([195.186.4.229]:60908 "EHLO mail6.bluewin.ch")
	by vger.kernel.org with ESMTP id <S262604AbTANMh6>;
	Tue, 14 Jan 2003 07:37:58 -0500
Date: Tue, 14 Jan 2003 13:45:55 +0100
From: Roger Luethi <rl@hellgate.ch>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Jeff Garzik <jgarzik@pobox.com>
Subject: [PATCH][2.5] Fix via-rhine using skb_padto
Message-ID: <20030114124555.GA1300@k3.hellgate.ch>
Mail-Followup-To: Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Jeff Garzik <jgarzik@pobox.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="dDRMvlgZJXvWKvBx"
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-Operating-System: Linux 2.5.58 on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--dDRMvlgZJXvWKvBx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

This patch has already made it into 2.4.21pre3-ac4. Please apply.


--dDRMvlgZJXvWKvBx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="via-rhine.c-2.5.58-skb_padto.diff"

--- linux-2.5.58/drivers/net/via-rhine.c.org	Tue Jan 14 00:41:30 2003
+++ linux-2.5.58/drivers/net/via-rhine.c	Tue Jan 14 13:24:14 2003
@@ -1239,6 +1239,12 @@
 	/* Calculate the next Tx descriptor entry. */
 	entry = np->cur_tx % TX_RING_SIZE;
 
+	if (skb->len < ETH_ZLEN) {
+		skb = skb_padto(skb, ETH_ZLEN);
+		if(skb == NULL)
+			return 0;
+	}
+
 	np->tx_skbuff[entry] = skb;
 
 	if ((np->drv_flags & ReqTxAlign) &&

--dDRMvlgZJXvWKvBx--
