Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262794AbUEKJCm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262794AbUEKJCm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 05:02:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262538AbUEKJCm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 05:02:42 -0400
Received: from mail.cyberdeck.net ([213.30.142.148]:28370 "EHLO
	mail.cyberdeck.com") by vger.kernel.org with ESMTP id S262794AbUEKJBr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 05:01:47 -0400
From: Patrice Bouchand <PBouchand@cyberdeck.com>
Organization: Cyberdeck
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] ib700wdt watchdog driver for 2.6.6
Date: Tue, 11 May 2004 11:01:37 +0200
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
References: <200405101757.58104.PBouchand@cyberdeck.com> <20040511013223.2c1eafe8.akpm@osdl.org>
In-Reply-To: <20040511013223.2c1eafe8.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200405111101.37376.PBouchand@cyberdeck.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The patch certainly looks sensible, but what about ibwdt_close() and
> ibwdt_notify_sys()?  They're doing
>
> 		outb_p(wd_times[wd_margin], WDT_STOP);
>
> which also seems peculiar.


	The value written in the WDT_STOP register is not important. As soon as something is written , the watchdog timer stops.
 But you are right, things will be cleaner if we use the following patch.

	Thanks for the comments.

	Best regards

			Patrice Bouchand

-----------------------------------------------------------------------------------------------------------------------------------
--- ./ib700wdt.c.orig   2004-05-10 08:57:54.000000000 +0200
+++ ib700wdt.c  2004-05-11 10:50:54.000000000 +0200
@@ -135,7 +135,7 @@
 ibwdt_ping(void)
 {
        /* Write a watchdog value */
-       outb_p(wd_times[wd_margin], WDT_START);
+       outb_p(wd_margin, WDT_START);
 }

 static ssize_t
@@ -234,7 +234,7 @@
 {
        spin_lock(&ibwdt_lock);
        if (expect_close == 42)
-               outb_p(wd_times[wd_margin], WDT_STOP);
+               outb_p(wd_margin, WDT_STOP);
        else
                printk(KERN_CRIT PFX "WDT device closed unexpectedly.  WDT will not stop!\n");

@@ -254,7 +254,7 @@
 {
        if (code == SYS_DOWN || code == SYS_HALT) {
                /* Turn the WDT off */
-               outb_p(wd_times[wd_margin], WDT_STOP);
+               outb_p(wd_margin, WDT_STOP);
        }
        return NOTIFY_DONE;
 }


