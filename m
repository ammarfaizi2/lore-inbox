Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269420AbRHGUcK>; Tue, 7 Aug 2001 16:32:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269421AbRHGUcA>; Tue, 7 Aug 2001 16:32:00 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:40970 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S269420AbRHGUbs>;
	Tue, 7 Aug 2001 16:31:48 -0400
Date: Tue, 7 Aug 2001 22:31:50 +0200
From: Jens Axboe <axboe@suse.de>
To: Alex Romosan <romosan@adonis.lbl.gov>
Cc: linux-kernel@vger.kernel.org
Subject: Re: oops with 2.4.8-pre5
Message-ID: <20010807223150.I24336@suse.de>
In-Reply-To: <87bslrfx9n.fsf@adonis.lbl.gov> <20010807221746.G24336@suse.de> <20010807222955.H24336@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="H8ygTp4AXg6deix2"
Content-Disposition: inline
In-Reply-To: <20010807222955.H24336@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--H8ygTp4AXg6deix2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 07 2001, Jens Axboe wrote:
> On Tue, Aug 07 2001, Jens Axboe wrote:
> > On Tue, Aug 07 2001, Alex Romosan wrote:
> > > i got the following oops with kernel 2.4.8-pre5. i was just logged in
> > > remotely, reading email with gnus and maybe i had just run dselect
> > > (debian package installer):
> > 
> > This should fix it.
> 
> Eh scratch that braino, here's a right one...

Too tired, or something... I think I'll stop for today.

-- 
Jens Axboe


--H8ygTp4AXg6deix2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename=sync_old_buffers-3

--- /opt/kernel/linux-2.4.8-pre5/fs/buffer.c	Tue Aug  7 10:28:50 2001
+++ fs/buffer.c	Tue Aug  7 22:32:36 2001
@@ -2581,10 +2472,15 @@
 
 			spin_lock(&lru_list_lock);
 			bh = lru_list[BUF_DIRTY];
+			if (!bh) {
+				spin_unlock(&lru_list_lock);
+				goto quit;
+			}
 			if (!time_before(jiffies, bh->b_flushtime))
 				continue;
 			spin_unlock(&lru_list_lock);
 		}
+quit:
 		run_task_queue(&tq_disk);
 		return 0;
 	}

--H8ygTp4AXg6deix2--
