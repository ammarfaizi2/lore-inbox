Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751159AbWAUIip@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751159AbWAUIip (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jan 2006 03:38:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751168AbWAUIip
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jan 2006 03:38:45 -0500
Received: from MAIL.13thfloor.at ([212.16.62.50]:21949 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S1751159AbWAUIip (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jan 2006 03:38:45 -0500
Date: Sat, 21 Jan 2006 09:38:43 +0100
From: Herbert Poetzl <herbert@13thfloor.at>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Christoph Hellwig <hch@infradead.org>, Al Viro <viro@ftp.linux.org.uk>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/6] vfs: extend loopback (bind) mounts by mnt_flags
Message-ID: <20060121083843.GA10044@MAIL.13thfloor.at>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	Andrew Morton <akpm@osdl.org>, Christoph Hellwig <hch@infradead.org>,
	Al Viro <viro@ftp.linux.org.uk>,
	Linux Kernel ML <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The following set of patches extends the per device 
'noatime', 'nodiratime' and last but not least the 
'ro' (read only) mount option to the vfs --bind mounts, 
allowing them to behave like any other mount, by 
honoring those mount flags (which are silently ignored 
by the current implementation in 2.4.x and 2.6.x)   	

the patch makes the following syscall variations behave 
as expected:

 - open (read/write/trunc), create
 - link, symlink, unlink
 - mknod (reg/block/char/fifo)
 - mkfifo, mkdir, rmdir, rename
 - (f,l)chown, (f)chmod, utime
 - access, truncate, mmap
 - ioctl (gen/ext2/ext3/reiser)
 - (f,l)setxattr, (f,l)removexattr

an older version of this patch was included in 
2.6.0-test6-mm2, and v2.6.4-wolk2.0, the patches are
in use by several people, without any issues ...

please consider inclusion (in -mm ?) and/or let me know
what needs to be changed to get this functionality into
mainline ...

TIA,
Herbert

