Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261249AbVCXXvd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261249AbVCXXvd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 18:51:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261248AbVCXXvd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 18:51:33 -0500
Received: from tornado.reub.net ([60.234.136.108]:21691 "EHLO tornado.reub.net")
	by vger.kernel.org with ESMTP id S261249AbVCXXvB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 18:51:01 -0500
Message-ID: <4243525B.1030307@reub.net>
Date: Fri, 25 Mar 2005 11:50:51 +1200
From: Reuben Farrelly <reuben-lkml@reub.net>
User-Agent: Mozilla Thunderbird 1.0+ (Windows/20050321)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-rc1-mm2
References: <fa.h0e9s21.ljie1j@ifi.uio.no>
In-Reply-To: <fa.h0e9s21.ljie1j@ifi.uio.no>
Content-Type: multipart/mixed;
 boundary="------------030807040903000204030107"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030807040903000204030107
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.12-rc1/2.6.12-rc1-mm2/
> 
> 
> - Added David Miller's networking tree to the -mm lineup as bk-net.patch. 
> 
> - Added Herbert Xu's crypto development tree to the -mm lineup as
>   bk-cryptodev.patch.
> 
>   -mm kernels now aggregate Linus's tree and 34 subsystem trees.  Usually
>   they are pulled 3-4 hours before the release of the -mm kernel.  
> 
>   Usually it is possible to determine the latest cset from each tree by
>   looking at the first couple of lines of the relevant patch in the
>   broken-out/ directory.  Although sometimes it isn't there if I had to
>   massage the diff.
> 
> - There may be an x86_64 problem here, although it works for me.  If it
>   fails early in boot, try reverting
>   x86_64-separate-amd-cmp-detection-from-hyper-threading.patch
> 
> - There's some work here on the recent USB PM resume bugs.  If you had
>   problems there, please test and be sure to cc
>   linux-usb-devel@lists.sourceforge.net in any reports.
> 
> - Some fixes for the recent DRM problems.
> 
> - Big DVB update
> 
> - md updates
> 
> - nfs4 server updates
> 
> - Lots more fixes
> 
> - Lots more bugs.

Fails to compile for me:

   CC [M]  fs/nfs/dir.o
   CC [M]  fs/nfs/inode.o
   CC [M]  fs/nfs/nfs4proc.o
fs/nfs/nfs4proc.c:2976: error: static declaration of 
'nfs4_file_inode_operations' follows non-static declaration
fs/nfs/nfs4_fs.h:179: error: previous declaration of 
'nfs4_file_inode_operations' was here
make[2]: *** [fs/nfs/nfs4proc.o] Error 1
make[1]: *** [fs/nfs] Error 2
make: *** [fs] Error 2

I needed to remove this line:

extern struct inode_operations nfs4_file_inode_operations;

from  fs/nfs/nfs4_fs.h.

Patch attached.

Reuben




--------------030807040903000204030107
Content-Type: text/plain;
 name="nfsfix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="nfsfix.patch"

--- fs/nfs/nfs4_fs.h	2005-03-25 11:40:51.000000000 +1200
+++ fs/nfs/nfs4_fs.h	2005-03-25 11:44:28.000000000 +1200
@@ -176,7 +176,6 @@
 
 extern struct dentry_operations nfs4_dentry_operations;
 extern struct inode_operations nfs4_dir_inode_operations;
-extern struct inode_operations nfs4_file_inode_operations;
 
 /* inode.c */
 extern ssize_t nfs4_getxattr(struct dentry *, const char *, void *, size_t);

--------------030807040903000204030107--
