Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263232AbRFLUu3>; Tue, 12 Jun 2001 16:50:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263254AbRFLUuT>; Tue, 12 Jun 2001 16:50:19 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:8211 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S263250AbRFLUuH>;
	Tue, 12 Jun 2001 16:50:07 -0400
Date: Tue, 12 Jun 2001 21:49:15 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Cc: nico@cam.org
Subject: Make fat compile again
Message-ID: <20010612214915.B18802@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following makes fat/inode.c compile on ARM systems (and probably
many others).

fat/inode.c uses ffs(), which is defined in asm/bitops.h.  ARM uses
generic_ffs() which is in turn defined in linux/bitopts.h.
(linux/bitops.h includes asm/bitops.h)

diff -urN orig/fs/fat/inode.c linux/fs/fat/inode.c
--- orig/fs/fat/inode.c	Thu May 24 18:36:34 2001
+++ linux/fs/fat/inode.c	Tue Jun 12 10:44:35 2001
@@ -21,6 +21,7 @@
 #include <linux/sched.h>
 #include <linux/errno.h>
 #include <linux/string.h>
+#include <linux/bitops.h>
 #include <linux/major.h>
 #include <linux/blkdev.h>
 #include <linux/fs.h>




--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

