Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262330AbTKMJ5n (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Nov 2003 04:57:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262592AbTKMJ5n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Nov 2003 04:57:43 -0500
Received: from arnor.apana.org.au ([203.14.152.115]:33297 "EHLO
	arnor.me.apana.org.au") by vger.kernel.org with ESMTP
	id S262330AbTKMJ5l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Nov 2003 04:57:41 -0500
Date: Thu, 13 Nov 2003 20:57:21 +1100
To: Linus Torvalds <torvalds@osdl.org>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [i386] Remove bogus panic calls in mpparse.c
Message-ID: <20031113095721.GB27003@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="ADZbWkCsHQ7r3kzd"
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ADZbWkCsHQ7r3kzd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi:

This patch was based on a patch from Jochen Voss who owns a laptop
affected by this (http://seehuhn.de/comp/toshiba.html).

It replaces a couple of panic calls with printk instead.  They're
bogus because:

1. It's not fatal.
2. The user won't see it since the console hasn't initialised yet.

Cheers,
-- 
Debian GNU/Linux 3.0 is out! ( http://www.debian.org/ )
Email:  Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

--ADZbWkCsHQ7r3kzd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=p

Index: kernel-source-2.5/arch/i386/kernel/mpparse.c
===================================================================
RCS file: /home/gondolin/herbert/src/CVS/debian/kernel-source-2.5/arch/i386/kernel/mpparse.c,v
retrieving revision 1.1.1.15
diff -u -r1.1.1.15 mpparse.c
--- kernel-source-2.5/arch/i386/kernel/mpparse.c	17 Oct 2003 21:43:00 -0000	1.1.1.15
+++ kernel-source-2.5/arch/i386/kernel/mpparse.c	13 Nov 2003 09:48:50 -0000
@@ -361,15 +361,12 @@
 	unsigned char *mpt=((unsigned char *)mpc)+count;
 
 	if (memcmp(mpc->mpc_signature,MPC_SIGNATURE,4)) {
-		panic("SMP mptable: bad signature [%c%c%c%c]!\n",
-			mpc->mpc_signature[0],
-			mpc->mpc_signature[1],
-			mpc->mpc_signature[2],
-			mpc->mpc_signature[3]);
+		printk(KERN_ERR "SMP mptable: bad signature [0x%x]!\n",
+			*(u32 *)mpc->mpc_signature);
 		return 0;
 	}
 	if (mpf_checksum((unsigned char *)mpc,mpc->mpc_length)) {
-		panic("SMP mptable: checksum error!\n");
+		printk(KERN_ERR "SMP mptable: checksum error!\n");
 		return 0;
 	}
 	if (mpc->mpc_spec!=0x01 && mpc->mpc_spec!=0x04) {

--ADZbWkCsHQ7r3kzd--
