Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261554AbVBNUA6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261554AbVBNUA6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Feb 2005 15:00:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261553AbVBNUA6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Feb 2005 15:00:58 -0500
Received: from mail.murom.net ([213.177.124.17]:56752 "EHLO ns1.murom.ru")
	by vger.kernel.org with ESMTP id S261550AbVBNUAa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Feb 2005 15:00:30 -0500
Date: Mon, 14 Feb 2005 23:00:17 +0300
From: Sergey Vlasov <vsu@altlinux.ru>
To: linux-kernel@vger.kernel.org
Cc: netdev@oss.sgi.com
Subject: [PATCH 2.6 1/2] Fix documentation build failure
Message-ID: <20050214200017.GA29201@sirius.home>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jI8keyz6grp/JLjh"
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--jI8keyz6grp/JLjh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello!

In linux-2.6.11-rc4-bk2 building of the documentation (make htmldocs)
fails on "DOCPROC Documentation/DocBook/kernel-api.sgml" because of
these errors:

Error(/home/vsu/src/linux-2.6.11-rc4-bk2/include/linux/skbuff.h:936): canno=
t understand prototype: '#ifndef CONFIG_HAVE_ARCH_DEV_ALLOC_SKB '
Error(/home/vsu/src/linux-2.6.11-rc4-bk2/drivers/video/fbmem.c:1265): canno=
t understand prototype: 'const char *global_mode_option; '

This patch fixes htmldocs build failure on include/linux/skbuff.h; it
does not change any code.  I think this patch should be merged before
the 2.6.11 release.

Signed-off-by: Sergey Vlasov <vsu@altlinux.ru>


--- linux-2.6.11-rc4-bk2/include/linux/skbuff.h.doc-build	2005-02-14 20:12:=
37 +0300
+++ linux-2.6.11-rc4-bk2/include/linux/skbuff.h	2005-02-14 22:46:20 +0300
@@ -921,6 +921,7 @@ static inline void __skb_queue_purge(str
 		kfree_skb(skb);
 }
=20
+#ifndef CONFIG_HAVE_ARCH_DEV_ALLOC_SKB
 /**
  *	__dev_alloc_skb - allocate an skbuff for sending
  *	@length: length to allocate
@@ -933,7 +934,6 @@ static inline void __skb_queue_purge(str
  *
  *	%NULL is returned in there is no free memory.
  */
-#ifndef CONFIG_HAVE_ARCH_DEV_ALLOC_SKB
 static inline struct sk_buff *__dev_alloc_skb(unsigned int length,
 					      int gfp_mask)
 {


--=20
Sergey Vlasov

--jI8keyz6grp/JLjh
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFCEQNRW82GfkQfsqIRAkzeAJ97rnrbnsS4vJ1qUXeEhAMErJodcQCfcyq1
pdxxXzgTsG3b/BLpkL4SwBs=
=RSnR
-----END PGP SIGNATURE-----

--jI8keyz6grp/JLjh--
