Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262164AbTKIENq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Nov 2003 23:13:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262174AbTKIENq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Nov 2003 23:13:46 -0500
Received: from arnor.apana.org.au ([203.14.152.115]:12051 "EHLO
	arnor.me.apana.org.au") by vger.kernel.org with ESMTP
	id S262164AbTKIENo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Nov 2003 23:13:44 -0500
Date: Sun, 9 Nov 2003 15:13:30 +1100
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [OSS] Unregister driver if probing fails in SB
Message-ID: <20031109041330.GA32452@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="3V7upXqbjpZ4EhLz"
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--3V7upXqbjpZ4EhLz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi:

This patch adds a missing unregister when probing fails in the
OSS SoundBlaster driver.

Cheers,
-- 
Debian GNU/Linux 3.0 is out! ( http://www.debian.org/ )
Email:  Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

--3V7upXqbjpZ4EhLz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=p

Index: kernel-source-2.5/sound/oss/sb_card.c
===================================================================
RCS file: /home/gondolin/herbert/src/CVS/debian/kernel-source-2.5/sound/oss/sb_card.c,v
retrieving revision 1.1.1.6
retrieving revision 1.3
diff -u -r1.1.1.6 -r1.3
--- kernel-source-2.5/sound/oss/sb_card.c	22 Aug 2003 23:57:18 -0000	1.1.1.6
+++ kernel-source-2.5/sound/oss/sb_card.c	9 Nov 2003 04:12:55 -0000	1.3
@@ -302,7 +302,13 @@
 
 	/* If either PnP or Legacy registered a card then return
 	 * success */
-	return (pres > 0 || lres > 0) ? 0 : -ENODEV;
+	if (pres <= 0 && lres <= 0) {
+#ifdef CONFIG_PNP
+		pnp_unregister_card_driver(&sb_pnp_driver);
+#endif
+		return -ENODEV;
+	}
+	return 0;
 }
 
 static void __exit sb_exit(void)

--3V7upXqbjpZ4EhLz--
