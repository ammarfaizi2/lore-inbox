Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263063AbTIEOjX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 10:39:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262756AbTIEOjX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 10:39:23 -0400
Received: from johanna5.ux.his.no ([152.94.1.25]:20199 "EHLO
	johanna5.ux.his.no") by vger.kernel.org with ESMTP id S263063AbTIEOjS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 10:39:18 -0400
Date: Fri, 5 Sep 2003 16:38:59 +0200
From: Erlend Aasland <erlend-a@ux.his.no>
To: "David S. Miller" <davem@redhat.com>,
       James Morris <jmorris@intercode.com.au>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [CRYPTO] add alg. type to /proc/crypto output
Message-ID: <20030905143859.GA18143@johanna5.ux.his.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

Here is a patch that add alg. type output to /proc/crypto. Booted and
tested.


Erlend Aasland

diff -urN linux-2.6.0-test4-bk7/crypto/proc.c linux-2.6.0-test4-bk7-dirty/crypto/proc.c
--- linux-2.6.0-test4-bk7/crypto/proc.c	2003-08-23 01:53:43.000000000 +0200
+++ linux-2.6.0-test4-bk7-dirty/crypto/proc.c	2003-09-05 18:17:35.000000000 +0200
@@ -57,6 +57,7 @@
 	
 	switch (alg->cra_flags & CRYPTO_ALG_TYPE_MASK) {
 	case CRYPTO_ALG_TYPE_CIPHER:
+		seq_printf(m, "type         : cipher\n");
 		seq_printf(m, "blocksize    : %u\n", alg->cra_blocksize);
 		seq_printf(m, "min keysize  : %u\n",
 					alg->cra_cipher.cia_min_keysize);
@@ -65,10 +66,17 @@
 		break;
 		
 	case CRYPTO_ALG_TYPE_DIGEST:
+		seq_printf(m, "type         : digest\n");
 		seq_printf(m, "blocksize    : %u\n", alg->cra_blocksize);
 		seq_printf(m, "digestsize   : %u\n",
 		           alg->cra_digest.dia_digestsize);
 		break;
+	case CRYPTO_ALG_TYPE_COMPRESS:
+		seq_printf(m, "type         : compression\n");
+		break;
+	default:
+		seq_printf(m, "type         : unknown\n");
+		break;
 	}
 
 	seq_putc(m, '\n');
