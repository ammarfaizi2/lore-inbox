Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261166AbTENHzQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 03:55:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261175AbTENHzQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 03:55:16 -0400
Received: from 12-234-34-139.client.attbi.com ([12.234.34.139]:36340 "EHLO
	heavens.murgatroid.com") by vger.kernel.org with ESMTP
	id S261166AbTENHzP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 03:55:15 -0400
Date: Wed, 14 May 2003 01:08:02 -0700
From: Christopher Hoover <ch@murgatroid.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com, ch@murgatroid.com
Subject: Re: [PATCH] 2.5.68: Don't include SCSI block ioctls on non-scsi systems
Message-ID: <20030514010801.A4080@heavens.murgatroid.com>
References: <20030513202710.A32666@heavens.murgatroid.com> <20030514065752.A647@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030514065752.A647@infradead.org>; from hch@infradead.org on Wed, May 14, 2003 at 06:57:52AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 14, 2003 at 06:57:52AM +0100, Christoph Hellwig wrote:
> On Tue, May 13, 2003 at 08:29:20PM -0700, Christopher Hoover wrote:
> > Unless I'm missing something, there doesn't seem to be a good reason
> > for the block system to include SCSI ioctls unless there's a SCSI
> > block device (CONFIG_BLK_DEV_SD) in the system.
> 
> That's broken.  You can use them on ide, sd and sr currently.

OK, let's try that again.


diff -X /home/ch/src/dontdiff.txt -Naurp linux-2.5.69.orig/drivers/block/Kconfig linux-2.5.69/drivers/block/Kconfig
--- linux-2.5.69.orig/drivers/block/Kconfig	2003-05-04 16:53:08.000000000 -0700
+++ linux-2.5.69/drivers/block/Kconfig	2003-05-14 00:58:36.000000000 -0700
@@ -348,3 +348,6 @@ config LBD
 
 endmenu
 
+config SCSI_IOCTL
+       bool
+       default y if IDE||SCSI
diff -X /home/ch/src/dontdiff.txt -Naurp linux-2.5.69.orig/drivers/block/Makefile linux-2.5.69/drivers/block/Makefile
--- linux-2.5.69.orig/drivers/block/Makefile	2003-05-04 16:53:37.000000000 -0700
+++ linux-2.5.69/drivers/block/Makefile	2003-05-14 00:58:50.000000000 -0700
@@ -8,7 +8,9 @@
 # In the future, some of these should be built conditionally.
 #
 
-obj-y	:= elevator.o ll_rw_blk.o ioctl.o genhd.o scsi_ioctl.o deadline-iosched.o
+obj-y	:= elevator.o ll_rw_blk.o ioctl.o genhd.o deadline-iosched.o
+
+obj-$(CONFIG_SCSI_IOCTL)	+= scsi_ioctl.o 
 
 obj-$(CONFIG_MAC_FLOPPY)	+= swim3.o
 obj-$(CONFIG_BLK_DEV_FD)	+= floppy.o
