Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263445AbTDXFCT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 01:02:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263608AbTDXFCS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 01:02:18 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:53471 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S263445AbTDXFCH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 01:02:07 -0400
Date: Thu, 24 Apr 2003 10:49:12 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: bcrl@redhat.com, akpm@digeo.com
Cc: linux-kernel@vger.kernel.org, linux-aio@kvack.org,
       linux-fsdevel@vger.kernel.org
Subject: [5/7] Filesystem AIO rdwr - use down_wq for aio write
Message-ID: <20030424104912.E2288@in.ibm.com>
Reply-To: suparna@in.ibm.com
References: <20030424102221.A2166@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030424102221.A2166@in.ibm.com>; from suparna@in.ibm.com on Thu, Apr 24, 2003 at 10:22:22AM +0530
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 24, 2003 at 10:22:22AM +0530, Suparna Bhattacharya wrote:
> Here is a revised version of the filesystem AIO patches
> for 2.5.68.
> 
> 05aiowrdown_wq.patch 	: Uses async down for aio write

Will currently compile only for x86, since down_wq
support isn't implemented on other archs.

Regards
Suparna

05aiowrdown_wq.patch
....................
 filemap.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletion(-)


diff -ur -X /home/kiran/dontdiff linux-2.5.68/mm/filemap.c linux-aio-2568/mm/filemap.c
--- linux-2.5.68/mm/filemap.c	Mon Apr 21 23:30:40 2003
+++ linux-aio-2568/mm/filemap.c	Tue Apr 22 00:28:55 2003
@@ -1786,7 +1851,8 @@
 
 	BUG_ON(iocb->ki_pos != pos);
 
-	down(&inode->i_sem);
+	if ((err = down_wq(&inode->i_sem, current->io_wait)))
+		return err;
 	err = generic_file_aio_write_nolock(iocb, &local_iov, 1, 
 						&iocb->ki_pos);
 	up(&inode->i_sem);

-- 
Suparna Bhattacharya (suparna@in.ibm.com)
Linux Technology Center
IBM Software Labs, India

