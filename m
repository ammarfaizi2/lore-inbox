Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269413AbRHGUST>; Tue, 7 Aug 2001 16:18:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269417AbRHGUSK>; Tue, 7 Aug 2001 16:18:10 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:33034 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S269413AbRHGUSC>;
	Tue, 7 Aug 2001 16:18:02 -0400
Date: Tue, 7 Aug 2001 22:17:46 +0200
From: Jens Axboe <axboe@suse.de>
To: Alex Romosan <romosan@adonis.lbl.gov>
Cc: linux-kernel@vger.kernel.org
Subject: Re: oops with 2.4.8-pre5
Message-ID: <20010807221746.G24336@suse.de>
In-Reply-To: <87bslrfx9n.fsf@adonis.lbl.gov>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="6c2NcOVqGQ03X4Wi"
Content-Disposition: inline
In-Reply-To: <87bslrfx9n.fsf@adonis.lbl.gov>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--6c2NcOVqGQ03X4Wi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 07 2001, Alex Romosan wrote:
> i got the following oops with kernel 2.4.8-pre5. i was just logged in
> remotely, reading email with gnus and maybe i had just run dselect
> (debian package installer):

This should fix it.

-- 
Jens Axboe


--6c2NcOVqGQ03X4Wi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=sync_old_buffers-1

--- /opt/kernel/linux-2.4.8-pre5/fs/buffer.c	Tue Aug  7 10:28:50 2001
+++ fs/buffer.c	Tue Aug  7 22:17:51 2001
@@ -2581,13 +2472,17 @@
 
 			spin_lock(&lru_list_lock);
 			bh = lru_list[BUF_DIRTY];
+			if (!bh)
+				break;
 			if (!time_before(jiffies, bh->b_flushtime))
 				continue;
 			spin_unlock(&lru_list_lock);
 		}
 		run_task_queue(&tq_disk);
-		return 0;
+		break;
 	}
+
+	return 0;
 }
 
 int block_sync_page(struct page *page)

--6c2NcOVqGQ03X4Wi--
