Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129699AbRCAQWR>; Thu, 1 Mar 2001 11:22:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129706AbRCAQWG>; Thu, 1 Mar 2001 11:22:06 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:63238 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S129699AbRCAQVx>;
	Thu, 1 Mar 2001 11:21:53 -0500
Date: Thu, 1 Mar 2001 17:21:45 +0100
From: Jens Axboe <axboe@suse.de>
To: Mario Hermann <ario@eikon.tum.de>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: report bug: System reboots when accessing a loop-device over a second loop-device with 2.4.2-ac7
Message-ID: <20010301172145.T21518@suse.de>
In-Reply-To: <3A9E66BB.70FB0C75@eikon.tum.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="phCU5ROyZO6kBE05"
Content-Disposition: inline
In-Reply-To: <3A9E66BB.70FB0C75@eikon.tum.de>; from ario@eikon.tum.de on Thu, Mar 01, 2001 at 04:11:55PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--phCU5ROyZO6kBE05
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 01 2001, Mario Hermann wrote:
> I tried the following commands with 2.4.2-ac7:
> 
> losetup /dev/loop0 test.dat
> losetup /dev/loop1 /dev/loop0
> mke2fs /dev/loop1
> 
> My System reboots immediatly. I tried it with 2.4.2-ac4,ac5 too -> same
> effect.
> 
> With 2.4.2 it hangs immediatly.

This should make it work again.

-- 
Jens Axboe


--phCU5ROyZO6kBE05
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename=loop-b_dev-1

--- /opt/kernel/linux-2.4.2-ac7/drivers/block/loop.c	Thu Mar  1 15:46:14 2001
+++ drivers/block/loop.c	Thu Mar  1 17:17:13 2001
@@ -397,10 +397,10 @@
 	if (!buffer_locked(rbh))
 		BUG();
 
-	if (MINOR(rbh->b_dev) >= max_loop)
+	if (MINOR(rbh->b_rdev) >= max_loop)
 		goto out;
 
-	lo = &loop_dev[MINOR(rbh->b_dev)];
+	lo = &loop_dev[MINOR(rbh->b_rdev)];
 	spin_lock_irq(&lo->lo_lock);
 	if (lo->lo_state != Lo_bound)
 		goto inactive;

--phCU5ROyZO6kBE05--
