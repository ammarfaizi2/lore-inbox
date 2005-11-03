Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750914AbVKCGDG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750914AbVKCGDG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 01:03:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751022AbVKCGDF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 01:03:05 -0500
Received: from mail.kroah.org ([69.55.234.183]:49547 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1750914AbVKCGDE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 01:03:04 -0500
Date: Wed, 2 Nov 2005 22:02:36 -0800
From: Greg KH <greg@kroah.com>
To: Phillip Hellewell <phillip@hellewell.homeip.net>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       mike@halcrow.us, mhalcrow@us.ibm.com, mcthomps@us.ibm.com,
       yoder1@us.ibm.com
Subject: Re: [PATCH 4/12: eCryptfs] Main module functions
Message-ID: <20051103060236.GB5044@kroah.com>
References: <20051103033220.GD2772@sshock.rn.byu.edu> <20051103034929.GD3005@sshock.rn.byu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051103034929.GD3005@sshock.rn.byu.edu>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 02, 2005 at 08:49:29PM -0700, Phillip Hellewell wrote:
> +#ifdef HAVE_CONFIG_H
> +# include <config.h>
> +#endif				/* HAVE_CONFIG_H */

What is this here for?

> +#include <net/sock.h>
> +#include <linux/file.h>

net/ after linux/ please.  Why do you need sock.h anyway?

> +/**
> + * Module parameter that defines the ecryptfs_verbosity level.
> + */
> +#define VERBOSE_DUMP 9
> +#ifdef DEBUG
> +int ecryptfs_verbosity = VERBOSE_DUMP;
> +#else
> +int ecryptfs_verbosity = 1;
> +#endif
> +module_param(ecryptfs_verbosity, int, 1);

I don't think you want a "1" here, do you?  Hint, it's not doing what
you think it is doing...

> +void __ecryptfs_kfree(void *ptr, const char *fun, int line)
> +{
> +	if (unlikely(ECRYPTFS_ENABLE_MEMORY_TRACING))
> +		ecryptfs_printk_release(ptr, fun, line);
> +	kfree(ptr);
> +}
> +
> +void *__ecryptfs_kmalloc(size_t size, unsigned int flags, const char *fun,
> +			 int line)

<snip>

Don't have wrappers for all of the common kernel functions, just call
them directly.

thanks,

greg k-h
