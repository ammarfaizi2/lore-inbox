Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316067AbSE3BcN>; Wed, 29 May 2002 21:32:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316069AbSE3BcM>; Wed, 29 May 2002 21:32:12 -0400
Received: from dsl0206.netquest.net ([206.117.109.206]:28620 "HELO
	arcadia.augart.com") by vger.kernel.org with SMTP
	id <S316067AbSE3BcL>; Wed, 29 May 2002 21:32:11 -0400
From: Steven Augart <steve@Augart.com>
To: linux-kernel@vger.kernel.org
Subject: linux-2.5.18: fs/hfs/inode.c: PATCH to fix compilation error
Cc: Brad Littlejohn <tyketto@wizard.com>, John Weber <john.weber@linuxhq.com>
Message-Id: <20020530013158.2DCBE3DF2@abruzzo.augart.com>
Date: Wed, 29 May 2002 18:31:58 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: Patch to fix compilation error in linux-2.5.18/fs/hfs/inode.c

This patch fixes a compilation error in linux-2.5.18/fs/hfs/inode.c,
where gcc 2.95.3 complains that it does not have a complete definition
for `struct page' in hfs_prepare_write().   The exact error message
given is:

  inode.c: In function `hfs_prepare_write':
  inode.c:242: dereferencing pointer to incomplete type

To give credit where due, after I fixed this bug I found that
suggested fixes have also been sent in by 
Alexander Viro <viro@math.psu.edu>, by Christoph Hellwig
<hch@infradead.org>, and by Jan Harkes <jaharkes@cs.cmu.edu>

The compilation problem has already been reported by Brad Littlejohn
<tyketto@wizard.com> and John Weber <john.weber@linuxhq.com>.

Steven Augart
steve@augart.com


diff -ur linux-2.5.18/fs/hfs/inode.c linux-2.5.18+/fs/hfs/inode.c
--- linux-2.5.18/fs/hfs/inode.c Thu May  9 15:24:20 2002
+++ linux-2.5.18+/fs/hfs/inode.c        Tue May 28 17:23:06 2002
@@ -21,6 +21,7 @@
 #include <linux/hfs_fs_i.h>
 #include <linux/hfs_fs.h>
 #include <linux/smp_lock.h>
+#include <linux/mm.h>          /* for struct page */
 
 /*================ Variable-like macros ================*/
 
