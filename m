Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263212AbTJPUvV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Oct 2003 16:51:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263214AbTJPUvV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Oct 2003 16:51:21 -0400
Received: from mcomail04.maxtor.com ([134.6.76.13]:23311 "EHLO
	mcomail04.maxtor.com") by vger.kernel.org with ESMTP
	id S263212AbTJPUvT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Oct 2003 16:51:19 -0400
Message-ID: <785F348679A4D5119A0C009027DE33C105CDB2D0@mcoexc04.mlm.maxtor.com>
From: "Mudama, Eric" <eric_mudama@Maxtor.com>
To: "'Greg Stark'" <gsstark@mit.edu>
Cc: "'Jens Axboe'" <axboe@suse.de>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] ide write barrier support
Date: Thu, 16 Oct 2003 14:51:13 -0600
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Greg Stark
>
> Ideally postgres just needs to call some kind of fsync 
> syscall that guarantees
> it won't return until all buffers from the file that were 
> dirty prior to the
> sync were flushed and the disk was really synced. It's fine 
> for buffers that
> were dirtied later to get synced as well, as long as all the 
> old buffers are
> all synced.

This checkpointing doesn't exist in ATA, only in SCSI I think.  You can get
similar behavior in ATA-7 capable drives (which I don't think are on the
market yet) by issuing FUA commands.  These will not return good status
until the data is on the media, and they can be intermingled with other
cached writes without destroying overall performance.

If there was some way to define a file as FUA instead of normal, then you'd
know every write to it would be on the media if the status was good.
However, you may have committed your journal or whatever and have possibly
significantly stale data on the drive's cache in the user data area.

As far as the actual file-system call mechanism to achive this, I have no
idea... I know very little about linux internals, I just try to answer
disk-related questions.

--eric
