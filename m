Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263983AbUBPLeF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 06:34:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263996AbUBPLeF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 06:34:05 -0500
Received: from mail.naturesoft.net ([203.145.184.221]:35230 "EHLO
	naturesoft.net") by vger.kernel.org with ESMTP id S263983AbUBPLeB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 06:34:01 -0500
From: "Krishnakumar. R" <krishnakumar@naturesoft.net>
Reply-To: krishnakumar@naturesoft.net
Organization: Naturesoft
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: 2.6.3-rc3-mm1
Date: Mon, 16 Feb 2004 17:09:58 +0530
User-Agent: KMail/1.5
References: <20040216015823.2dafabb4.akpm@osdl.org>
In-Reply-To: <20040216015823.2dafabb4.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200402161709.58555.krishnakumar@naturesoft.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The patch given below removes the following errors
while compiling:

-------------------------------------------------------------------------------
fs/ext3/super.c: In function `ext3_quota_on':
fs/ext3/super.c:2229: warning: ISO C90 forbids mixed declarations and code
fs/ext3/super.c:2234: error: initializer element is not constant
fs/ext3/super.c:2234: error: (near initialization for `ext3_fs_type.get_sb')
fs/ext3/super.c:2268: error: initializer element is not constant
fs/ext3/super.c:2268: warning: ISO C90 forbids mixed declarations and code
fs/ext3/super.c:2269: error: initializer element is not constant
fs/ext3/super.c:2269: error: syntax error at end of input
make[2]: *** [fs/ext3/super.o] Error 1
make[1]: *** [fs/ext3] Error 2
make: *** [fs] Error 2
--------------------------------------------------------------------------------

The patch is just compilation tested. 
Hence not sure whether its the right fix.
I derived at the patch by looking at the indentation
of the code.

Regards,
KK.

Diffstat output:
super.c |    2 +-
1 files changed, 1 insertion(+), 1 deletion(-)

The patch:

--- linux-2.6.3-rc3-mm1/fs/ext3/super.orig.c    2004-02-16 16:41:52.089749760 
+0530
+++ linux-2.6.3-rc3-mm1/fs/ext3/super.c 2004-02-16 16:53:12.432321968 +0530
@@ -2209,7 +2209,7 @@
                return err;
        if (nd.mnt->mnt_sb != sb)       /* Quotafile not on the same fs? */
                return -EXDEV;
-       if (nd.dentry->d_parent->d_inode != sb->s_root->d_inode) {
+       if (nd.dentry->d_parent->d_inode != sb->s_root->d_inode)
                /* Quotafile not of fs root? */
                printk(KERN_WARNING "EXT3-fs: Quota file not on filesystem "
                                "root. Journalled quota will not work\n");


-- 
HomePage: http://puggy.symonds.net/~krishnakumar


