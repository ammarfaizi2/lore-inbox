Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161070AbWG0NaH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161070AbWG0NaH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 09:30:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161073AbWG0NaG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 09:30:06 -0400
Received: from static-ip-62-75-166-246.inaddr.intergenia.de ([62.75.166.246]:64741
	"EHLO bu3sch.de") by vger.kernel.org with ESMTP id S1161070AbWG0NaE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 09:30:04 -0400
From: Michael Buesch <mb@bu3sch.de>
To: "gmu 2k6" <gmu2006@gmail.com>
Subject: Re: hwrng on 82801EB/ER (ICH5/ICH5R) fails rngtest checks
Date: Thu, 27 Jul 2006 15:29:39 +0200
User-Agent: KMail/1.9.1
References: <20060725222209.0048ed15.akpm@osdl.org> <200607261730.31717.mb@bu3sch.de> <f96157c40607261244m205ff68dh5563c66436a2e67@mail.gmail.com>
In-Reply-To: <f96157c40607261244m205ff68dh5563c66436a2e67@mail.gmail.com>
Cc: "Jeff Garzik" <jgarzik@pobox.com>,
       "Philipp Rumpf" <prumpf@mandrakesoft.com>,
       "Andrew Morton" <akpm@osdl.org>, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607271529.39549.mb@bu3sch.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 26 July 2006 21:44, gmu 2k6 wrote:
> > But could you try the following patch on top of latest git?
> > It's just a random test, but I think it's worth trying.
> > Let's see if it works around the issue.
> >
> > Index: linux-2.6/drivers/char/hw_random/intel-rng.c
> > ===================================================================
> > --- linux-2.6.orig/drivers/char/hw_random/intel-rng.c   2006-06-27 17:48:13.000000000 +0200
> > +++ linux-2.6/drivers/char/hw_random/intel-rng.c        2006-07-26 17:27:03.000000000 +0200
> > @@ -104,9 +104,14 @@
> >         int err = -EIO;
> >
> >         hw_status = hwstatus_get(mem);
> > +       hw_status = hwstatus_set(mem, hw_status & ~INTEL_RNG_ENABLED);
> > +       hw_status = hwstatus_set(mem, hw_status | INTEL_RNG_ENABLED);
> > +#if 0
> > +       hw_status = hwstatus_get(mem);
> >         /* turn RNG h/w on, if it's off */
> >         if ((hw_status & INTEL_RNG_ENABLED) == 0)
> >                 hw_status = hwstatus_set(mem, hw_status | INTEL_RNG_ENABLED);
> > +#endif
> >         if ((hw_status & INTEL_RNG_ENABLED) == 0) {
> >                 printk(KERN_ERR PFX "cannot enable RNG, aborting\n");
> >                 goto out;
> 
> well as it didn't work, are you sure it was not intended to be more like this:
> @@ -104,9 +104,14 @@
>        int err = -EIO;
> 
>        hw_status = hwstatus_get(mem);
> +       hw_status = hwstatus_set(mem, hw_status & ~INTEL_RNG_ENABLED);
> +       hw_status = hwstatus_set(mem, hw_status | INTEL_RNG_ENABLED);
> +#if 0
>        /* turn RNG h/w on, if it's off */
>        if ((hw_status & INTEL_RNG_ENABLED) == 0)
>                hw_status = hwstatus_set(mem, hw_status | INTEL_RNG_ENABLED);
> +#endif
>        if ((hw_status & INTEL_RNG_ENABLED) == 0) {
>                printk(KERN_ERR PFX "cannot enable RNG, aborting\n");
>                goto out;
> 
> ?

I don't think that makes a difference to the generated code, does it?

-- 
Greetings Michael.
