Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751343AbWG0OUM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751343AbWG0OUM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 10:20:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751335AbWG0OUL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 10:20:11 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:20920 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751344AbWG0OUJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 10:20:09 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Ssw3ZTB95jJsmPTvHrKfrVxuvREDSY8MxVMtjAWocCVsDSZWbrK+YAP5KV1lpi3J7nTDdikg171pJNq/s6rZGyMvMSKdlDrpTWAe/2okrxDPL3UQL+//jqQzRtYy1n4sL5QQP8gTnsGgxIgIJnoXC4yDhDYcS1KKEDlqR/1hm4c=
Message-ID: <f96157c40607270720n1dd5443avfdb53641a1cdad6f@mail.gmail.com>
Date: Thu, 27 Jul 2006 14:20:07 +0000
From: "gmu 2k6" <gmu2006@gmail.com>
To: "Michael Buesch" <mb@bu3sch.de>
Subject: Re: hwrng on 82801EB/ER (ICH5/ICH5R) fails rngtest checks
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200607271529.39549.mb@bu3sch.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060725222209.0048ed15.akpm@osdl.org>
	 <200607261730.31717.mb@bu3sch.de>
	 <f96157c40607261244m205ff68dh5563c66436a2e67@mail.gmail.com>
	 <200607271529.39549.mb@bu3sch.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/27/06, Michael Buesch <mb@bu3sch.de> wrote:
> On Wednesday 26 July 2006 21:44, gmu 2k6 wrote:
> > > But could you try the following patch on top of latest git?
> > > It's just a random test, but I think it's worth trying.
> > > Let's see if it works around the issue.
> > >
> > > Index: linux-2.6/drivers/char/hw_random/intel-rng.c
> > > ===================================================================
> > > --- linux-2.6.orig/drivers/char/hw_random/intel-rng.c   2006-06-27 17:48:13.000000000 +0200
> > > +++ linux-2.6/drivers/char/hw_random/intel-rng.c        2006-07-26 17:27:03.000000000 +0200
> > > @@ -104,9 +104,14 @@
> > >         int err = -EIO;
> > >
> > >         hw_status = hwstatus_get(mem);
> > > +       hw_status = hwstatus_set(mem, hw_status & ~INTEL_RNG_ENABLED);
> > > +       hw_status = hwstatus_set(mem, hw_status | INTEL_RNG_ENABLED);
> > > +#if 0
> > > +       hw_status = hwstatus_get(mem);
> > >         /* turn RNG h/w on, if it's off */
> > >         if ((hw_status & INTEL_RNG_ENABLED) == 0)
> > >                 hw_status = hwstatus_set(mem, hw_status | INTEL_RNG_ENABLED);
> > > +#endif
> > >         if ((hw_status & INTEL_RNG_ENABLED) == 0) {
> > >                 printk(KERN_ERR PFX "cannot enable RNG, aborting\n");
> > >                 goto out;
> >
> > well as it didn't work, are you sure it was not intended to be more like this:
> > @@ -104,9 +104,14 @@
> >        int err = -EIO;
> >
> >        hw_status = hwstatus_get(mem);
> > +       hw_status = hwstatus_set(mem, hw_status & ~INTEL_RNG_ENABLED);
> > +       hw_status = hwstatus_set(mem, hw_status | INTEL_RNG_ENABLED);
> > +#if 0
> >        /* turn RNG h/w on, if it's off */
> >        if ((hw_status & INTEL_RNG_ENABLED) == 0)
> >                hw_status = hwstatus_set(mem, hw_status | INTEL_RNG_ENABLED);
> > +#endif
> >        if ((hw_status & INTEL_RNG_ENABLED) == 0) {
> >                printk(KERN_ERR PFX "cannot enable RNG, aborting\n");
> >                goto out;
> >
> > ?
>
> I don't think that makes a difference to the generated code, does it?

I will test it now as you seem to be interested in the results.

actually I was just curious what sense it made to do
hw_status = hwstatus_get(mem);
twice, though I'm not informed about the semantics there so I could be wrong
in interpreting the API on that level.
