Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315491AbSE2VJo>; Wed, 29 May 2002 17:09:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315503AbSE2VJn>; Wed, 29 May 2002 17:09:43 -0400
Received: from pop016pub.verizon.net ([206.46.170.173]:30392 "EHLO
	pop016.verizon.net") by vger.kernel.org with ESMTP
	id <S315491AbSE2VJm>; Wed, 29 May 2002 17:09:42 -0400
Date: Wed, 29 May 2002 17:13:59 -0400
From: Skip Ford <skip.ford@verizon.net>
To: Wayne.Brown@altec.com
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] Re: ufs compile error in 2.5.19
Mail-Followup-To: Wayne.Brown@altec.com,
	lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <86256BC8.006DB41A.00@smtpnotes.altec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Message-Id: <20020529210938.DYLF24507.pop016.verizon.net@pool-141-150-239-239.delv.east.verizon.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wayne.Brown@altec.com wrote:
> 
> truncate.c: In function `ufs_truncate':
> truncate.c:456: `tq_disk' undeclared (first use in this function)
> truncate.c:456: (Each undeclared identifier is reported only once
> truncate.c:456: for each function it appears in.)
> make[2]: *** [truncate.o] Error 1
> make[2]: Leaving directory `/usr/src/linux-2.5.19/fs/ufs'

I guess this is right...

--- linux/fs/ufs/truncate.c	Wed May 29 16:59:56 2002
+++ linux/fs/ufs/truncate.c	Wed May 29 17:03:57 2002
@@ -453,7 +453,7 @@
 			break;
 		if (IS_SYNC(inode) && (inode->i_state & I_DIRTY))
 			ufs_sync_inode (inode);
-		run_task_queue(&tq_disk);
+		blk_run_queues();
 		yield();
 	}
 	offset = inode->i_size & uspi->s_fshift;

-- 
Skip
