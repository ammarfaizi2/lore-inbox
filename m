Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271762AbRH0P5q>; Mon, 27 Aug 2001 11:57:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271761AbRH0P5h>; Mon, 27 Aug 2001 11:57:37 -0400
Received: from subcentral.mendosus.org ([195.196.16.180]:3848 "EHLO
	subcentral.mendosus.org") by vger.kernel.org with ESMTP
	id <S271762AbRH0P51>; Mon, 27 Aug 2001 11:57:27 -0400
Date: Mon, 27 Aug 2001 16:55:47 +0200 (CEST)
From: Per Niva <pna@mendosus.org>
To: Richard Gooch <rgooch@ras.ucalgary.ca>
cc: <arjanv@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Added devfs support for i386 msr/cpuid driver
In-Reply-To: <200108271452.f7REqjT15752@vindaloo.ras.ucalgary.ca>
Message-ID: <Pine.LNX.4.33.0108271621410.22199-100000@subcentral.mendosus.org>
Organization: Mendosus
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Aug 2001, Richard Gooch wrote:

> Arjan van de Ven writes:
> > >
> > >  int __init msr_init(void)
> > >  {
> > > +#ifdef CONFIG_DEVFS_FS
> > > +    devfs_handle = devfs_register(NULL, "cpu/msr", DEVFS_FL_DEFAULT, 0, 0,
> > > +                                  S_IFREG | S_IRUGO | S_IWUSR,
> > > +                                  &msr_fops, NULL);
> > > +#else
> > >    if (register_chrdev(MSR_MAJOR, "cpu/msr", &msr_fops)) {
> > >      printk(KERN_ERR "msr: unable to get major %d for msr\n",
> > >            MSR_MAJOR);
> > >      return -EBUSY;
> > >    }
> > > +#endif
> >
> > this must be wrong as you don't check for devfs_register failures...
>
> The reason it's wrong is because he put #ifdef's in there. The
> functions should just be called unconditionally. The #ifdef's are in
> the header.

I actually pondered a while on this, and settled on
the cut'n'paste-from-mtrr.c version. There is no error
check there, and I just overlooked it.

The defence for the #ifdefs is that I didn't see
register_chrdev() being aware of devfs, and I thought
we'd be better off just not calling register_chrdev()
at all if we have devfs.

It's not like I personally like #ifdefs, but it seemed
justified to my inexperienced eyes at that point. And
there's a #ifdef CONFIG_DEVFS_FS around the call in
mtrr.c too, and I thought it safe to do like what's
already in the official tree.

In microcode.c however, is the new-style without #ifdef
(or rather with the #ifdef in the headers instead)
and with error checking, but microcode_init() doesn't
use register_chrdev() anyway, even if devfs is not
supported.

Please enlighten me!

> 				Regards,
>
> 					Richard....


Grateful for comments,


	Per


----------------------------------------------------
pna@mendosus.org                     +46 705 509 654
"Beware - the world will never be the same again..."

