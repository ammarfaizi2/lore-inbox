Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317370AbSFHJXQ>; Sat, 8 Jun 2002 05:23:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317387AbSFHJXP>; Sat, 8 Jun 2002 05:23:15 -0400
Received: from mgate08.so-net.ne.jp ([210.139.254.155]:12811 "EHLO
	mgate08.so-net.ne.jp") by vger.kernel.org with ESMTP
	id <S317370AbSFHJXO>; Sat, 8 Jun 2002 05:23:14 -0400
Date: Sat, 8 Jun 2002 18:21:59 +0900
From: Go Taniguchi <go@turbolinux.co.jp>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] IDE oops with generic ide driver
Message-Id: <20020608182159.3ef27379.go@turbolinux.co.jp>
X-Mailer: Sylpheed version 0.6.3 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

In driver/ide/ide.c file, at function ide_revalidate_disk,
If there is no IDE-disk particular driver,
DRIVER(drive) is NULL, which means it is generic IDE driver.

The 2.4.x ide.c code was not written to check if it is NULL or not.
That's the problem. All other part is checked.

--- linux/drivers/ide/ide.c.orig	Fri Jun  7 04:34:09 2002
+++ linux/drivers/ide/ide.c	Fri Jun  7 17:07:16 2002
@@ -2049,7 +2049,7 @@
 		drive->part[p].nr_sects   = 0;
 	};
 
-	if (DRIVER(drive)->revalidate)
+	if (DRIVER(drive) && DRIVER(drive)->revalidate)
 		DRIVER(drive)->revalidate(drive);
 
 	drive->busy = 0;

Regards,
GO!
