Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268079AbRHGUaU>; Tue, 7 Aug 2001 16:30:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269223AbRHGUaL>; Tue, 7 Aug 2001 16:30:11 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:37898 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S268079AbRHGU3x>;
	Tue, 7 Aug 2001 16:29:53 -0400
Date: Tue, 7 Aug 2001 22:29:55 +0200
From: Jens Axboe <axboe@suse.de>
To: Alex Romosan <romosan@adonis.lbl.gov>
Cc: linux-kernel@vger.kernel.org
Subject: Re: oops with 2.4.8-pre5
Message-ID: <20010807222955.H24336@suse.de>
In-Reply-To: <87bslrfx9n.fsf@adonis.lbl.gov> <20010807221746.G24336@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Pd0ReVV5GZGQvF3a"
Content-Disposition: inline
In-Reply-To: <20010807221746.G24336@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Pd0ReVV5GZGQvF3a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 07 2001, Jens Axboe wrote:
> On Tue, Aug 07 2001, Alex Romosan wrote:
> > i got the following oops with kernel 2.4.8-pre5. i was just logged in
> > remotely, reading email with gnus and maybe i had just run dselect
> > (debian package installer):
> 
> This should fix it.

Eh scratch that braino, here's a right one...

-- 
Jens Axboe


--Pd0ReVV5GZGQvF3a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=sync_old_buffers-2

--- /opt/kernel/linux-2.4.8-pre5/fs/buffer.c	Tue Aug  7 10:28:50 2001
+++ fs/buffer.c	Tue Aug  7 22:30:53 2001
@@ -2581,10 +2472,13 @@
 
 			spin_lock(&lru_list_lock);
 			bh = lru_list[BUF_DIRTY];
+			if (!bh)
+				goto quit;
 			if (!time_before(jiffies, bh->b_flushtime))
 				continue;
 			spin_unlock(&lru_list_lock);
 		}
+quit:
 		run_task_queue(&tq_disk);
 		return 0;
 	}

--Pd0ReVV5GZGQvF3a--
