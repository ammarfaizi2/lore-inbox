Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317040AbSFFS0g>; Thu, 6 Jun 2002 14:26:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317045AbSFFS0f>; Thu, 6 Jun 2002 14:26:35 -0400
Received: from [195.39.17.254] ([195.39.17.254]:39328 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S317040AbSFFS0e>;
	Thu, 6 Jun 2002 14:26:34 -0400
Date: Sun, 2 Jun 2002 05:46:22 +0000
From: Pavel Machek <pavel@suse.cz>
To: Andrew Morton <akpm@zip.com.au>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [rfc] "laptop mode"
Message-ID: <20020602054621.E121@toy.ucw.cz>
In-Reply-To: <3CFD453A.B6A43522@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> laptop_mode
> -----------
> 
> Setting this entry to '1' will put the kernel's dirty data writeout
> algorithms into a mode which is better suited to laptop/notebook
> computers.  This mode is specifically designed to minimise the
> frequency of disk spinups.  Laptop mode works as follows:
> 
> - Dirty data remains in memory for longer periods of time (controlled
>   by laptop_writeback_centisecs).
> 
> - If there is pending dirty data and the disk is spun up for any
>   reason (even for a read) then all dirty data will be written back
>   shortly afterwards.  ie: when the disk is spun up, make good use of
>   it.
> 
> - When the decision is made to write back some dirty data, the kernel
>   will write back all dirty data.

Nice!

> laptop_writeback_centisecs
> --------------------------
> 
> This tunable determines the maximum age of dirty data when the machine
> is operating in Laptop mode.  The default value is 30000 - five

Well, I run my notebooks in similar mode with writeback set essentialy to
infinity. I do it even on my home server....

> This implementation doesn't try to be very smart - there's a direct
> call out of do_ide_request() into the writeback code.  This couldn't
> be done from within ll_rw_blk.c because then a write to the ramdisk
> would spin the disk up.   Even as-is, a read from the IDE CDROM
> drive will cause the IDE hard disk to spin up and flush data, so

It would  nice to do this per disk.... If you have server with one active
and one inactive disk, you want the inactive one to sleep.
								Pavel
-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

