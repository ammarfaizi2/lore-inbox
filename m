Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129061AbQJaWYh>; Tue, 31 Oct 2000 17:24:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129050AbQJaWY2>; Tue, 31 Oct 2000 17:24:28 -0500
Received: from fw.SuSE.com ([202.58.118.35]:25590 "EHLO linux.local")
	by vger.kernel.org with ESMTP id <S129181AbQJaWYN>;
	Tue, 31 Oct 2000 17:24:13 -0500
Date: Tue, 31 Oct 2000 15:31:06 -0800
From: Jens Axboe <axboe@suse.de>
To: Paul Jakma <paul@clubi.ie>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: scsi-cdrom lockup and ide-scsi problem (both EFS related)
Message-ID: <20001031153106.A9458@suse.de>
In-Reply-To: <Pine.LNX.4.21.0010310054200.1041-100000@fogarty.jakma.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.21.0010310054200.1041-100000@fogarty.jakma.org>; from paul@clubi.ie on Tue, Oct 31, 2000 at 01:11:44AM +0000
X-OS: Linux 2.4.0-test10 i686
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 31 2000, Paul Jakma wrote:
> I have 2 problems related to reading IRIX EFS cd's.
> 
> -------problem 1:
> 
> mounting an EFS cd from my Yamaha CDR-4416S SCSI CDRW consistently
> causes a lockup when i try to read directory/file data from the CD. I
> observed this initially with EFS CDR's, and assumed something had
> gone wrong when burning that CD. But the exact same thing happens
> with original SGI IRIX media. I have no problems with any of my EFS
> CDs when accesed from an ATAPI CDROM.

Known problem, blocksizes != 2kb does not currently work
correctly with SCSI CD-ROM (it's even on Ted's list).

> My IDE CDROM under ide-scsi emulation does not like trying to mount
> EFS CDs, here are the logs of multiple mount attempts:

Same deal, SCSI CD-ROM driver. As you noted, pure ATAPI drive will
work just fine.

> ide-scsi emulation - if i want to mount the CD for any reason i have
> to reboot again to get the IDE CDROM back to pure ATAPI mode, then
> reboot again for ide-scsi to burn a cd... slightly frustrating. :)

rmmod ide-scsi ; insmod ide-cd
mount, etc
rmmod ide-cd ; insmod ide-scsi
burn

-- 
* Jens Axboe <axboe@suse.de>
* SuSE Labs
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
