Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267453AbTA3JnG>; Thu, 30 Jan 2003 04:43:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267455AbTA3JnG>; Thu, 30 Jan 2003 04:43:06 -0500
Received: from mail5.bluewin.ch ([195.186.1.207]:21901 "EHLO mail5.bluewin.ch")
	by vger.kernel.org with ESMTP id <S267453AbTA3JnF>;
	Thu, 30 Jan 2003 04:43:05 -0500
Date: Thu, 30 Jan 2003 10:52:06 +0100
From: Roger Luethi <rl@hellgate.ch>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH][2.4] etherleak fix for via-rhine
Message-ID: <20030130095206.GA3100@k3.hellgate.ch>
Mail-Followup-To: Marcelo Tosatti <marcelo@conectiva.com.br>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="J2SCkAp4GZ/dPZZf"
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-Operating-System: Linux 2.5.58 on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--J2SCkAp4GZ/dPZZf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Use skb_padto to plug that leak. Patch is already in ac, 2.5. Please apply.


--J2SCkAp4GZ/dPZZf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="via-rhine.c-2.4.21-pre4-skb_padto.diff"

--- linux-2.4.21-pre4/drivers/net/via-rhine.c.org	Thu Jan 30 10:38:32 2003
+++ linux-2.4.21-pre4/drivers/net/via-rhine.c	Thu Jan 30 10:46:57 2003
@@ -1239,6 +1239,12 @@
 	/* Calculate the next Tx descriptor entry. */
 	entry = np->cur_tx % TX_RING_SIZE;
 
+	if (skb->len < ETH_ZLEN) {
+		skb = skb_padto(skb, ETH_ZLEN);
+		if (skb == NULL)
+			return 0;
+	}
+
 	np->tx_skbuff[entry] = skb;
 
 	if ((np->drv_flags & ReqTxAlign) &&

--J2SCkAp4GZ/dPZZf--
