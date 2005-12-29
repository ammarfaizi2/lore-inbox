Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965052AbVL2IW2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965052AbVL2IW2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Dec 2005 03:22:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965053AbVL2IW2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Dec 2005 03:22:28 -0500
Received: from nproxy.gmail.com ([64.233.182.193]:54379 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965052AbVL2IW1 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Dec 2005 03:22:27 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Ja+bAHUWRYMCfSg+C1uGzW6eAJcVtFnxbgKBc4MNZtR+ak2hQpdevsPzw8tAoowD8hA5B7yF60tiu9pdyaisjk904ckfS95BYqYiiLlcZYtil5NlpatCZcsG98NdcSbpdpWIXKQBuk/vJz/+nJ5ijLvHj2epUOVRd9w7OyGov/o=
Message-ID: <84144f020512290022i20504893n95eb01484de62e3f@mail.gmail.com>
Date: Thu, 29 Dec 2005 10:22:26 +0200
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: "Bryan O'Sullivan" <bos@pathscale.com>
Subject: Re: [PATCH 6 of 20] ipath - driver debugging headers
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
In-Reply-To: <9e8d017ed298d591ea33.1135816285@eng-12.pathscale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <patchbomb.1135816279@eng-12.pathscale.com>
	 <9e8d017ed298d591ea33.1135816285@eng-12.pathscale.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/29/05, Bryan O'Sullivan <bos@pathscale.com> wrote:
> +#endif /* _IPATH_DEBUG_H */
> diff -r 2d9a3f27a10c -r 9e8d017ed298 drivers/infiniband/hw/ipath/ipath_kdebug.h
> --- /dev/null   Thu Jan  1 00:00:00 1970 +0000
> +++ b/drivers/infiniband/hw/ipath/ipath_kdebug.h        Wed Dec 28 14:19:42 2005 -0800
> @@ -0,0 +1,109 @@
> +#ifndef _IPATH_KDEBUG_H
> +#define _IPATH_KDEBUG_H
> +
> +#include "ipath_debug.h"
> +
> +/*
> + * This file contains lightweight kernel tracing code.
> + */
> +
> +extern unsigned infinipath_debug;
> +const char *ipath_get_unit_name(int unit);
> +
> +#if _IPATH_DEBUGGING
> +
> +#define _IPATH_UNIT_ERROR(unit,fmt,...) \
> +        printk(KERN_ERR "%s: " fmt, ipath_get_unit_name(unit), ##__VA_ARGS__)
> +
> +#define _IPATH_ERROR(fmt,...) printk(KERN_ERR "infinipath: " fmt, ##__VA_ARGS__)
> +
> +#define _IPATH_INFO(fmt,...) \
> +       do { \
> +               if(unlikely(infinipath_debug & __IPATH_INFO)) \
> +                       printk(KERN_INFO "infinipath: " fmt, ##__VA_ARGS__); \
> +       } while(0)
> +

[snip, snip]

Please consider using dev_dbg, dev_err, et al from <linux/device.h>.

                          Pekka
