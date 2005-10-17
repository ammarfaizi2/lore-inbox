Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751409AbVJQXrZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751409AbVJQXrZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 19:47:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751413AbVJQXrZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 19:47:25 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:23447 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S1751409AbVJQXrY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 19:47:24 -0400
Date: Tue, 18 Oct 2005 01:47:23 +0200
From: Pavel Machek <pavel@ucw.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Andrew Morton <akpm@zip.com.au>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/4] swsusp: clean up resume error path
Message-ID: <20051017234723.GB13148@atrey.karlin.mff.cuni.cz>
References: <200510172336.53194.rjw@sisk.pl> <200510172350.05415.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200510172350.05415.rjw@sisk.pl>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> The following patch removes an incorrect call to restore_highmem() from
> the resume error path (there's no saved highmem in that case) and makes
> swsusp touch the softlockup watchdog if there's no error (currently it only
> touches the watchdog if an error occurs).
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> 
> Index: linux-2.6.14-rc4-mm1/kernel/power/swsusp.c
> ===================================================================
> --- linux-2.6.14-rc4-mm1.orig/kernel/power/swsusp.c	2005-10-17 23:28:34.000000000 +0200
> +++ linux-2.6.14-rc4-mm1/kernel/power/swsusp.c	2005-10-17 23:28:47.000000000 +0200
> @@ -628,7 +629,6 @@
>  	 */
>  	swsusp_free();
>  	restore_processor_state();
> -	restore_highmem();
>  	touch_softlockup_watchdog();
>  	device_power_up();
>  	local_irq_enable();

I don't like this one. restore_highmem() does freeing of allocated
pages. If swsusp_arch_suspend() fails in specific way, I suspect it
could leak highmem.

								Pavel


-- 
Boycott Kodak -- for their patent abuse against Java.
