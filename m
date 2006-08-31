Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932310AbWHaNjo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932310AbWHaNjo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 09:39:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932309AbWHaNjo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 09:39:44 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:43172 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932310AbWHaNjn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 09:39:43 -0400
Date: Thu, 31 Aug 2006 15:39:29 +0200
From: Pavel Machek <pavel@suse.cz>
To: Takashi Iwai <tiwai@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, kernel list <linux-kernel@vger.kernel.org>,
       perex@suse.cz, alsa-devel@alsa-project.org, pshou@realtek.com.tw
Subject: Re: sound/pci/hda/intel_hda: small cleanups
Message-ID: <20060831133929.GH3923@elf.ucw.cz>
References: <20060831123706.GC3923@elf.ucw.cz> <s5h8xl52h52.wl%tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5h8xl52h52.wl%tiwai@suse.de>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > @@ -271,8 +272,8 @@ struct azx_dev {
> >  	/* for sanity check of position buffer */
> >  	unsigned int period_intr;
> >  
> > -	unsigned int opened: 1;
> > -	unsigned int running: 1;
> > +	unsigned int opened :1;
> > +	unsigned int running :1;
> >  };
> >  
> >  /* CORB/RIRB */
> > @@ -330,8 +331,8 @@ struct azx {
> >  
> >  	/* flags */
> >  	int position_fix;
> > -	unsigned int initialized: 1;
> > -	unsigned int single_cmd: 1;
> > +	unsigned int initialized :1;
> > +	unsigned int single_cmd :1;
> >  };
> 
> Any official standard reference for bit-field expressions?

Well, logically : belongs to the 1, and include/linux understands it
like that...

> >  /* driver types */
> > @@ -642,14 +643,14 @@ static int azx_reset(struct azx *chip)
> >  	azx_writeb(chip, GCTL, azx_readb(chip, GCTL) | ICH6_GCTL_RESET);
> >  
> >  	count = 50;
> > -	while (! azx_readb(chip, GCTL) && --count)
> > +	while (!azx_readb(chip, GCTL) && --count)
> >  		msleep(1);
> 
> Hm, it looks rather like a personal preference.
> IMHO, it's harder to read without space...

Well, core parts (sched.c?) use it without the space, and I'd say (!
expression) is unusual in kernel, but no, could not find it codified.

> I'll fix the volatile things separately.

Thanks.
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
