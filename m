Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261975AbULKRae@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261975AbULKRae (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Dec 2004 12:30:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261976AbULKRae
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Dec 2004 12:30:34 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:34313 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261975AbULKRa3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Dec 2004 12:30:29 -0500
Date: Sat, 11 Dec 2004 18:30:16 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [2.6 patch] IDE: remove WAIT_READY dependency on APM
Message-ID: <20041211173016.GX22324@stusta.de>
References: <20041209034438.GF22324@stusta.de> <1102692003.3201.5.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1102692003.3201.5.camel@localhost.localdomain>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 10, 2004 at 03:20:05PM +0000, Alan Cox wrote:
> On Iau, 2004-12-09 at 03:44, Adrian Bunk wrote:
> > The time for the !APM case was already increased from 30msec in 2.4 .
> > Isn't there a timeout that is suitable for all cases?
> 
> The five seconds should be just fine for all cases. The smaller value
> with no
> power manglement should help speed up recovery however. It probably
> doesn't belong CONFIG_APM now ACPI and friends are involved either.


Thanks for this information. A patch is below.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc2-mm4-full/include/linux/ide.h.old	2004-12-11 18:11:20.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/include/linux/ide.h	2004-12-11 18:11:32.000000000 +0100
@@ -187,11 +187,7 @@
  * Timeouts for various operations:
  */
 #define WAIT_DRQ	(HZ/10)		/* 100msec - spec allows up to 20ms */
-#if defined(CONFIG_APM) || defined(CONFIG_APM_MODULE)
 #define WAIT_READY	(5*HZ)		/* 5sec - some laptops are very slow */
-#else
-#define WAIT_READY	(HZ/10)		/* 100msec - should be instantaneous */
-#endif /* CONFIG_APM || CONFIG_APM_MODULE */
 #define WAIT_PIDENTIFY	(10*HZ)	/* 10sec  - should be less than 3ms (?), if all ATAPI CD is closed at boot */
 #define WAIT_WORSTCASE	(30*HZ)	/* 30sec  - worst case when spinning up */
 #define WAIT_CMD	(10*HZ)	/* 10sec  - maximum wait for an IRQ to happen */

