Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281488AbRK0QW3>; Tue, 27 Nov 2001 11:22:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281478AbRK0QWU>; Tue, 27 Nov 2001 11:22:20 -0500
Received: from d12lmsgate.de.ibm.com ([195.212.91.199]:20908 "EHLO
	d12lmsgate.de.ibm.com") by vger.kernel.org with ESMTP
	id <S281488AbRK0QWE>; Tue, 27 Nov 2001 11:22:04 -0500
Subject: 2 questions (block_dev.c / buffer.c)
To: andrea@suse.de, adilger@turbolabs.com, viro@math.psu.edu
Cc: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.5  September 22, 2000
Message-ID: <OF39EFBD00.35397351-ONC1256B11.00576287@de.ibm.com>
From: "Stefan Bader" <Stefan.Bader@de.ibm.com>
Date: Tue, 27 Nov 2001 17:19:08 +0100
X-MIMETrack: Serialize by Router on D12ML008/12/M/IBM(Release 5.0.8 |June 18, 2001) at
 27/11/2001 17:19:44
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've gor two short question regarding the changes that got into the kernel
since
about 2.4.14 (I think)

1. block_dev.c (blkdev_get())
     This function doesn't increment the refrence count for the bdev via
     acquire_inode (or bdget). The error path in do_open as well as
     blkdev_put however decrease the count.
     Shouldn't there be an acquire_inode(bdev->bd_inode) ?

2. buffer.c (invalidate_bdev())
     This now prints a message whenever bh->bd_count is not 0.
     However this is always the case when doing an BLKFLSBUF
     ioctl on a device with an mount FS on it.
     (All the reported buffer heads belong AFAICS to the super block
     data of the filesystem)
     This seemed to be the case before (just silently ignored) so I guess
     it is not a terribly bad thing. But its a bit anoying and may lead to
suspect
     errors at the wrong end...
     Was the intention to complain always like now or just in the destroy
case?

Regards,
Stefan Bader


Linux for eServer development
Stefan.Bader@de.ibm.com
----------------------------------------------------------------------------------

  When all other means of communication fail, try words.

