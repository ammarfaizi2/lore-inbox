Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277353AbRJ0XiZ>; Sat, 27 Oct 2001 19:38:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277493AbRJ0XiQ>; Sat, 27 Oct 2001 19:38:16 -0400
Received: from eriador.apana.org.au ([203.14.152.116]:15883 "EHLO
	eriador.apana.org.au") by vger.kernel.org with ESMTP
	id <S277353AbRJ0XiE>; Sat, 27 Oct 2001 19:38:04 -0400
Date: Sun, 28 Oct 2001 10:38:26 +1100
To: hans-christoph.rohland@sap.com, linux-kernel@vger.kernel.org
Subject: [PATCH] tmpfs symlink size bug
Message-ID: <20011028103826.A17842@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="BXVAT5kNtrzKuDFl"
Content-Disposition: inline
User-Agent: Mutt/1.3.23i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--BXVAT5kNtrzKuDFl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Since 2.4.12 the size of symlinks on tmpfs has been off by one.  The
following patch corrects that error.
-- 
Debian GNU/Linux 2.2 is out! ( http://www.debian.org/ )
Email:  Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

--BXVAT5kNtrzKuDFl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=p

Index: mm/shmem.c
===================================================================
RCS file: /home/gondolin/herbert/src/CVS/debian/kernel-source-2.4/mm/shmem.c,v
retrieving revision 1.1.1.16
diff -u -r1.1.1.16 shmem.c
--- mm/shmem.c	17 Oct 2001 21:19:20 -0000	1.1.1.16
+++ mm/shmem.c	27 Oct 2001 23:34:51 -0000
@@ -1157,7 +1157,7 @@
 		
 	inode = dentry->d_inode;
 	info = SHMEM_I(inode);
-	inode->i_size = len;
+	inode->i_size = len - 1;
 	if (len <= sizeof(struct shmem_inode_info)) {
 		/* do it inline */
 		memcpy(info, symname, len);

--BXVAT5kNtrzKuDFl--
