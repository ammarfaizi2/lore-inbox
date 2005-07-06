Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261708AbVGFOhO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261708AbVGFOhO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 10:37:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262315AbVGFOer
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 10:34:47 -0400
Received: from nproxy.gmail.com ([64.233.182.201]:39058 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262246AbVGFKWj convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 06:22:39 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=IDs1hUa47j49VyoAVhHBcIcDxM0UaKZO8+Y9z2VtZl8UbQKI+E/Bq/HrEH7MNOzgC0iFMIJZGl38SjPn3D1kgf8feT17LjuvGvsgwL5v8EkKFsHTEfXVVkD8Q5j2q36mIPO8Mx18Eh3O0f8Vvi293UWKr29yGDkabFREECKxegk=
Message-ID: <84144f0205070603223790e4df@mail.gmail.com>
Date: Wed, 6 Jul 2005 13:22:37 +0300
From: Pekka Enberg <penberg@gmail.com>
Reply-To: Pekka Enberg <penberg@gmail.com>
To: Nigel Cunningham <nigel@suspend2.net>
Subject: Re: [PATCH] [26/48] Suspend2 2.1.9.8 for 2.6.12: 603-suspend2_common-headers.patch
Cc: linux-kernel@vger.kernel.org, Pekka Enberg <penberg@cs.helsinki.fi>
In-Reply-To: <11206164424053@foobar.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <11206164393426@foobar.com> <11206164424053@foobar.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/6/05, Nigel Cunningham <nigel@suspend2.net> wrote:
> diff -ruNp 604-utility-header.patch-old/kernel/power/suspend2_core/utility.c 604-utility-header.patch-new/kernel/power/suspend2_core/utility.c
> --- 604-utility-header.patch-old/kernel/power/suspend2_core/utility.c   1970-01-01 10:00:00.000000000 +1000
> +++ 604-utility-header.patch-new/kernel/power/suspend2_core/utility.c   2005-07-05 23:48:59.000000000 +1000
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
> +       int result;
> +       va_list args;
> +
> +       if (!buffer_size) {
> +               return 0;
> +       }
> +
> +       va_start(args, fmt);
> +       result = vsnprintf(buffer, buffer_size, fmt, args);
> +       va_end(args);
> +
> +       if (result > buffer_size) {
> +               return buffer_size;
> +       }
> +
> +       return result;
> +}
> diff -ruNp 604-utility-header.patch-old/kernel/power/suspend2_core/utility.h 604-utility-header.patch-new/kernel/power/suspend2_core/utility.h
> --- 604-utility-header.patch-old/kernel/power/suspend2_core/utility.h   1970-01-01 10:00:00.000000000 +1000
> +++ 604-utility-header.patch-new/kernel/power/suspend2_core/utility.h   2005-07-05 23:48:59.000000000 +1000
> @@ -0,0 +1,12 @@
> +/*
> + * kernel/power/suspend2_core/utility.h
> + *
> + * Copyright (C) 2004-2005 Nigel Cunningham <nigel@suspend2.net>
> + *
> + * This file is released under the GPLv2.
> + *
> + * Routines that only suspend uses at the moment, but which might move
> + * when we merge because they're generic.
> + */

Please do move these.

> +
> +extern int suspend_snprintf(char * buffer, int buffer_size, const char *fmt, ...);

What's wrong with regular snprintf?

                          Pekka
