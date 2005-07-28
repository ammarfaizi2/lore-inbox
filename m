Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261331AbVG1IcI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261331AbVG1IcI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 04:32:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261336AbVG1IcI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 04:32:08 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:20408 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261331AbVG1IcG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 04:32:06 -0400
Date: Thu, 28 Jul 2005 10:31:58 +0200
From: Pavel Machek <pavel@suse.cz>
To: Takashi Iwai <tiwai@suse.de>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, LKML <linux-kernel@vger.kernel.org>,
       ACPI mailing list <acpi-devel@lists.sourceforge.net>,
       Andrew Morton <akpm@osdl.org>, alsa-devel@alsa-project.org,
       Len Brown <len.brown@intel.com>
Subject: Re: [ACPI] Re: [Alsa-devel] [PATCH] 2.6.13-rc3-git5: fix Bug #4416 (1/2)
Message-ID: <20050728083157.GI6529@elf.ucw.cz>
References: <200507261247.05684.rjw@sisk.pl> <200507261251.48291.rjw@sisk.pl> <s5hmzo8ljf6.wl%tiwai@suse.de> <20050727205249.GA708@openzaurus.ucw.cz> <s5hr7djtkvo.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5hr7djtkvo.wl%tiwai@suse.de>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > The following patch adds free_irq() and request_irq() to the suspend and
> > > > resume, respectively, routines in the snd_intel8x0 driver.
> > > 
> > > The patch looks OK to me although I have some concerns.
> > > 
> > > - The error in resume can't be handled properly.
> > > 
> > >   What should we do for the error of request_irq()?
> > > 
> > > - Adding this to all drivers seem too much.
> > 
> > There's probably no other way. Talk to Len Brown.
> > 
> > >   We just need to stop the irq processing until resume, so something
> > >   like suspend_irq(irq, dev_id) and resume_irq(irq, dev_id) would be
> > >   more uesful?
> > 
> > Its more complex than that. Irq numbers may change during resume.
> 
> Hmm, then the patch looks wrong.  It assumes that the irq number is
> as same as before suspend.

> Sorry for ignorance, but, is only irq affected?  Are the other
> resources like ioport consistent after resume?

I think it is only irq, but Len, please take correct me if I'm
wrong. Irq number can change during suspend/resume cycle, right?

								Pavel
-- 
teflon -- maybe it is a trademark, but it should not be.
