Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130792AbQL0VW6>; Wed, 27 Dec 2000 16:22:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131246AbQL0VWi>; Wed, 27 Dec 2000 16:22:38 -0500
Received: from d185fcbd7.rochester.rr.com ([24.95.203.215]:41994 "EHLO
	d185fcbd7.rochester.rr.com") by vger.kernel.org with ESMTP
	id <S130792AbQL0VWb>; Wed, 27 Dec 2000 16:22:31 -0500
Date: Wed, 27 Dec 2000 15:49:20 -0500
From: Chris Mason <mason@suse.com>
To: Daniel Phillips <phillips@innominate.de>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] changes to buffer.c (was Test12 ll_rw_block error)
Message-ID: <18670000.977950159@coffee>
In-Reply-To: <3A4A505A.3CF8A8BB@innominate.de>
X-Mailer: Mulberry/2.0.6b1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wednesday, December 27, 2000 21:26:02 +0100 Daniel Phillips
<phillips@innominate.de> wrote:

> Hi Chris.  I took your patch for a test drive under dbench and it seems
> impressively stable under load, but there are performance problems.
> 
>	 Test machine: 64 meg, 500 Mhz K6, IDE, Ext2, Blocksize=4K
>	 Without patch: 9.5 MB/sec, 11 min 6 secs
>	 With patch: 3.12 MB/sec, 33 min 51 sec
> 

Cool, thanks for the testing.  Which benchmark are you using?  bonnie and
dbench don't show any changes on my scsi disks, I'll give IDE a try as well.

> Philosophically, I wonder if it's right for the buffer flush mechanism
> to be calling into the filesystem.  It seems like the buffer lists
> should stay sitting between the filesystem and the block layer, it
> actually does a pretty good job.
> 
What I'm looking for is a separation of the write management (aging, memory
pressure, etc, etc) from the actual write method.  The lists (VM, buffer.c,
whatever) should do the management, and the FS should do the i/o.  This
patch is not a perfect solution by any means, but its a start.

-chris


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
