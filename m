Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130309AbRA0NS4>; Sat, 27 Jan 2001 08:18:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130355AbRA0NSq>; Sat, 27 Jan 2001 08:18:46 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:41222 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S130309AbRA0NSa>;
	Sat, 27 Jan 2001 08:18:30 -0500
Date: Sat, 27 Jan 2001 14:17:30 +0100
From: Jens Axboe <axboe@suse.de>
To: Andre Hedrick <andre@linux-ide.org>
Cc: jacob@chaos2.org, linux-kernel@vger.kernel.org
Subject: Re: hdd: set_drive_speed_status: status=0x51 { DriveReady SeekComplete Error }
Message-ID: <20010127141730.C27929@suse.de>
In-Reply-To: <Pine.LNX.4.21.0101252046320.13852-100000@inbetween.blorf.net> <Pine.LNX.4.10.10101270047200.23960-100000@master.linux-ide.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.10.10101270047200.23960-100000@master.linux-ide.org>; from andre@linux-ide.org on Sat, Jan 27, 2001 at 12:48:11AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 27 2001, Andre Hedrick wrote:
> > I've been getting this during the boot sequence for quite some time now.
> > They don't seem to impact the functionality of the drive any though.  Just
> > another extra-verbose kernel message I should ignore?  :)
> > 
> > (This is from the 2.4.1-pre10 btw.)
> > 
> > hdd: CD-ROM TW 120D, ATAPI CD/DVD-ROM drive
> > hdd: set_drive_speed_status: status=0x51 { DriveReady SeekComplete Error }
> > hdd: set_drive_speed_status: error=0x04
> 
> Means your device did not like that command and barfed.
> status=0x51, error=0x04 == command aborted next....

My gut tells me that this is the 'get last written' command, and even
with the quiet flag we get the IDE error status printed. Could you
try and add

	goto use_toc;

add the top of drivers/cdrom/cdrom.c:cdrom_get_last_written() and
see if that makes the error disappear?

-- 
* Jens Axboe <axboe@suse.de>
* SuSE Labs
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
