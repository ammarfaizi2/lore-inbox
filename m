Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263333AbTEVWSN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 May 2003 18:18:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263317AbTEVWSM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 May 2003 18:18:12 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:16647 "EHLO
	arnor.me.apana.org.au") by vger.kernel.org with ESMTP
	id S263373AbTEVWSJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 May 2003 18:18:09 -0400
Date: Fri, 23 May 2003 08:30:38 +1000
To: davem@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Zero the reserved bytes of sadb_prob in af_key.c
Message-ID: <20030522223038.GA31759@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Dxnq1zWXvFF0Q93v"
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Dxnq1zWXvFF0Q93v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

According to RFC2367, all reserved bytes must be set to zero.  This patch
does just that for the sadb_prop messages.
-- 
Debian GNU/Linux 3.0 is out! ( http://www.debian.org/ )
Email:  Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

--Dxnq1zWXvFF0Q93v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=p

Index: net/key/af_key.c
===================================================================
RCS file: /home/gondolin/herbert/src/CVS/debian/kernel-source-2.5/net/key/af_key.c,v
retrieving revision 1.1.1.6
diff -u -r1.1.1.6 af_key.c
--- net/key/af_key.c	4 May 2003 23:53:08 -0000	1.1.1.6
+++ net/key/af_key.c	22 May 2003 09:58:45 -0000
@@ -2245,6 +2245,9 @@
 	p->sadb_prop_len = sizeof(struct sadb_prop)/8;
 	p->sadb_prop_exttype = SADB_EXT_PROPOSAL;
 	p->sadb_prop_replay = 32;
+	p->sadb_prop_reserved[0] = 0;
+	p->sadb_prop_reserved[1] = 0;
+	p->sadb_prop_reserved[2] = 0;
 
 	for (i = 0; ; i++) {
 		struct xfrm_algo_desc *aalg = xfrm_aalg_get_byidx(i);
@@ -2276,6 +2279,9 @@
 	p->sadb_prop_len = sizeof(struct sadb_prop)/8;
 	p->sadb_prop_exttype = SADB_EXT_PROPOSAL;
 	p->sadb_prop_replay = 32;
+	p->sadb_prop_reserved[0] = 0;
+	p->sadb_prop_reserved[1] = 0;
+	p->sadb_prop_reserved[2] = 0;
 
 	for (i=0; ; i++) {
 		struct xfrm_algo_desc *ealg = xfrm_ealg_get_byidx(i);

--Dxnq1zWXvFF0Q93v--
