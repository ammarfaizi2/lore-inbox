Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S131133AbQKWKKd>; Thu, 23 Nov 2000 05:10:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131230AbQKWKKN>; Thu, 23 Nov 2000 05:10:13 -0500
Received: from wire.cadcamlab.org ([156.26.20.181]:26897 "EHLO
        wire.cadcamlab.org") by vger.kernel.org with ESMTP
        id <S131133AbQKWKKE>; Thu, 23 Nov 2000 05:10:04 -0500
Date: Thu, 23 Nov 2000 03:39:48 -0600
To: cmedia <cltien@cmedia.com.tw>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux driver for c-media cm8x38 ver 4.12 released
Message-ID: <20001123033948.R2918@wire.cadcamlab.org>
In-Reply-To: <3A1C62AA.5D4579B3@cmedia.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A1C62AA.5D4579B3@cmedia.com.tw>; from cltien@cmedia.com.tw on Wed, Nov 22, 2000 at 07:19:54PM -0500
From: Peter Samuelson <peter@cadcamlab.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[ChenLi Tien, from http://members.home.net/puresoft/cmedia.html]
> - *      Copyright (C) 1999  ChenLi Tien (cltien@home.com)
> - *
> - *	Based on the PCI drivers by Thomas Sailer (sailer@ife.ee.ethz.ch)
> + *      Copyright (C) 1999  ChenLi Tien (cltien@cmedia.com.tw)
> + *      		    C-media support (support@cmedia.com.tw)

This is somewhat impolite -- unless the driver is *not* actually based
on Tom's work.

> +#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,3,0)
> +#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,4,0)
> +	owner:		THIS_MODULE,
> +#endif
>  	llseek:		cm_llseek,
>  	ioctl:		cm_ioctl_mixdev,
>  	open:		cm_open_mixdev,
>  	release:	cm_release_mixdev,
> +#else
> +	&cm_llseek,
> +	NULL,  /* read */
> +	NULL,  /* write */
> +	NULL,  /* readdir */
> +	NULL,  /* poll */
> +	&cm_ioctl_mixdev,
> +	NULL,  /* mmap */
> +	&cm_open_mixdev,
> +	NULL,	/* flush */
> +	&cm_release_mixdev,
> +	NULL,  /* fsync */
> +	NULL,  /* fasync */
> +	NULL,  /* check_media_change */
> +	NULL,  /* revalidate */
> +	NULL,  /* lock */
> +#endif

I don't think the (2,3,0) ifdef is necessary.  Just use the labeled
initializers for all kernels.  See also cm_audio_fops, cm_dsp_fops,
cm_midi_fops, cm_dmfm_fops.

> +#ifdef MODULE
> +MODULE_PARM(mpu_io, "i");
> +MODULE_PARM(fm_io, "i");
> +MODULE_PARM(spdif_inverse, "i");
> +MODULE_PARM(spdif_loop, "i");
> +MODULE_PARM(four_sp, "i");
> +MODULE_PARM(rear_out, "i");
> +MODULE_PARM(modem, "i");
> +MODULE_PARM(joystick, "i");
>  #endif

No need for '#ifdef MODULE'.

> +#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,4,0)
> +static int __init init_cmpci(void)
> +#elif LINUX_VERSION_CODE >= KERNEL_VERSION(2,3,0)
> +#ifdef MODULE
> +int __init init_module(void)
> +#else
>  int __init init_cmpci(void)
>  #endif
> +#else
> +#ifdef MODULE
> +__initfunc(int init_module(void))
> +#else
> +__initfunc(int init_cmpci(void))
> +#endif
> +#endif

__init is fine in 2.2, no need for conditional __initfunc().

Peter
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
