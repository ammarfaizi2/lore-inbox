Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293161AbSCZJGh>; Tue, 26 Mar 2002 04:06:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293242AbSCZJG1>; Tue, 26 Mar 2002 04:06:27 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:38407 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S293161AbSCZJGQ>;
	Tue, 26 Mar 2002 04:06:16 -0500
Date: Tue, 26 Mar 2002 10:06:16 +0100
From: Jens Axboe <axboe@suse.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH][CFT] cd-mrw support, version 2
Message-ID: <20020326090616.GF1865@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Version 2 of Linux Mt Rainier CD-MRW support. Changes since the first
version:

kernel parts:

- Add SCSI CD-ROM support:
	- Move check for mrw drive into the uniform layer
	- add small probe checks in sr for writeable or not
	- Add extra parameter to sr_do_ioctl to specify timeout
- Remove cdrom_exit, add ->exit() to cdrom_device_info instead
- Probe mt rainier mode page used by drive. Can be either 0x2c for the
  first drives before the mode page was standardised (my Philips
  prototype uses this), or the now official 0x03.
- Set lba address space to GAA on open as required by spec

Various changes to the user space app, judging from the feedback from
last time the far most interesting feature is that it has been renamed
to 'cdmrw' instead of 'mtr'. To compile cdmrw, you will need to copy
include/linux/cdrom.h to /usr/include/cdrom.h

Patch:

*.kernel.org/pub/linux/kernel/people/axboe/patches/v2.4/2.4.19-pre4/cd-mrw-2.bz2

Tool:

*.kernel.org/pub/linux/kernel/people/axboe/tools/cdmrw.c

-- 
Jens Axboe

