Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129153AbQKWNuu>; Thu, 23 Nov 2000 08:50:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131963AbQKWNuk>; Thu, 23 Nov 2000 08:50:40 -0500
Received: from mail2.rdc2.on.home.com ([24.9.0.41]:58556 "EHLO
        mail2.rdc2.on.home.com") by vger.kernel.org with ESMTP
        id <S129153AbQKWNua>; Thu, 23 Nov 2000 08:50:30 -0500
Message-ID: <3A1D1998.5A22EA7C@cmedia.com.tw>
Date: Thu, 23 Nov 2000 08:20:24 -0500
From: cmedia <cltien@cmedia.com.tw>
X-Mailer: Mozilla 4.76 [en] (Win98; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Peter Samuelson <peter@cadcamlab.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: Linux driver for c-media cm8x38 ver 4.12 released
In-Reply-To: <3A1C62AA.5D4579B3@cmedia.com.tw> <20001123033948.R2918@wire.cadcamlab.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Peter Samuelson wrote:

> [ChenLi Tien, from http://members.home.net/puresoft/cmedia.html]
> > - *      Copyright (C) 1999  ChenLi Tien (cltien@home.com)
> > - *
> > - *   Based on the PCI drivers by Thomas Sailer (sailer@ife.ee.ethz.ch)
> > + *      Copyright (C) 1999  ChenLi Tien (cltien@cmedia.com.tw)
> > + *                       C-media support (support@cmedia.com.tw)
>
> This is somewhat impolite -- unless the driver is *not* actually based
> on Tom's work.
>

I didn't notice someone add this line, but I will be happy to add it.

>
> > +#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,3,0)
> > +#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,4,0)
> > +     owner:          THIS_MODULE,
> > +#endif
> >       llseek:         cm_llseek,
> >       ioctl:          cm_ioctl_mixdev,
> >       open:           cm_open_mixdev,
> >       release:        cm_release_mixdev,
> > +#else
> > +     &cm_llseek,
> > +     NULL,  /* read */
> > +     NULL,  /* write */
> > +     NULL,  /* readdir */
> > +     NULL,  /* poll */
> > +     &cm_ioctl_mixdev,
> > +     NULL,  /* mmap */
> > +     &cm_open_mixdev,
> > +     NULL,   /* flush */
> > +     &cm_release_mixdev,
> > +     NULL,  /* fsync */
> > +     NULL,  /* fasync */
> > +     NULL,  /* check_media_change */
> > +     NULL,  /* revalidate */
> > +     NULL,  /* lock */
> > +#endif
>
> I don't think the (2,3,0) ifdef is necessary.  Just use the labeled
> initializers for all kernels.  See also cm_audio_fops, cm_dsp_fops,
> cm_midi_fops, cm_dmfm_fops.

Yes, as 2.3.x series is not for end-user, I can remove them. I keep it for
easy to tell what's different for kernel 2.3 and 2.4.

>
>
> > +#ifdef MODULE
> > +MODULE_PARM(mpu_io, "i");
> > +MODULE_PARM(fm_io, "i");
> > +MODULE_PARM(spdif_inverse, "i");
> > +MODULE_PARM(spdif_loop, "i");
> > +MODULE_PARM(four_sp, "i");
> > +MODULE_PARM(rear_out, "i");
> > +MODULE_PARM(modem, "i");
> > +MODULE_PARM(joystick, "i");
> >  #endif
>
> No need for '#ifdef MODULE'.

I will remove it if kernel 2.2 can work.

>
>
> > +#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,4,0)
> > +static int __init init_cmpci(void)
> > +#elif LINUX_VERSION_CODE >= KERNEL_VERSION(2,3,0)
> > +#ifdef MODULE
> > +int __init init_module(void)
> > +#else
> >  int __init init_cmpci(void)
> >  #endif
> > +#else
> > +#ifdef MODULE
> > +__initfunc(int init_module(void))
> > +#else
> > +__initfunc(int init_cmpci(void))
> > +#endif
> > +#endif
>
> __init is fine in 2.2, no need for conditional __initfunc().
>
> Peter

Thanks for your suggestion, I can change it.

ChenLi Tien

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
