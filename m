Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267284AbUBMW4u (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 17:56:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267277AbUBMW4t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 17:56:49 -0500
Received: from arnor.apana.org.au ([203.14.152.115]:59660 "EHLO
	arnor.me.apana.org.au") by vger.kernel.org with ESMTP
	id S267284AbUBMW4g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 17:56:36 -0500
Date: Sat, 14 Feb 2004 09:56:21 +1100
To: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-ntfs-dev@lists.sourceforge.net
Subject: [2.4] off-by-one kmalloc in ntfs
Message-ID: <20040213225621.GA16550@gondor.apana.org.au>
References: <20040131045812.GA19629@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="u3/rZRmxL6MmkK24"
Content-Disposition: inline
In-Reply-To: <20040131045812.GA19629@gondor.apana.org.au>
User-Agent: Mutt/1.5.5.1+cvs20040105i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--u3/rZRmxL6MmkK24
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

This patch fixes an off-by-one kmalloc bug in ntfs in 2.4.24.

Cheers,
-- 
Debian GNU/Linux 3.0 is out! ( http://www.debian.org/ )
Email:  Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

--u3/rZRmxL6MmkK24
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=p

Index: kernel-2.4/fs/ntfs/support.c
===================================================================
RCS file: /home/gondolin/herbert/src/CVS/debian/kernel-source-2.4/fs/ntfs/support.c,v
retrieving revision 1.1.1.9
diff -u -r1.1.1.9 support.c
--- kernel-2.4/fs/ntfs/support.c	25 Feb 2002 19:38:09 -0000	1.1.1.9
+++ kernel-2.4/fs/ntfs/support.c	12 Feb 2004 11:13:29 -0000
@@ -240,7 +240,7 @@
 				NLS_MAX_CHARSET_SIZE)) > 0) {
 			/* Adjust result buffer. */
 			if (chl > 1) {
-				buf = ntfs_malloc(*out_len + chl - 1);
+				buf = ntfs_malloc(*out_len + chl);
 				if (!buf) {
 					i = -ENOMEM;
 					goto err_ret;

--u3/rZRmxL6MmkK24--
