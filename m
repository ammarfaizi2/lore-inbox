Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932184AbWAKI1Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932184AbWAKI1Y (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 03:27:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932317AbWAKI1Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 03:27:24 -0500
Received: from liaag2aa.mx.compuserve.com ([149.174.40.154]:47800 "EHLO
	liaag2aa.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S932184AbWAKI1X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 03:27:23 -0500
Date: Wed, 11 Jan 2006 03:24:11 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [PATCH]trivial: add CDC_RAM to ide-cd capabilities mask
To: Jens Axboe <axboe@suse.de>
Cc: Andrey Borzenkov <arvidjaar@mail.ru>,
       linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200601110327_MC3-1-B5A3-6E0F@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <20060110101346.GO3389@suse.de>

On Tue, 10 Jan 2006, Jens Axboe wrote:

> On Mon, Jan 09 2006, Andrey Borzenkov wrote:
> > -----BEGIN PGP SIGNED MESSAGE-----
> > Hash: SHA1
> > 
> > Add CDC-RAM to capability mask. This prevents udev incorrectly reporting RAM 
> > capabilities for device.
> > 
> > Signed-off-by: Andrey Borzenkov <arvidjaar@mail.ru>
> > 
> > - ---
> > 
> > - --- linux-2.6.15/drivers/ide/ide-cd.c.orig        2006-01-03 06:21:10.000000000 +0300
> > +++ linux-2.6.15/drivers/ide/ide-cd.c       2006-01-09 00:31:32.000000000 +0300
> > @@ -2905,6 +2905,8 @@ static int ide_cdrom_register (ide_drive
> >             devinfo->mask |= CDC_CLOSE_TRAY;
> >     if (!CDROM_CONFIG_FLAGS(drive)->mo_drive)
> >             devinfo->mask |= CDC_MO_DRIVE;
> > +   if (!CDROM_CONFIG_FLAGS(drive)->ram)
> > +           devinfo->mask |= CDC_RAM;
> >  
> >     devinfo->disk = info->disk;
> >     return register_cdrom(devinfo);
> 
> Thanks, patch is correct.


 There are more problems in that area:

An ancient SCSI CD-ROM reports:

drive name:             sr0
drive speed:            1
drive # of slots:       1
Can close tray:         1
Can open tray:          1
Can lock tray:          1
Can change speed:       0
Can select disk:        0
Can read multisession:  1
Can read MCN:           1
Reports media changed:  1
Can play audio:         1
Can write CD-R:         0
Can write CD-RW:        0
Can read DVD:           0
Can write DVD-R:        0
Can write DVD-RAM:      0
Can read MRW:           1
Can write MRW:          1
Can write RAM:          1

There's no way this drive knows anything about MRW or random-access writing:

[   15.178959]   Vendor: NEC       Model: CD-ROM DRIVE:464  Rev: 1.04
[   15.200086]   Type:   CD-ROM                             ANSI SCSI revision: 02
...
[   16.621463] sr0: scsi-1 drive


And an ATAPI DVD-ROM also reports (before the above patch):

Can read MRW:           1
Can write MRW:          1
Can write RAM:          1


-- 
Chuck
Currently reading: _Olympos_ by Dan Simmons
