Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263737AbTHJLFq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Aug 2003 07:05:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263738AbTHJLFq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Aug 2003 07:05:46 -0400
Received: from yue.hongo.wide.ad.jp ([203.178.139.94]:31500 "EHLO
	yue.hongo.wide.ad.jp") by vger.kernel.org with ESMTP
	id S263737AbTHJLFo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Aug 2003 07:05:44 -0400
Date: Sun, 10 Aug 2003 20:05:51 +0900 (JST)
Message-Id: <20030810.200551.24856481.yoshfuji@linux-ipv6.org>
To: davem@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 3/9] convert net to virt_to_pageoff()
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
In-Reply-To: <20030810020444.48cb740b.davem@redhat.com>
References: <20030810013041.679ddc4c.davem@redhat.com>
	<20030810090556.GY31810@waste.org>
	<20030810020444.48cb740b.davem@redhat.com>
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

[3/9] convert net virt_to_pageoff().

Index: linux-2.6/net/ipv6/addrconf.c
===================================================================
RCS file: /home/cvs/linux-2.5/net/ipv6/addrconf.c,v
retrieving revision 1.48
diff -u -r1.48 addrconf.c
--- linux-2.6/net/ipv6/addrconf.c	25 Jul 2003 23:58:59 -0000	1.48
+++ linux-2.6/net/ipv6/addrconf.c	10 Aug 2003 08:40:55 -0000
@@ -1110,10 +1110,10 @@
 	struct scatterlist sg[2];
 
 	sg[0].page = virt_to_page(idev->entropy);
-	sg[0].offset = ((long) idev->entropy & ~PAGE_MASK);
+	sg[0].offset = virt_to_pageoff(idev->entropy);
 	sg[0].length = 8;
 	sg[1].page = virt_to_page(eui64);
-	sg[1].offset = ((long) eui64 & ~PAGE_MASK);
+	sg[1].offset = virt_to_pageoff(eui64);
 	sg[1].length = 8;
 
 	dev = idev->dev;
Index: linux-2.6/net/sunrpc/auth_gss/gss_krb5_crypto.c
===================================================================
RCS file: /home/cvs/linux-2.5/net/sunrpc/auth_gss/gss_krb5_crypto.c,v
retrieving revision 1.3
diff -u -r1.3 gss_krb5_crypto.c
--- linux-2.6/net/sunrpc/auth_gss/gss_krb5_crypto.c	4 Feb 2003 17:55:46 -0000	1.3
+++ linux-2.6/net/sunrpc/auth_gss/gss_krb5_crypto.c	10 Aug 2003 08:40:55 -0000
@@ -75,7 +75,7 @@
 
 	memcpy(out, in, length);
 	sg[0].page = virt_to_page(out);
-	sg[0].offset = ((long)out & ~PAGE_MASK);
+	sg[0].offset = virt_to_pageoff(out);
 	sg[0].length = length;
 
 	ret = crypto_cipher_encrypt(tfm, sg, sg, length);
@@ -114,7 +114,7 @@
 
 	memcpy(out, in, length);
 	sg[0].page = virt_to_page(out);
-	sg[0].offset = ((long)out  & ~PAGE_MASK);
+	sg[0].offset = virt_to_pageoff(out);
 	sg[0].length = length;
 
 	ret = crypto_cipher_decrypt(tfm, sg, sg, length);
@@ -151,7 +151,7 @@
 		goto out_free_tfm;
 	}
 	sg[0].page = virt_to_page(input->data);
-	sg[0].offset = ((long)input->data & ~PAGE_MASK);
+	sg[0].offset = virt_to_pageoff(input->data);
 	sg[0].length = input->len;
 
 	crypto_digest_init(tfm);

-- 
Hideaki YOSHIFUJI @ USAGI Project <yoshfuji@linux-ipv6.org>
GPG FP: 9022 65EB 1ECF 3AD1 0BDF  80D8 4807 F894 E062 0EEA
