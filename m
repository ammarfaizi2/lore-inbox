Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266979AbTADRko>; Sat, 4 Jan 2003 12:40:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266983AbTADRko>; Sat, 4 Jan 2003 12:40:44 -0500
Received: from yue.hongo.wide.ad.jp ([203.178.139.94]:9488 "EHLO
	yue.hongo.wide.ad.jp") by vger.kernel.org with ESMTP
	id <S266979AbTADRkn>; Sat, 4 Jan 2003 12:40:43 -0500
Date: Sun, 05 Jan 2003 02:48:23 +0900 (JST)
Message-Id: <20030105.024823.61168301.yoshfuji@linux-ipv6.org>
To: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
CC: davem@redhat.com, kuznet@ms2.inr.ac.ru, usagi@linux-ipv6.org
Subject: [PATCH] IPv6: Fix Length of Authentication Extension Header
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
Organization: USAGI Project
X-URL: http://www.yoshifuji.org/%7Ehideaki/
X-Fingerprint: 90 22 65 EB 1E CF 3A D1 0B DF 80 D8 48 07 F8 94 E0 62 0E EA
X-PGP-Key-URL: http://www.yoshifuji.org/%7Ehideaki/hideaki@yoshifuji.org.asc
X-Face: "5$Al-.M>NJ%a'@hhZdQm:."qn~PA^gq4o*>iCFToq*bAi#4FRtx}enhuQKz7fNqQz\BYU]
 $~O_5m-9'}MIs`XGwIEscw;e5b>n"B_?j/AkL~i/MEa<!5P`&C$@oP>ZBLP
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.1 (AOI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

This patch fixes calculation of length of IPv6 Authentication Extension
Header.

RFC2402: 2.2 Payload Length
:
This 8-bit field specifies the length of AH in 32-bit words (4-byte
units), minus "2".  ...

This is against linux-2.4.20, 2.5.54. 
(2.2.x series have similar bug, too.)

Thanks in advance.

-------------------------------------------------------------------
Patch-Name: Fix Length of Authentication Extension Header
Patch-Id: FIX_2_4_20_EXTHDRS_AUTHHDRLEN-20030105
Patch-Author: YOSHIFUJI Hideaki / USAGI Project <yoshfuji@linux-ipv6.org>
Credit: Noriaki Takamiya / USAGI Project <takamiya@linux-ipv6.org>
Reference: RFC2402
-------------------------------------------------------------------
Index: net/ipv6/exthdrs.c
===================================================================
RCS file: /cvsroot/usagi/usagi-backport/linux24/net/ipv6/exthdrs.c,v
retrieving revision 1.1.1.1
retrieving revision 1.1.1.1.46.1
diff -u -r1.1.1.1 -r1.1.1.1.46.1
--- net/ipv6/exthdrs.c	20 Aug 2002 09:47:02 -0000	1.1.1.1
+++ net/ipv6/exthdrs.c	4 Jan 2003 17:19:03 -0000	1.1.1.1.46.1
@@ -402,7 +402,13 @@
 	if (!pskb_may_pull(skb, (skb->h.raw-skb->data)+8))
 		goto fail;
 
-	len = (skb->h.raw[1]+1)<<2;
+	/*
+	 * RFC2402 2.2 Payload Length
+	 * The 8-bit field specifies the length of AH in 32-bit words 
+	 * (4-byte units), minus "2".
+	 * -- Noriaki Takamiya @USAGI Project
+	 */
+	len = (skb->h.raw[1]+2)<<2;
 
 	if (len&7)
 		goto fail;

-- 
Hideaki YOSHIFUJI @ USAGI Project <yoshfuji@linux-ipv6.org>
GPG FP: 9022 65EB 1ECF 3AD1 0BDF  80D8 4807 F894 E062 0EEA
