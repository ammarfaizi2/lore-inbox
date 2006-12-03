Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936677AbWLCIUj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936677AbWLCIUj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Dec 2006 03:20:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936678AbWLCIUj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Dec 2006 03:20:39 -0500
Received: from smtp.osdl.org ([65.172.181.25]:17853 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S936677AbWLCIUi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Dec 2006 03:20:38 -0500
Date: Sun, 3 Dec 2006 01:16:25 -0800
From: Andrew Morton <akpm@osdl.org>
To: Ben Collins <ben.collins@ubuntu.com>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
       Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] Export current_is_keventd() for libphy
Message-Id: <20061203011625.60268114.akpm@osdl.org>
In-Reply-To: <1165125055.5320.14.camel@gullible>
References: <1165125055.5320.14.camel@gullible>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 03 Dec 2006 00:50:55 -0500
Ben Collins <ben.collins@ubuntu.com> wrote:

> Fixes this problem when libphy is compiled as module:
> 
> WARNING: "current_is_keventd" [drivers/net/phy/libphy.ko] undefined!
> 
> diff --git a/kernel/workqueue.c b/kernel/workqueue.c
> index 17c2f03..1cf226b 100644
> --- a/kernel/workqueue.c
> +++ b/kernel/workqueue.c
> @@ -608,6 +608,7 @@ int current_is_keventd(void)
>  	return ret;
>  
>  }
> +EXPORT_SYMBOL_GPL(current_is_keventd);
>  
>  #ifdef CONFIG_HOTPLUG_CPU
>  /* Take the work from this (downed) CPU. */

wtf?  That code was merged?  This bug has been known for months and after
several unsuccessful attempts at trying to understand what on earth that
hackery is supposed to be doing I gave up on it and asked Jeff to look after
it.

Maciej, please, in very small words written in a very large font, explain to
us what is going on in phy_stop_interrupts()?  Include pictures.
