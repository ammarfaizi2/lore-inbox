Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266349AbUHNKaa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266349AbUHNKaa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Aug 2004 06:30:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266353AbUHNKaa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Aug 2004 06:30:30 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:10121 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266349AbUHNKa1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Aug 2004 06:30:27 -0400
Message-ID: <411DE9B6.80806@pobox.com>
Date: Sat, 14 Aug 2004 06:30:14 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.6.8
References: <Pine.LNX.4.58.0408132303090.5277@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0408132303090.5277@ppc970.osdl.org>
Content-Type: multipart/mixed;
 boundary="------------070101000004070509020304"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070101000004070509020304
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Linus Torvalds wrote:
> Matthew Wilcox:
>   o Remove fcntl f_op

Any chance of a 2.6.9 with working NFS?

See attached patch, which came from this thread:
http://marc.theaimsgroup.com/?l=linux-kernel&m=109244804202259&w=2
http://marc.theaimsgroup.com/?t=109244611400001&r=1&w=2


--------------070101000004070509020304
Content-Type: text/plain;
 name="patch.nfs-fix"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch.nfs-fix"

===== fs/nfs/file.c 1.40 vs edited =====
--- 1.40/fs/nfs/file.c	2004-08-09 14:58:00 -04:00
+++ edited/fs/nfs/file.c	2004-08-13 23:02:34 -04:00
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

--------------070101000004070509020304--
