Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262354AbTCICGJ>; Sat, 8 Mar 2003 21:06:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262357AbTCICGJ>; Sat, 8 Mar 2003 21:06:09 -0500
Received: from chii.cinet.co.jp ([61.197.228.217]:8064 "EHLO
	yuzuki.cinet.co.jp") by vger.kernel.org with ESMTP
	id <S262354AbTCICGI>; Sat, 8 Mar 2003 21:06:08 -0500
Date: Sun, 9 Mar 2003 11:16:15 +0900
From: Osamu Tomita <tomita@cinet.co.jp>
To: Alan Cox <alan@redhat.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: New IDE codes in 2.5.64-ac3
Message-ID: <20030309021615.GB981@yuzuki.cinet.co.jp>
References: <200303071756.h27HuiY01551@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200303071756.h27HuiY01551@devserv.devel.redhat.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My PC98 box doesn't boot 2.5.64-ac3.
After print "ide-default: hdd: Failed to register the driver with ide.c"
forced to panic.
"hdd" is not connected my box.
IMHO We need status meaning 'supported by the driver but drive not present'.
Or this problem is PC98 specific?
I attached my quick fix. Please comment.

Regards,
Osamu Tomita

diff -Nru linux-2.5.64-ac3/drivers/ide/ide-default.c linux-2.5.64-ac3-quick-fix/drivers/ide/ide-default.c
--- linux-2.5.64-ac3/drivers/ide/ide-default.c	2003-03-08 12:51:33.000000000 +0900
+++ linux-2.5.64-ac3-quick-fix/drivers/ide/ide-default.c	2003-03-09 10:14:51.000000000 +0900
@@ -61,7 +61,8 @@
 			&idedefault_driver, IDE_SUBDRIVER_VERSION)) {
 		printk(KERN_ERR "ide-default: %s: Failed to register the "
 			"driver with ide.c\n", drive->name);
-		return 1;
+		//return 1;
+		drive->present = 0;
 	}
 	return 0;
 }
