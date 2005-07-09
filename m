Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261237AbVGIL75@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261237AbVGIL75 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Jul 2005 07:59:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261229AbVGIL4w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Jul 2005 07:56:52 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:58077 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261224AbVGILys (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Jul 2005 07:54:48 -0400
Date: Sat, 9 Jul 2005 13:53:59 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <nigel@suspend2.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [26/48] Suspend2 2.1.9.8 for 2.6.12: 603-suspend2_common-headers.patch
Message-ID: <20050709115359.GC1878@elf.ucw.cz>
References: <11206164393426@foobar.com> <11206164424053@foobar.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11206164424053@foobar.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> diff -ruNp 604-utility-header.patch-old/kernel/power/suspend2_core/utility.c 604-utility-header.patch-new/kernel/power/suspend2_core/utility.c
> --- 604-utility-header.patch-old/kernel/power/suspend2_core/utility.c	1970-01-01 10:00:00.000000000 +1000
> +++ 604-utility-header.patch-new/kernel/power/suspend2_core/utility.c	2005-07-05 23:48:59.000000000 +1000
> @@ -0,0 +1,46 @@
> +/*
> + * kernel/power/utility.c
> + *
> + * Copyright (C) 2004-2005 Nigel Cunningham <nigel@suspend2.net>
> + * 
> + * This file is released under the GPLv2.
> + *
> + * Routines that only suspend uses at the moment, but which might move
> + * when we merge because they're generic.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/mm.h>
> +#include <linux/proc_fs.h>
> +#include <asm/string.h>
> +
> +#include "pageflags.h"
> +
> +/*
> + * suspend_snprintf
> + *
> + * Functionality    : Print a string with parameters to a buffer of a 
> + *                    limited size. Unlike vsnprintf, we return the number
> + *                    of bytes actually put in the buffer, not the number
> + *                    that would have been put in if it was big enough.
> + */
> +int suspend_snprintf(char * buffer, int buffer_size, const char *fmt, ...)
> +{
> +	int result;
> +	va_list args;
> +
> +	if (!buffer_size) {
> +		return 0;
> +	}
> +
> +	va_start(args, fmt);
> +	result = vsnprintf(buffer, buffer_size, fmt, args);
> +	va_end(args);
> +
> +	if (result > buffer_size) {
> +		return buffer_size;
> +	}
> +
> +	return result;
> +}

Eh, this needs to be either generic function or not there at all.
										Pavel
-- 
teflon -- maybe it is a trademark, but it should not be.
