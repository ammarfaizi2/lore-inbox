Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266941AbSKPAJz>; Fri, 15 Nov 2002 19:09:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266948AbSKPAJz>; Fri, 15 Nov 2002 19:09:55 -0500
Received: from eriador.apana.org.au ([203.14.152.116]:33296 "EHLO
	eriador.apana.org.au") by vger.kernel.org with ESMTP
	id <S266941AbSKPAJx>; Fri, 15 Nov 2002 19:09:53 -0500
Date: Sat, 16 Nov 2002 11:15:07 +1100
To: kai.germaschewski@gmx.de
Cc: marcelo@conectiva.com.br, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       linux-kernel@vger.kernel.org
Subject: [PATCH] ISDN multichannel crash
Message-ID: <20021116001507.GA17915@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="tThc/1wpZn/ma/RB"
Content-Disposition: inline
User-Agent: Mutt/1.4i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--tThc/1wpZn/ma/RB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

If you get the message

isdn_ppp_xmit: lp->ppp_slot -1

and your system crashes immediately afterwards, then this patch is for you.
The xmit_lock isn't released when this happens which leaves BH disabled.

The same fix is needed in 2.2 as well.
-- 
Debian GNU/Linux 3.0 is out! ( http://www.debian.org/ )
Email:  Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

--tThc/1wpZn/ma/RB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=p

Index: drivers/isdn/isdn_ppp.c
===================================================================
RCS file: /home/gondolin/herbert/src/CVS/debian/kernel-source-2.4/drivers/isdn/isdn_ppp.c,v
retrieving revision 1.1.1.14
diff -u -r1.1.1.14 isdn_ppp.c
--- drivers/isdn/isdn_ppp.c	3 Aug 2002 00:39:44 -0000	1.1.1.14
+++ drivers/isdn/isdn_ppp.c	16 Nov 2002 00:10:18 -0000
@@ -1147,7 +1147,7 @@
 	if (slot < 0 || slot > ISDN_MAX_CHANNELS) {
 		printk(KERN_ERR "isdn_ppp_xmit: lp->ppp_slot %d\n", lp->ppp_slot);
 		kfree_skb(skb);
-		return 0;
+		goto unlock;
 	}
 	ipt = ippp_table[slot];
 	lp->huptimer = 0;

--tThc/1wpZn/ma/RB--
