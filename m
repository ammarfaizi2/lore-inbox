Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262610AbTKNOpn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Nov 2003 09:45:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262652AbTKNOpn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Nov 2003 09:45:43 -0500
Received: from out001pub.verizon.net ([206.46.170.140]:2278 "EHLO
	out001.verizon.net") by vger.kernel.org with ESMTP id S262610AbTKNOpl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Nov 2003 09:45:41 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
To: "Patrick Beard" <patrick@scotcomms.co.uk>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test9 VFAT problem
Date: Fri, 14 Nov 2003 09:45:36 -0500
User-Agent: KMail/1.5.1
References: <20031114113224.GR21265@home.bofhlet.net> <bp2mab$sts$1@sea.gmane.org>
In-Reply-To: <bp2mab$sts$1@sea.gmane.org>
Organization: None that appears to be detectable by casual observers
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200311140945.36537.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out001.verizon.net from [151.205.12.17] at Fri, 14 Nov 2003 08:45:37 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 14 November 2003 08:46, Patrick Beard wrote:
>>> FAT: Bogus number of reserved sectors
>>> VFS: Can't find a valid FAT filesystem on dev sda

I'm not getting these messages, but I did just now run 
into a weird vfat over usb_storage problem.

Camera is an Olympus C-3020, kernel is 2.6.0-test9-mm3, 
the usual configs to allow access to this camera.

The card was about full, so I turned it on and mounted it 
as usual.  Acessing it with filerunner, I started at the 
top of the list, deleting pix I had already downloaded to 
/usr/pix.  I deleted about 15 in the first batch, then 
around 10 in the next batch, and about 20 in the third batch.
Hi-lighting about another 20 and hitting delete got me a 
read-only file system error on the last one, but it did 
delete the rest of them.  I had about 60 left to delete, 
but had to umount the camera and turn it off, turn it back 
on about 10 secs later, and remount the camera (same device 
BTW, thanks guys) about 5 or 6 times before I was able to 
get that 64meg card all cleaned out.

And once again, I have NDI if its buggy software in the 
camera, or a usb_storage problem.

Here is one such section of the messages log:

Nov 14 09:19:51 coyote kernel: hub 3-2:1.0: new USB device on port 3, assigned address 9
Nov 14 09:19:51 coyote kernel: scsi4 : SCSI emulation for USB Mass Storage devices
Nov 14 09:19:52 coyote kernel:   Vendor: OLYMPUS   Model: C-3020ZOOM(U)     Rev: 1.00
Nov 14 09:19:52 coyote kernel:   Type:   Direct-Access                      ANSI SCSI revision: 02
Nov 14 09:19:52 coyote kernel: SCSI device sda: 128000 512-byte hdwr sectors (66 MB)
Nov 14 09:19:52 coyote kernel: sda: Write Protect is off
Nov 14 09:19:52 coyote kernel: sda: assuming drive cache: write through
Nov 14 09:19:52 coyote kernel:  sda: sda1
Nov 14 09:19:52 coyote kernel: Attached scsi removable disk sda at scsi4, channel 0, id 0, lun 0
Nov 14 09:19:52 coyote kernel: Attached scsi generic sg2 at scsi4, channel 0, id 0, lun 0,  type 0
Nov 14 09:20:34 coyote kernel: FAT: Filesystem panic (dev sda1)
Nov 14 09:20:34 coyote kernel:     fat_free: deleting beyond EOF (i_pos 0)
Nov 14 09:20:34 coyote kernel:     File system has been set read-only

The "assigned address" was being incremented per disconnect.
And, /dev/camera is a link to /dev/sda1.  Is this wrong?
However attempting to mount it useing /dev/sg2 fails, not 
a valid block device.

Comments?  Screwed up kernel .config? Is mount "-t vfat" the 
correct filesystem?

Thanks.

-- 
Cheers, Gene
AMD K6-III@500mhz 320M
Athlon1600XP@1400mhz  512M
99.27% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attornies please note, additions to this message
by Gene Heskett are:
Copyright 2003 by Maurice Eugene Heskett, all rights reserved.

