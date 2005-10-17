Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751414AbVJQXyE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751414AbVJQXyE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 19:54:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751415AbVJQXyE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 19:54:04 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:48791 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S1751414AbVJQXyD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 19:54:03 -0400
Date: Tue, 18 Oct 2005 01:54:02 +0200
From: Pavel Machek <pavel@ucw.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 3/4] swsusp: two simplifications
Message-ID: <20051017235402.GC13148@atrey.karlin.mff.cuni.cz>
References: <200510172336.53194.rjw@sisk.pl> <200510172358.31349.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200510172358.31349.rjw@sisk.pl>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> The following patch simplifies the progress meter in disk.c:free_some_memory()
> and makes disk.c:pm_suspend_disk() call device_resume() explicitly in the
> suspend path.

ACK.

> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> 
> --- linux-2.6.14-rc4-mm1.orig/kernel/power/disk.c	2005-10-17 23:28:33.000000000 +0200
> +++ linux-2.6.14-rc4-mm1/kernel/power/disk.c	2005-10-17 23:28:52.000000000 +0200
> @@ -92,10 +92,7 @@
>  	printk("Freeing memory...  ");
>  	while ((tmp = shrink_all_memory(10000))) {
>  		pages += tmp;
> -		printk("\b%c", p[i]);
> -		i++;
> -		if (i > 3)
> -			i = 0;
> +		printk("\b%c", p[i++ % 4]);
>  	}
>  	printk("\bdone (%li pages freed)\n", pages);
>  }

This is actually not equivalent, but ok. (Equivalent would be ++i % 4
;-)

							Pavel

-- 
Boycott Kodak -- for their patent abuse against Java.
