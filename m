Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261417AbVGCNAs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261417AbVGCNAs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Jul 2005 09:00:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261422AbVGCNAs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Jul 2005 09:00:48 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:52431 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S261420AbVGCNAd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Jul 2005 09:00:33 -0400
From: Denis Vlasenko <vda@ilport.com.ua>
To: Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 0.5/4 :) ] ROR -> ror32
Date: Sun, 3 Jul 2005 16:00:20 +0300
User-Agent: KMail/1.5.4
Cc: linux-crypto@vger.kernel.org, davem@davemloft.net,
       linux-kernel@vger.kernel.org
References: <200506201354.22187.vda@ilport.com.ua> <20050703113700.GA4848@gondor.apana.org.au> <200507031557.15416.vda@ilport.com.ua>
In-Reply-To: <200507031557.15416.vda@ilport.com.ua>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_kF+xCj3Ix5BuTLv"
Message-Id: <200507031600.20219.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_kF+xCj3Ix5BuTLv
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Remove local ROR, use ror32 instead.

--Boundary-00=_kF+xCj3Ix5BuTLv
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="05.ror.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="05.ror.patch"

diff -urpN linux-2.6.12.0.orig/crypto/des.c linux-2.6.12.05.n/crypto/des.c
--- linux-2.6.12.0.orig/crypto/des.c	Tue Oct 19 00:55:29 2004
+++ linux-2.6.12.05.n/crypto/des.c	Sun Jul  3 15:27:12 2005
@@ -35,8 +35,6 @@
 #define DES3_EDE_EXPKEY_WORDS	(3 * DES_EXPKEY_WORDS)
 #define DES3_EDE_BLOCK_SIZE	DES_BLOCK_SIZE
 
-#define ROR(d,c,o)	((d) = (d) >> (c) | (d) << (o))
-
 struct des_ctx {
 	u8 iv[DES_BLOCK_SIZE];
 	u32 expkey[DES_EXPKEY_WORDS];
@@ -1159,9 +1157,7 @@ not_weak:
 		w  |= (b1[k[18+24]] | b0[k[19+24]]) << 4;
 		w  |= (b1[k[20+24]] | b0[k[21+24]]) << 2;
 		w  |=  b1[k[22+24]] | b0[k[23+24]];
-		
-		ROR(w, 4, 28);      /* could be eliminated */
-		expkey[1] = w;
+		expkey[1] = ror32(w, 4);	/* could be eliminated */
 
 		k += 48;
 		expkey += 2;

--Boundary-00=_kF+xCj3Ix5BuTLv--

