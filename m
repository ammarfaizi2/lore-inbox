Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265701AbUFXVkX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265701AbUFXVkX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 17:40:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265727AbUFXVkW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 17:40:22 -0400
Received: from gprs214-211.eurotel.cz ([160.218.214.211]:15489 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S265701AbUFXVjP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 17:39:15 -0400
Date: Thu, 24 Jun 2004 23:38:58 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Patrick Mochel <mochel@digitalimplant.org>
Cc: kernel list <linux-kernel@vger.kernel.org>,
       Swsusp mailing list <swsusp-devel@lists.sourceforge.net>
Subject: Re: SMP support for swsusp (this one actually works for me)
Message-ID: <20040624213858.GC20649@elf.ucw.cz>
References: <20040623121727.GA26623@elf.ucw.cz> <Pine.LNX.4.50.0406241354340.32272-100000@monsoon.he.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.50.0406241354340.32272-100000@monsoon.he.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Here's SMP support for swsusp; this one actually works for me [with
> > keyboard hack], but I'd like more testers. If it looks okay, I'll
> > merge simple pieces with andrew.
> 
> This looks cool, but I have some aesthetic nits about it:

I'll kill #if 0s before attempting to merge.

> > +#ifdef CONFIG_SMP
> > +extern void smp_freeze(void);
> > +extern void smp_restart(void);
> > +#else
> > +static inline void smp_freeze(void) {}
> > +static inline void smp_restart(void) {}
> > +#endif
> 
> Could you name those something more explicit, like swsusp_smp_freeze(),
> etc, so you don't have potential namespace conflicts?

I guess that S3 sleep might find them usefull, too.

Perhaps calling them disable_nonboot_cpus() and enable_nonboot_cpus()
are better names?

> > -void save_processor_state(void)
> > +void __save_processor_state(struct saved_context *ctxt)
> 
> > +void save_processor_state(void)
> > +{
> > +	__save_processor_state(&saved_context);
> >  }
> 
> This also looks completely gratuitous and confusing - if you're not doing
> anything else but calling the __function, then why even create
> __function?

__save_processor_state() is needed from smp.c, save_processor_state()
is needed from swsusp.S. I did not want to break that for now.

> >  EXPORT_SYMBOL(save_processor_state);
> >  EXPORT_SYMBOL(restore_processor_state);
> 
> And, why are they exported in the first place?

Not sure... swsusp can't be modular so I should be able to just kill
this, right?

> > %diffstat
> >  Documentation/power/swsusp.txt   |    5 +
> >  Documentation/power/video.txt    |    4 +
...
> >  kernel/power/smp.c               |   85 ++++++++++++++++++++++++++++++
> >  kernel/power/swsusp.c            |   78 +++++++++++++++++++--------
> >  kernel/signal.c                  |    6 +-
> >  17 files changed, 293 insertions(+), 102 deletions(-)
> 
> Were there more files to the patch? Some of the ones listed here were not
> in the email?

I hand-edited the diff and forgot to kill this, sorry. Nothing should
be missing.

> BTW, nice work.

Thanks!
									Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
