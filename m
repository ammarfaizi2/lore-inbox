Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271748AbRH0Owo>; Mon, 27 Aug 2001 10:52:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271754AbRH0Owf>; Mon, 27 Aug 2001 10:52:35 -0400
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:21164 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S271748AbRH0OwX>; Mon, 27 Aug 2001 10:52:23 -0400
Date: Mon, 27 Aug 2001 08:52:45 -0600
Message-Id: <200108271452.f7REqjT15752@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: arjanv@redhat.com
Cc: Per Niva <pna@mendosus.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Added devfs support for i386 msr/cpuid driver
In-Reply-To: <3B8A2C1F.63AF4AE7@redhat.com>
In-Reply-To: <Pine.LNX.4.33.0108271031010.12684-102000@subcentral.mendosus.org>
	<3B8A2C1F.63AF4AE7@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven writes:
> > 
> >  int __init msr_init(void)
> >  {
> > +#ifdef CONFIG_DEVFS_FS
> > +    devfs_handle = devfs_register(NULL, "cpu/msr", DEVFS_FL_DEFAULT, 0, 0,
> > +                                  S_IFREG | S_IRUGO | S_IWUSR,
> > +                                  &msr_fops, NULL);
> > +#else
> >    if (register_chrdev(MSR_MAJOR, "cpu/msr", &msr_fops)) {
> >      printk(KERN_ERR "msr: unable to get major %d for msr\n",
> >            MSR_MAJOR);
> >      return -EBUSY;
> >    }
> > +#endif
> 
> this must be wrong as you don't check for devfs_register failures...

The reason it's wrong is because he put #ifdef's in there. The
functions should just be called unconditionally. The #ifdef's are in
the header.

> Also why devfs can't just use register_chrdev and not touch ALL
> drivers is beyond me, but it has been like that for a while now...

Huh?!? I thought that should be obvious. Think about it,
register_chrdev() registers a *major*, whereas devfs_register()
registers an individual device node. The former has no way of
representing which devices are detected, the latter sets up a 1:1
relationship between devices and device nodes (which is what people
actually want).

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
