Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262865AbRFRWMY>; Mon, 18 Jun 2001 18:12:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262995AbRFRWMP>; Mon, 18 Jun 2001 18:12:15 -0400
Received: from dryline-fw.yyz.somanetworks.com ([216.126.67.45]:27426 "EHLO
	dryline-fw.wireless-sys.com") by vger.kernel.org with ESMTP
	id <S262865AbRFRWMF>; Mon, 18 Jun 2001 18:12:05 -0400
Date: Mon, 18 Jun 2001 18:12:00 -0400 (EDT)
From: Scott Murray <scottm@somanetworks.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Why can't I flush /dev/ram0? (fwd)
Message-ID: <Pine.LNX.4.30.0106181807490.1182-100000@rancor.yyz.somanetworks.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Any chance you can finally merge this fix or suggest what better one you
are looking for?  When this bug bit me in early April, an investigation
showed that this particular fix has been in the ac kernels since last
November.

Thanks,

Scott


-- 
Scott Murray
SOMA Networks, Inc.
Toronto, Ontario
e-mail: scottm@somanetworks.com

---------- Forwarded message ----------
Date: Mon, 18 Jun 2001 23:55:37 +0200
From: Jan Rekorajski <baggins@sith.mimuw.edu.pl>
To: Kelledin Tane <runesong@earthlink.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Why can't I flush /dev/ram0?

On Mon, 18 Jun 2001, Kelledin Tane wrote:

> At this point, I'm trying to get an initrd working properly.  So far, it
> works, the system boots, etc. etc., but whenever I try to do a "blockdev
> --flushbufs /dev/ram0", I get "device or resource busy"
>
> When I mount the filesystem to check it out, nothing appears to have
> anything open on the filesystem.  So why am I not able to flush it
> clean?

Because of a bug present in Linus tree. Try this patch:

--- linux.orig/drivers/block/rd.c	Mon Nov 20 02:07:47 2000
+++ linux/drivers/block/rd.c	Mon Nov 20 04:03:42 2000
@@ -690,6 +690,7 @@
 done:
 	if (infile.f_op->release)
 		infile.f_op->release(inode, &infile);
+	blkdev_put(out_inode->i_bdev, BDEV_FILE);
 	set_fs(fs);
 	return;
 free_inodes: /* free inodes on error */

BTW, it's fixed in -ac patches.

Jan
-- 
Jan Rêkorajski            |  ALL SUSPECTS ARE GUILTY. PERIOD!
baggins<at>mimuw.edu.pl   |  OTHERWISE THEY WOULDN'T BE SUSPECTS, WOULD THEY?
BOFH, MANIAC              |                   -- TROOPS by Kevin Rubio
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

