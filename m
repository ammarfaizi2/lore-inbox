Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264860AbTFUGJX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jun 2003 02:09:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264912AbTFUGJX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jun 2003 02:09:23 -0400
Received: from smtp-out2.iol.cz ([194.228.2.87]:46523 "EHLO smtp-out2.iol.cz")
	by vger.kernel.org with ESMTP id S264860AbTFUGJR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jun 2003 02:09:17 -0400
Date: Sat, 21 Jun 2003 08:23:06 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Lou Langholtz <ldl@aros.net>
Cc: linux-kernel@vger.kernel.org, Steven Whitehouse <steve@chygwyn.com>
Subject: Re: [RFC][PATCH] nbd driver for 2.5.72
Message-ID: <20030621062306.GA140@elf.ucw.cz>
References: <3EF3F08B.5060305@aros.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3EF3F08B.5060305@aros.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> The following (attached) patch to the network block device driver (nbd) 
> is now specific to just 2.5.72 with various other changes as suggested 
> by Pavel and Steven. Please let me know what you think. There's 
> definately room for more improvements but I don't believe the existing 
> 2.5 series nbd driver (at least up through 2.5.72) works at all. Has 
> anyone tested nbd as distributed with 2.5? I've been too busy writing 
> this new nbd driver to even have checked the original driver (but some 
> of the bugs I've encountered make me believe the original won't work at 
> all). Here's a URL to follow to see just the two resultant files (and/or 
> the patch in case it doesn't come through as an attachment): 
> <http://www.aros.net/~ldl/linux/kernel/2.5.72/>.
> 
> Thanks!
> 
> PS: Please email me or CC me if you have any feedback for me.

> diff -urN linux-2.5.72/drivers/block/nbd.c linux-2.5.72-new/drivers/block/nbd.c
> --- linux-2.5.72/drivers/block/nbd.c	2003-06-16 22:19:44.000000000 -0600
> +++ linux-2.5.72-new/drivers/block/nbd.c	2003-06-20 21:27:44.650037153 -0600
> @@ -24,10 +25,35 @@
>   * 01-3-11 Make nbd work with new Linux block layer code. It now supports
>   *   plugging like all the other block devices. Also added in MSG_MORE to
>   *   reduce number of partial TCP segments sent. <steve@chygwyn.com>
> - * 01-12-6 Fix deadlock condition by making queue locks independent of
> + * 01-12-6 Fix deadlock condition by making queue locks independant
of

This actually *introduces* typo.


>  #include <asm/uaccess.h>
>  #include <asm/types.h>
> +#include <asm/system.h>	/* for __xchg()... */
> +#define atomic_exchange(x,ptr,size) __xchg((x),(ptr),(size))
>  

atomic_exchange seems to be defined but never used?

									Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
