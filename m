Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132672AbRDOOZQ>; Sun, 15 Apr 2001 10:25:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132675AbRDOOZG>; Sun, 15 Apr 2001 10:25:06 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:63753 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S132672AbRDOOY5>;
	Sun, 15 Apr 2001 10:24:57 -0400
Date: Sun, 15 Apr 2001 16:24:51 +0200
From: Jens Axboe <axboe@suse.de>
To: Arjan Filius <iafilius@xs4all.nl>
Cc: linux-kernel@vger.kernel.org, linux-lvm@msede.com
Subject: Re: 2.4.4-pre3: lvm.c patch results in "hanging" mount or swapon
Message-ID: <20010415162451.F1982@suse.de>
In-Reply-To: <Pine.LNX.4.31.0104151444130.1050-100000@sjoerd.sjoerdnet>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="WIyZ46R2i8wDzkSu"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.31.0104151444130.1050-100000@sjoerd.sjoerdnet>; from iafilius@xs4all.nl on Sun, Apr 15, 2001 at 02:55:53PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--WIyZ46R2i8wDzkSu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Apr 15 2001, Arjan Filius wrote:
> Hello,
> 
> While trying kernel 2.4.4-pre3 i found a "hanging" swapon (my swap is on
> LVM), same effect for "mount -a". 2.4.3 works properly.
> 
> I found ./drivers/md/lvm.c is patched, and restoring the lvm.c from 2.4.3
> resulted in normal operation.
> 
> I Found LVM/0.9.1_beta7 makes some notes about the patch, so i tried that
> (beta7), but no luck, only 2.4.3:lvm.c worked ok.

Small buglet in the buffer_IO_error out path, I maybe that's it...

-- 
Jens Axboe


--WIyZ46R2i8wDzkSu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=lvm-eout-1

--- /opt/kernel/linux-2.4.4-pre3/drivers/md/lvm.c	Sun Apr 15 16:24:13 2001
+++ drivers/md/lvm.c	Sun Apr 15 16:23:36 2001
@@ -1675,8 +1675,10 @@
 			       struct buffer_head *bh)
 {
 	int ret = lvm_map(bh, rw);
-	if (ret < 0)
+	if (ret < 0) {
+		ret = 0;
 		buffer_IO_error(bh);
+	}
 	return ret;
 }
 

--WIyZ46R2i8wDzkSu--
