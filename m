Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932421AbWFYOhE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932421AbWFYOhE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jun 2006 10:37:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932422AbWFYOhE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jun 2006 10:37:04 -0400
Received: from mba.ocn.ne.jp ([210.190.142.172]:65518 "EHLO smtp.mba.ocn.ne.jp")
	by vger.kernel.org with ESMTP id S932421AbWFYOhB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jun 2006 10:37:01 -0400
Date: Sun, 25 Jun 2006 23:38:08 +0900 (JST)
Message-Id: <20060625.233808.59465787.anemo@mba.ocn.ne.jp>
To: alessandro.zummo@towertech.it
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] RTC: add rtc-ds1553 and rtc-ds1742 driver
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20060625115525.098f53a5@inspiron>
References: <20060623001622.65db7c0f@inspiron>
	<20060623.182828.92343173.nemoto@toshiba-tops.co.jp>
	<20060625115525.098f53a5@inspiron>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 25 Jun 2006 11:55:25 +0200, Alessandro Zummo <alessandro.zummo@towertech.it> wrote:
> > No, it is intentional.  If irq is not available, I want to fall back
> > into emulation in rtc-dev.c.
> 
>  maybe you can add a comment explaining this choice

Indeed.  Here it is.


Subject: RTC: Add a comment for ENOIOCTLCMD in ds1553_rtc_ioctl.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

--- linux-2.6.17-mm2/drivers/rtc/rtc-ds1553.c	2006-06-25 23:28:24.387004000 +0900
+++ linux/drivers/rtc/rtc-ds1553.c	2006-06-25 23:31:00.156324096 +0900
@@ -226,7 +226,7 @@
 	struct rtc_plat_data *pdata = platform_get_drvdata(pdev);
 
 	if (pdata->irq < 0)
-		return -ENOIOCTLCMD;
+		return -ENOIOCTLCMD; /* fall back into rtc-dev's emulation */
 	switch (cmd) {
 	case RTC_AIE_OFF:
 		pdata->irqen &= ~RTC_AF;
