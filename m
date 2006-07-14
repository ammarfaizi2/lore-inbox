Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422718AbWGNTMH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422718AbWGNTMH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 15:12:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422719AbWGNTMH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 15:12:07 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:35076 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S1422718AbWGNTMG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 15:12:06 -0400
Date: Fri, 14 Jul 2006 19:06:05 +0000
From: Pavel Machek <pavel@ucw.cz>
To: Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
Cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] IDE: Touch NMI watchdog during resume from STR
Message-ID: <20060714190604.GA8731@ucw.cz>
References: <44B61D0A.7010305@stud.feec.vutbr.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44B61D0A.7010305@stud.feec.vutbr.cz>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> When resuming from suspend-to-RAM, the NMI watchdog 
> detects a lockup in ide_wait_not_busy.
> Here's a screenshot of the trace taken by a digital 
> camera: 
> http://www.uamt.feec.vutbr.cz/rizeni/pom/DSC03510-2.JPG
> 
> Let's touch the NMI watchdog in ide_wait_not_busy. The 
> system then resumes correctly from STR.
> 
> Signed-off-by: Michal Schmidt 
> <xschmi00@stud.feec.vutbr.cz>

ACK.

> diff --git a/drivers/ide/ide-iops.c 
> b/drivers/ide/ide-iops.c
> index 6571652..77703ac 100644
> --- a/drivers/ide/ide-iops.c
> +++ b/drivers/ide/ide-iops.c
> @@ -23,6 +23,7 @@ #include <linux/delay.h>
> #include <linux/hdreg.h>
> #include <linux/ide.h>
> #include <linux/bitops.h>
> +#include <linux/nmi.h>
> 
> #include <asm/byteorder.h>
> #include <asm/irq.h>
> @@ -1243,6 +1244,7 @@ int ide_wait_not_busy(ide_hwif_t 
> *hwif, if (stat == 0xff)
> 			return -ENODEV;
> 		touch_softlockup_watchdog();
> +		touch_nmi_watchdog();

Perhaps we need touch_all_watchdogs()?

						Pavel

-- 
Thanks for all the (sleeping) penguins.
