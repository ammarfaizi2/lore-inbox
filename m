Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263606AbUAaE63 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jan 2004 23:58:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263625AbUAaE63
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jan 2004 23:58:29 -0500
Received: from arnor.apana.org.au ([203.14.152.115]:51727 "EHLO
	arnor.me.apana.org.au") by vger.kernel.org with ESMTP
	id S263606AbUAaE61 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jan 2004 23:58:27 -0500
Date: Sat, 31 Jan 2004 15:58:12 +1100
To: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-ntfs-dev@lists.sourceforge.net
Subject: [2.4] invalid kfree in ntfs_printcb
Message-ID: <20040131045812.GA19629@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="BXVAT5kNtrzKuDFl"
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--BXVAT5kNtrzKuDFl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi:

This patch fixes a potential double kfree in ntfs_printcb in 2.4.24.

Cheers,
-- 
Debian GNU/Linux 3.0 is out! ( http://www.debian.org/ )
Email:  Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

--BXVAT5kNtrzKuDFl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=p

Index: kernel-2.4/fs/ntfs/fs.c
===================================================================
RCS file: /home/gondolin/herbert/src/CVS/debian/kernel-source-2.4/fs/ntfs/fs.c,v
retrieving revision 1.1.1.15
diff -u -r1.1.1.15 fs.c
--- kernel-2.4/fs/ntfs/fs.c	28 Nov 2003 18:26:21 -0000	1.1.1.15
+++ kernel-2.4/fs/ntfs/fs.c	31 Jan 2004 04:47:51 -0000
@@ -199,7 +199,7 @@
 		ntfs_debug(DEBUG_OTHER, "%s(): Skipping unrepresentable "
 				"file.\n", __FUNCTION__);
 		err = 0;
-		goto err_ret;
+		goto err_noname;
 	}
 	if (!show_sys_files && inum < 0x10UL) {
 		ntfs_debug(DEBUG_OTHER, "%s(): Skipping system file (%s).\n",
@@ -233,8 +233,9 @@
 	if (err)
 		nf->ret_code = err;
 err_ret:
-	nf->namelen = 0;
 	ntfs_free(nf->name);
+err_noname:
+	nf->namelen = 0;
 	nf->name = NULL;
 	return err;
 }

--BXVAT5kNtrzKuDFl--
