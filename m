Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263796AbTEFPNN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 11:13:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263800AbTEFPNN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 11:13:13 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:28830 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S263796AbTEFPNL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 11:13:11 -0400
Date: Tue, 6 May 2003 17:25:43 +0200
From: Jens Axboe <axboe@suse.de>
To: Pascal Schmidt <der.eremit@email.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [IDE] trying to make MO drive work with ide-floppy/ide-cd
Message-ID: <20030506152543.GX905@suse.de>
References: <20030506140751.GA25817@suse.de> <Pine.LNX.4.44.0305061715150.965-100000@neptune.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0305061715150.965-100000@neptune.local>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 06 2003, Pascal Schmidt wrote:
> On Tue, 6 May 2003, Jens Axboe wrote:
> 
> > It barfs at a lot of commands, not surprisingly. ide-cd really has no
> > concept of devices other than cd/dvd.
> 
> I'm not complaining about those messages. ;)

No, but clearly something is wrong. At least that you should agree on.
And knowing hardware, there are probably drives out there that just wont
work because of the various "weird" commands it gets sent.

Just because it happens to work for you doesn't make it a viable
solution.

> > You need to patch cdrom.c as well:
> > 
> > 	if ((fp->f_mode & FMODE_WRITE) && !CDROM_CAN(CDC_DVD_RAM))
> > 		return -EROFS;
> > 
> 
> Simply removing that test doesn't get me working write support,
> I still get:
> 
> # mount -t ext2 /dev/hde /mnt/mo
> mount: block device /dev/hde is write-protected, mounting read-only
> 
> The disk is not write-protected, I checked.

Shouldn't matter, the drive has to check for that particular bit (and it
obviously does not). Are we still talking 2.5 or 2.4?

> >> What can I do to help get this drive supported under 2.5/ide-cd?
> > I'm tempted to say ide-scsi + sd, but that goes against my principles...
> > It shouldn't be too much work to make ide-cd work gracefully.
> 
> Well, I'm not familiar with the code at all, so I don't know where
> to look.

You can play with the c code, you've demonstrated that much so far. So
play some more, find out which commands are aborted and why. The log
messages even tell you which ones. Now find out if these are necessary
for proper MO functionality or not. Or maybe some vital commands are
even missing, lots of fun there :). But it really should not be very
hard.

-- 
Jens Axboe

