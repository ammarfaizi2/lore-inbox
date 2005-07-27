Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262079AbVG0JjK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262079AbVG0JjK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 05:39:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262080AbVG0JjK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 05:39:10 -0400
Received: from smtp.osdl.org ([65.172.181.4]:40155 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262079AbVG0JjJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 05:39:09 -0400
Date: Wed, 27 Jul 2005 02:37:54 -0700
From: Andrew Morton <akpm@osdl.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: rpurdie@rpsys.net, lenz@cs.wisc.edu, linux-kernel@vger.kernel.org
Subject: Re: [patch] Support powering sharp zaurus sl-5500 LCD up and down
Message-Id: <20050727023754.6846f3a2.akpm@osdl.org>
In-Reply-To: <20050727092613.GA4713@elf.ucw.cz>
References: <20050727092613.GA4713@elf.ucw.cz>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@ucw.cz> wrote:
>
> This adds support for powering Zaurus's video up and down.

I assume you have a new toy ;)

>  PDA without
> screen is kind of useless, so it is quite important... I'll have to
> figure out how to really control the frontlight, because LCD without
> that is quite hard to read.

signed-off-by?

> @@ -0,0 +1,156 @@
> +/*
> + * Backlight control code for Sharp Zaurus SL-5500
> + *
> + * Copyright 2005 John Lenz <lenz@cs.wisc.edu>
> + * GPL v2

Who is the maintainer for this stuff?

> +static struct locomo_dev *locomolcd_dev = NULL;

bah.

> +void locomolcd_power(int on)
> +{
> +	int comadj = 118;
> +	unsigned long flags;
> +	
> +	local_irq_save(flags);

What strange locking this driver uses.  It appears to be assuming
uniprocessor, yes?

