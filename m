Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263834AbTEFPbI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 11:31:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263847AbTEFPbI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 11:31:08 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:2213 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S263834AbTEFPau (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 11:30:50 -0400
Date: Tue, 6 May 2003 17:43:23 +0200
From: Jens Axboe <axboe@suse.de>
To: Pascal Schmidt <der.eremit@email.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [IDE] trying to make MO drive work with ide-floppy/ide-cd
Message-ID: <20030506154323.GE905@suse.de>
References: <20030506140751.GA25817@suse.de> <Pine.LNX.4.44.0305061715150.965-100000@neptune.local> <20030506152543.GX905@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030506152543.GX905@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 06 2003, Jens Axboe wrote:
> > > You need to patch cdrom.c as well:
> > > 
> > > 	if ((fp->f_mode & FMODE_WRITE) && !CDROM_CAN(CDC_DVD_RAM))
> > > 		return -EROFS;
> > > 
> > 
> > Simply removing that test doesn't get me working write support,
> > I still get:
> > 
> > # mount -t ext2 /dev/hde /mnt/mo
> > mount: block device /dev/hde is write-protected, mounting read-only
> > 
> > The disk is not write-protected, I checked.
> 
> Shouldn't matter, the drive has to check for that particular bit (and it
> obviously does not). Are we still talking 2.5 or 2.4?

You also need to fix this in ide-cd:

	if (CDROM_CONFIG_FLAGS(drive)->dvd_ram)
		set_disk_ro(drive->disk, 0);

-- 
Jens Axboe

