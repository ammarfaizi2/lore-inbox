Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263676AbRFMAHH>; Tue, 12 Jun 2001 20:07:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263881AbRFMAG5>; Tue, 12 Jun 2001 20:06:57 -0400
Received: from epic20.Stanford.EDU ([171.64.15.55]:53927 "EHLO
	epic20.Stanford.EDU") by vger.kernel.org with ESMTP
	id <S263676AbRFMAGn>; Tue, 12 Jun 2001 20:06:43 -0400
Date: Tue, 12 Jun 2001 17:06:02 -0700 (PDT)
From: John Martin <suntzu@stanford.edu>
To: <linux-kernel@vger.kernel.org>, <torvalds@transmeta.com>
Subject: [PATCH] nfsfh.c
Message-ID: <Pine.GSO.4.31.0106121704230.25662-100000@epic20.Stanford.EDU>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

this seems to be an appropriate place to check this pointer and return an
error code if necessary.
    -john

--- linux/fs/nfsd/nfsfh.c.orig  Fri Feb  9 11:29:44 2001
+++ linux/fs/nfsd/nfsfh.c       Sun Jun  3 01:23:13 2001
@@ -135,6 +135,9 @@
        struct list_head *lp;
        struct dentry *result;
        inode = iget(sb, ino);
+       if(!inode)
+               return ERR_PTR(-ENOMEM);
+
        if (is_bad_inode(inode)
            || (generation && inode->i_generation != generation)
                ) {


