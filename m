Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261382AbUL2TCl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261382AbUL2TCl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Dec 2004 14:02:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261396AbUL2TCl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Dec 2004 14:02:41 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:26511 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261382AbUL2TCi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Dec 2004 14:02:38 -0500
Message-ID: <41D2FF34.3040606@pobox.com>
Date: Wed, 29 Dec 2004 14:02:12 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [BK PATCH] fix floppy build
Content-Type: multipart/mixed;
 boundary="------------080500030605060709070000"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080500030605060709070000
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

So my patch removing #include kernel/version.h broke the modular floppy 
build... doh.  I would prefer to remove the redundancy of listing the 
kernel version each time the floppy driver is loaded.

See attached for 'bk pull' and example patch.

--------------080500030605060709070000
Content-Type: text/plain;
 name="changelog.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="changelog.txt"

Please do a

	bk pull bk://gkernel.bkbits.net/misc-2.6

This will update the following files:

 drivers/block/floppy.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

through these ChangeSets:

<jgarzik@pobox.com> (04/12/29 1.2079)
   block/floppy.c: fix build by removing UTS_RELEASE use
   
   It's redundant to the kernel message that prints out the kernel version,
   as well as many other places where one can request the kernel version.

diff -Nru a/drivers/block/floppy.c b/drivers/block/floppy.c
--- a/drivers/block/floppy.c	2004-12-29 14:00:55 -05:00
+++ b/drivers/block/floppy.c	2004-12-29 14:00:55 -05:00
@@ -4595,7 +4595,7 @@
 
 int init_module(void)
 {
-	printk(KERN_INFO "inserting floppy driver for " UTS_RELEASE "\n");
+	printk(KERN_INFO "inserting floppy driver\n");
 
 	if (floppy)
 		parse_floppy_cfg_string(floppy);

--------------080500030605060709070000--
