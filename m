Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267951AbUHNDXy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267951AbUHNDXy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 23:23:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268005AbUHNDXy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 23:23:54 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:39403 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S267951AbUHNDXu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 23:23:50 -0400
Message-ID: <411D85B6.5070506@pobox.com>
Date: Fri, 13 Aug 2004 23:23:34 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Trond Myklebust <trond.myklebust@fys.uio.no>
CC: Andrew Morton <akpm@osdl.org>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] Re: [2.6.8-rc4-bk] NFS oops on x86-64
References: <411D65B4.4030208@pobox.com>	 <1092447909.4078.18.camel@lade.trondhjem.org>	 <1092450076.4078.34.camel@lade.trondhjem.org> <1092450265.4078.37.camel@lade.trondhjem.org>
In-Reply-To: <1092450265.4078.37.camel@lade.trondhjem.org>
Content-Type: multipart/mixed;
 boundary="------------050005040600070908020409"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050005040600070908020409
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Yep, the attached patch fixes NFS on both x86 and x86-64.


--------------050005040600070908020409
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

===== fs/nfs/file.c 1.40 vs edited =====
--- 1.40/fs/nfs/file.c	2004-08-09 14:58:00 -04:00
+++ edited/fs/nfs/file.c	2004-08-13 22:54:01 -04:00
@@ -72,7 +72,7 @@
 
 static int nfs_check_flags(int flags)
 {
-	if (flags & (O_APPEND | O_DIRECT))
+	if ((flags & (O_APPEND | O_DIRECT)) == (O_APPEND | O_DIRECT))
 		return -EINVAL;
 
 	return 0;
@@ -89,7 +89,7 @@
 	int res;
 
 	res = nfs_check_flags(filp->f_flags);
-	if (!res)
+	if (res)
 		return res;
 
 	lock_kernel();

--------------050005040600070908020409--
