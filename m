Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261447AbVAaXr7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261447AbVAaXr7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 18:47:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261462AbVAaXpX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 18:45:23 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:6150 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261464AbVAaXmg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 18:42:36 -0500
Date: Tue, 1 Feb 2005 00:42:34 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-ide@vger.kernel.org
Subject: [2.6 patch] IDE: remove WAIT_READY dependency on APM
Message-ID: <20050131234234.GU21437@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On the one hand APM isn't enabled on all laptops.
On the other hand, this also affects regular PCs with APM support (or
using a distribution kernel with APM support).

The time for the !APM case was already increased from 30msec in 2.4 .
Isn't there a timeout that is suitable for all cases?

Alan Cox answered:
> The five seconds should be just fine for all cases. The smaller value
> with no
> power manglement should help speed up recovery however. It probably
> doesn't belong CONFIG_APM now ACPI and friends are involved either.

Until someone has a real good solution (consider e.g. that most PC users 
might have ACPI support enabled), this patch unconditionally sets 
WAIT_READY to 5 seconds.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch as already sent on:
- 11 Dec 2004
- 17 Jan 2005

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

