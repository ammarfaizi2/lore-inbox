Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261894AbRFRV4E>; Mon, 18 Jun 2001 17:56:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261628AbRFRVzy>; Mon, 18 Jun 2001 17:55:54 -0400
Received: from sith.mimuw.edu.pl ([193.0.97.1]:51206 "EHLO sith.mimuw.edu.pl")
	by vger.kernel.org with ESMTP id <S261561AbRFRVzp>;
	Mon, 18 Jun 2001 17:55:45 -0400
Date: Mon, 18 Jun 2001 23:55:37 +0200
From: Jan Rekorajski <baggins@sith.mimuw.edu.pl>
To: Kelledin Tane <runesong@earthlink.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Why can't I flush /dev/ram0?
Message-ID: <20010618235537.B17458@sith.mimuw.edu.pl>
Mail-Followup-To: Jan Rekorajski <baggins@sith.mimuw.edu.pl>,
	Kelledin Tane <runesong@earthlink.net>,
	linux-kernel@vger.kernel.org
In-Reply-To: <3B2E6EA3.3DED7D95@earthlink.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.17i
In-Reply-To: <3B2E6EA3.3DED7D95@earthlink.net>; from runesong@earthlink.net on Mon, Jun 18, 2001 at 04:12:03PM -0500
X-Operating-System: Linux 2.4.5-pre3-xfs i686
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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
