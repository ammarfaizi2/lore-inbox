Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262927AbUFBNrV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262927AbUFBNrV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 09:47:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262960AbUFBNrU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 09:47:20 -0400
Received: from cmlapp16.siteprotect.com ([64.41.126.229]:31907 "EHLO
	cmlapp16.siteprotect.com") by vger.kernel.org with ESMTP
	id S262927AbUFBNqK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 09:46:10 -0400
Message-ID: <40BDDA1E.6080903@serice.net>
Date: Wed, 02 Jun 2004 08:46:06 -0500
From: Paul Serice <paul@serice.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040127
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Sergey Vlasov <vsu@altlinux.ru>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] iso9660 Inodes Anywhere and NFS
References: <40BD2841.2050509@serice.net> <20040602154411.0032d0f5.vsu@altlinux.ru>
In-Reply-To: <20040602154411.0032d0f5.vsu@altlinux.ru>
Content-Type: multipart/mixed;
 boundary="------------020700080802090501020301"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020700080802090501020301
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Sergey, thanks for looking over the original patch.  The incremental
patch is attached.


--------------020700080802090501020301
Content-Type: text/plain;
 name="linux-2.6.7-rc2-isofs.3.inc1.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="linux-2.6.7-rc2-isofs.3.inc1.patch"

diff -uprN -X dontdiff linux-2.6.7-rc2-isofs.3.orig/fs/isofs/export.c linux-2.6.7-rc2-isofs.3/fs/isofs/export.c
--- linux-2.6.7-rc2-isofs.3.orig/fs/isofs/export.c	2004-06-01 15:42:51.000000000 -0500
+++ linux-2.6.7-rc2-isofs.3/fs/isofs/export.c	2004-06-02 06:01:00.000000000 -0500
@@ -220,9 +220,6 @@ isofs_export_decode_fh(struct super_bloc
 }
 
 
-/* The .get_parent method should be added, but .get_parent has never
- * been implemented in the isofs code.  So, its absence will not be
- * sorely missed. */
 struct export_operations isofs_export_ops = {
 	.decode_fh	= isofs_export_decode_fh,
 	.encode_fh	= isofs_export_encode_fh,
diff -uprN -X dontdiff linux-2.6.7-rc2-isofs.3.orig/fs/isofs/inode.c linux-2.6.7-rc2-isofs.3/fs/isofs/inode.c
--- linux-2.6.7-rc2-isofs.3.orig/fs/isofs/inode.c	2004-06-02 05:39:27.000000000 -0500
+++ linux-2.6.7-rc2-isofs.3/fs/isofs/inode.c	2004-06-02 05:58:45.000000000 -0500
@@ -726,8 +726,6 @@ root_found:
 	/* Set this for reference. Its not currently used except on write
 	   which we don't have .. */
 	   
-	/* RDE: data zone now byte offset! */
-
 	first_data_zone = isonum_733 (rootp->extent) +
 			  isonum_711 (rootp->ext_attr_length);
 	sbi->s_firstdatazone = first_data_zone;

--------------020700080802090501020301--
