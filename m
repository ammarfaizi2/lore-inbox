Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266018AbUGELIs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266018AbUGELIs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jul 2004 07:08:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266016AbUGELIr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jul 2004 07:08:47 -0400
Received: from mailfe07.swip.net ([212.247.154.193]:20386 "EHLO
	mailfe07.swip.net") by vger.kernel.org with ESMTP id S266018AbUGELIT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jul 2004 07:08:19 -0400
X-T2-Posting-ID: mzHRUpvOlCbvaGn327Befg==
Date: Mon, 5 Jul 2004 12:54:21 +0200
From: Erik Rigtorp <erik@rigtorp.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernel/power/swsusp.c
Message-ID: <20040705105421.GA8680@linux.nu>
References: <20040703172843.GA7274@linux.nu> <20040703204647.GE31892@elf.ucw.cz> <20040704133715.GA4717@linux.nu> <20040704151848.GC8488@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="sm4nu43k4a2Rpi4c"
Content-Disposition: inline
In-Reply-To: <20040704151848.GC8488@elf.ucw.cz>
X-GPG-Key: Search for erkki@linux.nu at wwwkeys.eu.pgp.net
X-GPG-Fingerprint: 0534 CF05 8171 3EC6 921A  346F 1882 91C4 993F C709
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--sm4nu43k4a2Rpi4c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Jul 04, 2004 at 05:18:49PM +0200, Pavel Machek wrote:
> Actually, this has several advantages -- you can actually see the
> messages of the kernel during resume. And reading does logically
> belong to the kernel doing boot, so it belongs on its screen, too...

Here's a clean patch that does just that.

--sm4nu43k4a2Rpi4c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="swsusp-alloc-console-later.patch"

diff -Nru linux-2.6.7/kernel/power/swsusp.c linux-2.6.7-pavel/kernel/power/swsusp.c
--- linux-2.6.7/kernel/power/swsusp.c	2004-06-16 07:19:02.000000000 +0200
+++ linux-2.6.7-pavel/kernel/power/swsusp.c	2004-07-04 15:15:25.000000000 +0200
@@ -1190,9 +1190,6 @@
 	}
 	MDELAY(1000);
 
-	if (pm_prepare_console())
-		printk("swsusp: Can't allocate a console... proceeding\n");
-
 	if (!resume_file[0] && resume_status == RESUME_SPECIFIED) {
 		printk( "suspension device unspecified\n" );
 		return -EINVAL;
@@ -1201,12 +1198,15 @@
 	printk( "resuming from %s\n", resume_file);
 	if (read_suspend_image(resume_file, 0))
 		goto read_failure;
+
+	if (pm_prepare_console())
+		printk("swsusp: Can't allocate a console... proceeding\n");
+
 	device_suspend(4);
 	do_magic(1);
 	panic("This never returns");
 
 read_failure:
-	pm_restore_console();
 	return 0;
 }
 

--sm4nu43k4a2Rpi4c--
