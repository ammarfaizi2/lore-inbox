Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262614AbRFLOFW>; Tue, 12 Jun 2001 10:05:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264475AbRFLOFM>; Tue, 12 Jun 2001 10:05:12 -0400
Received: from roc-24-169-102-121.rochester.rr.com ([24.169.102.121]:43276
	"EHLO roc-24-169-102-121.rochester.rr.com") by vger.kernel.org
	with ESMTP id <S262614AbRFLOFB>; Tue, 12 Jun 2001 10:05:01 -0400
Date: Tue, 12 Jun 2001 10:04:03 -0400
From: Chris Mason <mason@suse.com>
To: Jeff Chua <jeffchua@silk.corp.fedex.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>
cc: Jeff Chua <jchua@silk.corp.fedex.com>
Subject: Re: reiserfs problem on SMP
Message-ID: <274630000.992354643@tiny>
In-Reply-To: <Pine.LNX.4.33.0106121714030.26519-100000@boston.corp.fedex.com>
X-Mailer: Mulberry/2.0.8 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tuesday, June 12, 2001 05:25:46 PM +0800 Jeff Chua <jeffchua@silk.corp.fedex.com> wrote:

> 
> Got the following journaling error on 2.4.5 SMP during shutdown ...
> 

Known 2.4.5 problem.  Fix below is from Al Viro:

-chris

diff -Nru a/fs/super.c b/fs/super.c
--- a/fs/super.c	Sat Jun  2 13:27:07 2001
+++ b/fs/super.c	Sat Jun  2 13:27:07 2001
@@ -873,6 +873,7 @@
 	}
 	spin_unlock(&dcache_lock);
 	down_write(&sb->s_umount);
+	lock_kernel();
 	sb->s_root = NULL;
 	/* Need to clean after the sucker */
 	if (fs->fs_flags & FS_LITTER)
@@ -901,6 +902,7 @@
 	put_filesystem(fs);
 	sb->s_type = NULL;
 	unlock_super(sb);
+	unlock_kernel();
 	up_write(&sb->s_umount);
 	if (bdev) {
 		blkdev_put(bdev, BDEV_FS);

