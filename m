Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315540AbSGJLIh>; Wed, 10 Jul 2002 07:08:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315539AbSGJLIg>; Wed, 10 Jul 2002 07:08:36 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:48591 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S315525AbSGJLIe>;
	Wed, 10 Jul 2002 07:08:34 -0400
Date: Wed, 10 Jul 2002 13:11:15 +0200
From: Jens Axboe <axboe@suse.de>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org
Subject: [PATCH] 2.4 IDE core for 2.5, #2 (was Re: [PATCH] 2.4 IDE core for 2.5)
Message-ID: <20020710111115.GJ3185@suse.de>
References: <20020709102249.GA20870@suse.de> <20020709200711.GA13401@win.tue.nl> <20020710054356.GE3185@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020710054356.GE3185@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 10 2002, Jens Axboe wrote:
> > This afternoon I booted 2.5.25 with your patches and two more,
> > one to prevent an oops when shutting down, the other to fix
> > ethernet cards detection. Started torturing two disks on
> > HPT366. After 3 minutes
> > 
> > 	hde: status error: status=0x50 { DriveReady SeekComplete }
> > 	hde: no DRQ after issuing WRITE
> > 
> > and seven minutes later
> > 
> > 	hde: task_out_intr: status=0x51 { DriveReady SeekComplete Error }
> > 	hde: task_out_intr: error=0x04 { DriveStatusError }
> > 
> > Soon lots of processes were hanging in D. Reboot. e2fsck.
> 
> The above seems to be plain pio, you didn't use multi mode did you? I
> think my current tree has the multi-page multi mode bio issue resolved,
> however I'll test for some hours before sending out the next patch set.

Care to try the next version? I've completely disabled task file i/o
since it does seem to be broken in pio, and fixed the multi-write
multi-page bio bug as well. There are a number of other changes in
there. There are split patches like last time, but also one big patch:

*.kernel.org/pub/linux/kernel/people/axboe/patches/v2.5/2.5.25/

00_25ide-compile-1a
	no changes, rediffed

05_25pci-ids-1a
	no changes, rediffed

10_24ide-core-2
	various fixes, see old/ for the complete list

15_24-misc-bits-2
	added (broken) sparc64 bits. too lazy to revert these right,
	waiting for update

20_ide-build-config-1a
	consolidate config and build split

25_ide-scsi-1
	no changes, rediffed

and finally,

ide24-for-2.5-2
	all of the above

Also pull'able from bk://linux25-24ide@project.bkbits.net/linux25-24ide
(soonish)

-- 
Jens Axboe

