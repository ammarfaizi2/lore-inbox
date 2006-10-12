Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751360AbWJLMJT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751360AbWJLMJT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 08:09:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751354AbWJLMJT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 08:09:19 -0400
Received: from brick.kernel.dk ([62.242.22.158]:32627 "EHLO kernel.dk")
	by vger.kernel.org with ESMTP id S1751360AbWJLMJR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 08:09:17 -0400
Date: Thu, 12 Oct 2006 14:09:27 +0200
From: Jens Axboe <jens.axboe@oracle.com>
To: Mike Galbraith <efault@gmx.de>
Cc: Alex Romosan <romosan@sycorax.lbl.gov>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.19-rc1 regression: unable to read dvd's
Message-ID: <20061012120927.GQ6515@kernel.dk>
References: <87hcya8fxk.fsf@sycorax.lbl.gov> <20061012065346.GY6515@kernel.dk> <1160648885.5897.6.camel@Homer.simpson.net> <1160662435.6177.3.camel@Homer.simpson.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1160662435.6177.3.camel@Homer.simpson.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 12 2006, Mike Galbraith wrote:
> On Thu, 2006-10-12 at 10:28 +0000, Mike Galbraith wrote:
> > On Thu, 2006-10-12 at 08:53 +0200, Jens Axboe wrote:
> > > Test case, please.
> > 
> > Xine.
> > 
> > I just built it from scratch(the one that comes with SuSE 10.1 is
> > useless for DVDs), and tried it in 2.6.19-rc1 after verifying that it
> > worked fine in 2.6.17.
> 
> s/17/18
> 
> > hdd: BENQ DVD DD DW1625, ATAPI CD/DVD-ROM drive
> > hdd: ATAPI 63X DVD-ROM DVD-R CD-R/RW drive, 2048kB Cache, UDMA(33)
> > 
> > hdd: read_intr: Drive wants to transfer data the wrong way!
> > hdd: read_intr: Drive wants to transfer data the wrong way!
> 
> We're having secret handshake troubles?
> 
> [pid  8348] stat64("/dev/dvd", {st_dev=makedev(0, 13), st_ino=3750, st_mode=S_IFBLK|0640, st_nlink=1, st_uid=0, st_gid=6, st_blksize=4096, st_blocks=0, st_rdev=makedev(22, 64), st_atime=2006/10/12-10:03:04, st_mtime=2006/10/12-10:00:12, st_ctime=2006/10/12-10:00:17}) = 0
> [pid  8348] open("/dev/dvd", O_RDONLY|O_LARGEFILE <unfinished ...>
> [pid  8348] <... open resumed> )        = 8
> [pid  8348] fstat64(8, {st_dev=makedev(0, 13), st_ino=3750, st_mode=S_IFBLK|0640, st_nlink=1, st_uid=0, st_gid=6, st_blksize=4096, st_blocks=0, st_rdev=makedev(22, 64), st_atime=2006/10/12-10:03:04, st_mtime=2006/10/12-10:00:12, st_ctime=2006/10/12-10:00:17}) = 0
> [pid  8348] ioctl(8, DVD_READ_STRUCT <unfinished ...>
> [pid  8348] <... ioctl resumed> , 0xbfc792a4) = 0
> [pid  8348] ioctl(8, DVD_AUTH <unfinished ...>
> [pid  8348] <... ioctl resumed> , 0xbfc7916c) = 0
> [pid  8348] ioctl(8, DVD_AUTH <unfinished ...>
> [pid  8348] <... ioctl resumed> , 0xbfc7916c) = 0
> [pid  8348] ioctl(8, DVD_AUTH <unfinished ...>
> [pid  8348] <... ioctl resumed> , 0xbfc7916c) = 0
> [pid  8348] ioctl(8, DVD_AUTH <unfinished ...>
> [pid  8348] <... ioctl resumed> , 0xbfc79170) = 0
> [pid  8348] close(8)                    = 0
> [pid  8348] write(2, "libdvdread: Could not open /dev/"..., 52 <unfinished ...>
> [pid  8348] <... write resumed> )       = 52
> [pid  8348] write(2, "libdvdread: Can\'t open /dev/dvd "..., 44 <unfinished ...>
> [pid  8348] <... write resumed> )       = 44
> [pid  8348] write(1, "libdvdnav: vm: faild to open/rea"..., 42 <unfinished ...>
> [pid  8348] <... write resumed> )       = 42
> [pid  8348] write(1, "libdvdnav: Using dvdnav version "..., 62 <unfinished ...>
> [pid  8348] <... write resumed> )       = 62
> [pid  8348] write(2, "libdvdread: Using libdvdcss vers"..., 57 <unfinished ...>
> [pid  8348] <... write resumed> )       = 57

It's the rq-cmd-type patch, it must be causing a disturbance for some of
the internal cd commands. I bet it's the same thing affecting the report
on broken dvd identification on ppc from Olaf.

-- 
Jens Axboe

