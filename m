Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264990AbUEKWYP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264990AbUEKWYP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 18:24:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264996AbUEKWYP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 18:24:15 -0400
Received: from mail.kroah.org ([65.200.24.183]:23230 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264990AbUEKWXY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 18:23:24 -0400
Date: Tue, 11 May 2004 15:22:45 -0700
From: Greg KH <greg@kroah.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: airlied@pdx.freedesktop.org
Subject: Re: From Eric Anholt:
Message-ID: <20040511222245.GA25644@kroah.com>
References: <200405112211.i4BMBQDZ006167@hera.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200405112211.i4BMBQDZ006167@hera.kernel.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 10, 2004 at 04:32:02AM +0000, Linux Kernel Mailing List wrote:
> diff -Nru a/drivers/char/drm/drm.h b/drivers/char/drm/drm.h
> --- a/drivers/char/drm/drm.h	Tue May 11 15:11:32 2004
> +++ b/drivers/char/drm/drm.h	Tue May 11 15:11:32 2004
> @@ -580,6 +580,16 @@
>  	unsigned long handle;	/**< Used for mapping / unmapping */
>  } drm_scatter_gather_t;
>  
> +/**
> + * DRM_IOCTL_SET_VERSION ioctl argument type.
> + */
> +typedef struct drm_set_version {
> +	int drm_di_major;
> +	int drm_di_minor;
> +	int drm_dd_major;
> +	int drm_dd_minor;
> +} drm_set_version_t;
> +

Ick, you can't use "int" as an ioctl structure member, sorry.  Please
use the proper "__u16" or "__u32" value instead.

And what about kernels running in 64bit mode with 32bit userspace?  Care
to provide the proper thunking layer for them too?

thanks,

greg k-h
