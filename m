Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261787AbVGBECQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261787AbVGBECQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Jul 2005 00:02:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261782AbVGBECP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Jul 2005 00:02:15 -0400
Received: from natnoddy.rzone.de ([81.169.145.166]:42714 "EHLO
	natnoddy.rzone.de") by vger.kernel.org with ESMTP id S261787AbVGBEB4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Jul 2005 00:01:56 -0400
Message-ID: <42C611A6.9070309@man-made.de>
Date: Sat, 02 Jul 2005 06:01:42 +0200
From: Frank Schruefer <kernel@man-made.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040906
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: alan@redhat.com
Subject: [TRIVIAL PATCH] Documentation vfs.txt, d_delete prototype
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hy,

Prototype mismatch in docu (2.6.13-rc1 and earlier):

Stone:/usr/src # diff -r -u linux-2.6.13-rc1.UNTOUCHED linux-2.6.13-rc1
--------------------------------SNIPON---------------------------------------
diff -r -u linux-2.6.13-rc1.UNTOUCHED/Documentation/filesystems/vfs.txt linux-2.6.13-rc1/Documentation/filesystems/vfs.txt
--- linux-2.6.13-rc1.UNTOUCHED/Documentation/filesystems/vfs.txt        2005-06-30 01:00:53.000000000 +0200
+++ linux-2.6.13-rc1/Documentation/filesystems/vfs.txt  2005-07-02 05:04:22.000000000 +0200
@@ -422,7 +422,7 @@
         int (*d_revalidate)(struct dentry *);
         int (*d_hash) (struct dentry *, struct qstr *);
         int (*d_compare) (struct dentry *, struct qstr *, struct qstr *);
-       void (*d_delete)(struct dentry *);
+       int (*d_delete)(struct dentry *);
         void (*d_release)(struct dentry *);
         void (*d_iput)(struct dentry *, struct inode *);
  };
@@ -438,7 +438,11 @@

    d_delete: called when the last reference to a dentry is
         deleted. This means no-one is using the dentry, however it is
-       still valid and in the dcache
+       still valid and in the dcache.
+       If the return value is non zero the dentry will be tried to
+       be unhashed and killed.
+       If the return value is zero the behaviour is as if the custom
+       routine wouldn't have been called.

    d_release: called when a dentry is really deallocated
-------------------------------SNIPOFF---------------------------------------

-- 

Thanks,
    Frank Schruefer
    SITEFORUM Software Europe GmbH
    Germany (Thuringia)

