Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273345AbRJNCBF>; Sat, 13 Oct 2001 22:01:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273364AbRJNCAp>; Sat, 13 Oct 2001 22:00:45 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:465 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S273345AbRJNCAf>;
	Sat, 13 Oct 2001 22:00:35 -0400
Date: Sat, 13 Oct 2001 22:01:06 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Ed Tomlinson <tomlins@CAM.ORG>
cc: linux-kernel@vger.kernel.org
Subject: Re: mount hanging 2.4.12 
In-Reply-To: <20011013234121.31B3B24D64@oscar.casa.dyndns.org>
Message-ID: <Pine.GSO.4.21.0110132157160.3903-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 13 Oct 2001, Ed Tomlinson wrote:

> Oct 13 19:28:31 oscar kernel: usb-uhci.c: interrupt, status 2, frame# 1147
> Oct 13 19:28:31 oscar kernel:  I/O error: dev 08:01, sector 0
> Oct 13 19:28:31 oscar kernel: FAT: unable to read boot sector
> Oct 13 19:28:31 oscar kernel: VFS: Disk change detected on device sd(8,1)
> Oct 13 19:28:31 oscar kernel: SCSI device sda: 131072 512-byte hdwr sectors (67 MB)
> Oct 13 19:28:31 oscar kernel: sda: Write Protect is on
> Oct 13 19:28:31 oscar kernel:  sda: sda1
> 
> The device is a usb smartmedia reader using the sddr-09 support.

OK, looks like:
	a) ->check_media_change() is screwed for that device.
	b) we are hanging on something interesting.  It isn't ->s_umount
and it's very unlikely to be ->s_lock or mount_sem.  What it might be,
though... I suspect that ->bd_sem is screwed.

	Could you reproduce the hang and then do Alt-Sysrq-T?  That should
give you stack traces.  I'm especially interested in stack trace of hung
mount(8).  It's nice to know that it ends on down(), but knowing what had
called that down() would help big way.

