Return-Path: <linux-kernel-owner+w=401wt.eu-S1751204AbXAFHaz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751204AbXAFHaz (ORCPT <rfc822;w@1wt.eu>);
	Sat, 6 Jan 2007 02:30:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751203AbXAFHaz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Jan 2007 02:30:55 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:2062 "EHLO spitz.ucw.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751204AbXAFHay (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Jan 2007 02:30:54 -0500
Date: Fri, 5 Jan 2007 17:32:05 +0000
From: Pavel Machek <pavel@ucw.cz>
To: Robert Hancock <hancockr@shaw.ca>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, mchehab@infradead.org,
       v4l-dvb-maintainer@linuxtv.org
Subject: Re: [PATCH] cx88xx: Fix lockup on suspend
Message-ID: <20070105173204.GB4745@ucw.cz>
References: <459DB421.4040408@shaw.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <459DB421.4040408@shaw.ca>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Suspending with the cx88xx module loaded causes the 
> system to lock up because the cx88_audio_thread kthread 
> was missing a try_to_freeze() call, which caused it to 
> go into a tight loop and result in softlockup when 
> suspending. Fix that.
> 
> Signed-off-by: Robert Hancock <hancockr@shaw.ca>
>

Ack,
 
> --- 
> linux-2.6.20-rc3-git4-orig/drivers/media/video/cx88/cx88-tvaudio.c	2007-01-04 19:51:45.000000000 -0600
> +++ 
> linux-2.6.20-rc3-git4/drivers/media/video/cx88/cx88-tvaudio.c	2007-01-04 19:25:19.000000000 -0600
> @@ -38,6 +38,7 @@
> #include <linux/module.h>
> #include <linux/moduleparam.h>
> #include <linux/errno.h>
> +#include <linux/freezer.h>
> #include <linux/kernel.h>
> #include <linux/slab.h>
> #include <linux/mm.h>

but your patch was whitespace-damaged. Can you retry?

> @@ -961,6 +962,7 @@ int cx88_audio_thread(void *data)
> 		msleep_interruptible(1000);
> 		if (kthread_should_stop())
> 			break;
> +		try_to_freeze();
> 

							Pavel

-- 
Thanks for all the (sleeping) penguins.
