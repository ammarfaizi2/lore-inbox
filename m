Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262547AbUEKJSA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262547AbUEKJSA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 05:18:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262625AbUEKJQp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 05:16:45 -0400
Received: from fw.osdl.org ([65.172.181.6]:14738 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262547AbUEKJMF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 05:12:05 -0400
Date: Tue, 11 May 2004 02:11:28 -0700
From: Andrew Morton <akpm@osdl.org>
To: Patrice Bouchand <PBouchand@cyberdeck.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ib700wdt watchdog driver for 2.6.6
Message-Id: <20040511021128.303e7d36.akpm@osdl.org>
In-Reply-To: <200405111101.37376.PBouchand@cyberdeck.com>
References: <200405101757.58104.PBouchand@cyberdeck.com>
	<20040511013223.2c1eafe8.akpm@osdl.org>
	<200405111101.37376.PBouchand@cyberdeck.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patrice Bouchand <PBouchand@cyberdeck.com> wrote:
>
>  	The value written in the WDT_STOP register is not important. As soon as something is written , the watchdog timer stops.
>   But you are right, things will be cleaner if we use the following patch.
> 
>  	Thanks for the comments.
> 
>  	Best regards
> 
>  			Patrice Bouchand
> 
>  -----------------------------------------------------------------------------------------------------------------------------------
>  --- ./ib700wdt.c.orig   2004-05-10 08:57:54.000000000 +0200
>  +++ ib700wdt.c  2004-05-11 10:50:54.000000000 +0200
>  @@ -135,7 +135,7 @@
>   ibwdt_ping(void)
>   {
>          /* Write a watchdog value */
>  -       outb_p(wd_times[wd_margin], WDT_START);
>  +       outb_p(wd_margin, WDT_START);

It would be clearer still if we wrote a simple 0 in there.  Does that
sounds OK?

btw, please send patches in `patch -p1' format, as below.  And your mailer
seems to be converting tabs to spaces.

Thanks.




From: Patrice Bouchand <PBouchand@cyberdeck.com>

The value written in the WDT_STOP register is not important.  As soon as
something is written, the watchdog timer stops.  But things will be cleaner
if we use the following patch.


---

 25-akpm/drivers/char/watchdog/ib700wdt.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff -puN drivers/char/watchdog/ib700wdt.c~ib700wdt-fix-2 drivers/char/watchdog/ib700wdt.c
--- 25/drivers/char/watchdog/ib700wdt.c~ib700wdt-fix-2	2004-05-11 02:10:55.148368032 -0700
+++ 25-akpm/drivers/char/watchdog/ib700wdt.c	2004-05-11 02:11:10.226075872 -0700
@@ -234,7 +234,7 @@ ibwdt_close(struct inode *inode, struct 
 {
 	spin_lock(&ibwdt_lock);
 	if (expect_close == 42)
-		outb_p(wd_times[wd_margin], WDT_STOP);
+		outb_p(0, WDT_STOP);
 	else
 		printk(KERN_CRIT PFX "WDT device closed unexpectedly.  WDT will not stop!\n");
 
@@ -254,7 +254,7 @@ ibwdt_notify_sys(struct notifier_block *
 {
 	if (code == SYS_DOWN || code == SYS_HALT) {
 		/* Turn the WDT off */
-		outb_p(wd_times[wd_margin], WDT_STOP);
+		outb_p(0, WDT_STOP);
 	}
 	return NOTIFY_DONE;
 }

_

