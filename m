Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289243AbSCDAfy>; Sun, 3 Mar 2002 19:35:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289307AbSCDAfo>; Sun, 3 Mar 2002 19:35:44 -0500
Received: from hera.cwi.nl ([192.16.191.8]:34512 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S289243AbSCDAfc>;
	Sun, 3 Mar 2002 19:35:32 -0500
From: Andries.Brouwer@cwi.nl
Date: Mon, 4 Mar 2002 00:35:15 GMT
Message-Id: <UTC200203040035.AAA137549.aeb@cwi.nl>
To: jurgen@pophost.eunet.be, linux-kernel@vger.kernel.org
Subject: [patch] Re: 2.4.19-pre2: ufs problems
Cc: kraxel@bytesex.org, marcelo@conectiva.com.br
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Both Gerd Knorr and Jurgen Philippaerts complain about
problems mounting an ufs filesystem, one for BSD, the
other for Solaris.
The reason is the patch fragment in patch-2.4.19-pre2:

--- linux.orig/fs/ufs/super.c   Thu Feb 28 18:24:57 2002
+++ linux/fs/ufs/super.c        Wed Feb 27 20:34:30 2002
@@ -597,7 +597,11 @@
        }

 again:
-       set_blocksize (sb->s_dev, block_size);
+       if (!set_blocksize (sb->s_dev, block_size)) {
+               printk(KERN_ERR "UFS: failed to set blocksize\n");
+               goto failed;
+       }
+
        sb->s_blocksize = block_size;

        /*

Indeed, set_blocksize returns 0 when all is well.
Thus, this change will always cause a failure.

Andries

[so, this patch fragment must be reverted, or the '!'
must be removed]
