Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262164AbTJ3DRm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Oct 2003 22:17:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262174AbTJ3DRm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Oct 2003 22:17:42 -0500
Received: from yue.hongo.wide.ad.jp ([203.178.139.94]:6930 "EHLO
	yue.hongo.wide.ad.jp") by vger.kernel.org with ESMTP
	id S262164AbTJ3DRi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Oct 2003 22:17:38 -0500
Date: Thu, 30 Oct 2003 12:17:32 +0900 (JST)
Message-Id: <20031030.121732.12858700.yoshfuji@linux-ipv6.org>
To: paulus@samba.org
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com, davem@redhat.com,
       jmorris@redhat.com
Subject: Re: Bug somewhere in crypto or ipsec stuff
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
In-Reply-To: <16288.30574.745348.194005@cargo.ozlabs.ibm.com>
References: <16288.30574.745348.194005@cargo.ozlabs.ibm.com>
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

In article <16288.30574.745348.194005@cargo.ozlabs.ibm.com> (at Thu, 30 Oct 2003 13:29:02 +1100), Paul Mackerras <paulus@samba.org> says:

> I get this oops in strcmp, called from crypto_alg_lookup, when I run
> the "spi" command from a freeswan snapshot from 13 October this year.
> The kernel is 2.6.0-test9.
> 
> Oops: kernel access of bad area, sig: 11 [#1]
:
> Call trace:
>  [c00cf058] crypto_alloc_tfm+0x1c/0x104
>  [cd97fb34] ipcomp_init_state+0x90/0x118 [ipcomp]
:

> The problem is basically that crypto_alg_lookup gets called with NULL
> for the `name' parameter.

I would just disallow name == NULL,
well, what algorithm do you expect?

===== crypto/api.c 1.30 vs edited =====
--- 1.30/crypto/api.c	Sat Mar 29 20:16:58 2003
+++ edited/crypto/api.c	Thu Oct 30 12:07:43 2003
@@ -36,6 +36,9 @@
 struct crypto_alg *crypto_alg_lookup(const char *name)
 {
 	struct crypto_alg *q, *alg = NULL;
+
+	if (!name)
+		return NULL;
 	
 	down_read(&crypto_alg_sem);
 	


-- 
Hideaki YOSHIFUJI @ USAGI Project <yoshfuji@linux-ipv6.org>
GPG FP: 9022 65EB 1ECF 3AD1 0BDF  80D8 4807 F894 E062 0EEA
