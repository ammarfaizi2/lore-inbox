Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266716AbTBXLba>; Mon, 24 Feb 2003 06:31:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266735AbTBXLba>; Mon, 24 Feb 2003 06:31:30 -0500
Received: from draco.cus.cam.ac.uk ([131.111.8.18]:44218 "EHLO
	draco.cus.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S266716AbTBXLb3>; Mon, 24 Feb 2003 06:31:29 -0500
Date: Mon, 24 Feb 2003 11:41:41 +0000 (GMT)
From: Anton Altaparmakov <aia21@cantab.net>
To: Christoph Hellwig <hch@infradead.org>
cc: linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net
Subject: Re: [ANN] NTFS 2.1.1a for kernel 2.4.20 released
In-Reply-To: <20030224113350.A3452@infradead.org>
Message-ID: <Pine.SOL.3.96.1030224113630.3583G-100000@draco.cus.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Feb 2003, Christoph Hellwig wrote:
> On Mon, Feb 24, 2003 at 11:12:39AM +0000, Anton Altaparmakov wrote:
> > NTFS 2.1.1a is now released for kernel 2.4.20. This fixes both the
> > reported hangs and improves the handling of compressed files so that the
> > warning message people keep reporting is now gone. (Note the hangs were
> > specific to the 2.4.x kernel ntfs versions. 2.5.x kernel ntfs versions
> > are not affected.)
> 
> This:
> 
> @@ -8,6 +8,7 @@ enum km_type {
>         KM_USER0,
> 	KM_USER1,
> 	KM_BH_IRQ,
> +       KM_BIO_IRQ,
> 	KM_TYPE_NR
> };
> 
> is bogus.  You should be using KM_BH_IRQ.

I believe that wouldn't work because the ntfs code using KM_BIO_IRQ is in
the asynchronous i/o completion handler during which time KM_BH_IRQ may
well be in use. At least I don't think it is worth the risk using it...
Have a look at what the ntfs code does in
fs/ntfs/aops.c::ntfs_end_buffer_async_read() for example. 

> And btw, 2.4.21-pre now has ->alloc_inode and ->destroy_inode, use them :)

Cool, but the patch is for 2.4.20... But thanks for the pointer. Once
2.4.21 is out we will move to them. That will make the 2.4.x and 2.5.x
drivers more simillar at the same time. (-: Once the iget5_locked()
patches go in the drivers will become almost identical which will be very
cool...

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cantab.net> (replace at with @)
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

