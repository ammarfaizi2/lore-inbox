Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263101AbTJPSzU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Oct 2003 14:55:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263106AbTJPSzU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Oct 2003 14:55:20 -0400
Received: from zok.SGI.COM ([204.94.215.101]:35266 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id S263101AbTJPSzO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Oct 2003 14:55:14 -0400
Date: Thu, 16 Oct 2003 11:55:05 -0700
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: I/O errors in -test7-mm1 tree on ia64
Message-ID: <20031016185505.GA1255@sgi.com>
Mail-Followup-To: akpm@osdl.org, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
From: jbarnes@sgi.com (Jesse Barnes)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just compiled and booted -test7-mm1 on an Altix (I needed to create an
empty include/asm-ia64/kgdb.h to get tg3.c to compile), but I'm getting
the following errors after starting init:

NET: Registered protocol family 17
XFS mounting filesystem sdb6
VFS: Mounted root (xfs filesystem) readonly.
Freeing unused kernel memory: 432kB freed
INIT: version 2.78 booting
                        Welcome to SGI ProPack(TM) for Linux(R)
                Press 'I' to enter interactive startup.
Mounting proc filesystem:  [  OK  ]
Configuring kernel parameters:  [  OK  ]
Setting clock  (utc): Thu Oct 16 11:22:35 PDT 2003 [  OK  ]
Setting hostname margin.engr.sgi.com:  [  OK  ]
Checking root filesystem
[/sbin/fsck.xfs (1) -- /] fsck.xfs -a /dev/sdb6
[  OK  ]
Remounting root filesystem in read-write mode:  [  OK  ]
I/O error in filesystem ("sdb6") meta-data dev sdb6 block 0x7d090e       ("xlog_iodone") error 5 buf count 32768
Filesystem "sdb6": Log I/O Error Detected.  Shutting down filesystem: sdb6
Please umount the filesystem, and rectify the problem(s)
can't link lock file /etc/mtab~: Input/output error (use -n flag to override)
INIT: can't open(/etc/ioctl.save, O_WRONLY): Input/output error
INIT: can't open(/etc/ioctl.save, O_WRONLY): Input/output error
INIT: Entering runlevel: 3
INIT: cannot execute "/etc/rc.d/rc"
INIT: cannot execute "/sbin/agetty"
INIT: cannot execute "/sbin/agetty"

I don't see this when using Linus' BK tree as of a few minutes ago, and
the only changes I've made are adding the kgdb.h for ia64 and adding in
the Altix console driver.  Any ideas?  I'll try reverting some patches
and looking around a bit more.

Thanks,
Jesse
