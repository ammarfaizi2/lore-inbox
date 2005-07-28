Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261370AbVG1InZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261370AbVG1InZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 04:43:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261336AbVG1IlS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 04:41:18 -0400
Received: from fmr19.intel.com ([134.134.136.18]:62189 "EHLO
	orsfmr004.jf.intel.com") by vger.kernel.org with ESMTP
	id S261370AbVG1Iiu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 04:38:50 -0400
Subject: Re: [ACPI] Re: [Alsa-devel] [PATCH] 2.6.13-rc3-git5: fix Bug #4416
	(1/2)
From: Shaohua Li <shaohua.li@intel.com>
To: Takashi Iwai <tiwai@suse.de>
Cc: Pavel Machek <pavel@suse.cz>, "Rafael J. Wysocki" <rjw@sisk.pl>,
       LKML <linux-kernel@vger.kernel.org>,
       ACPI mailing list <acpi-devel@lists.sourceforge.net>,
       Andrew Morton <akpm@osdl.org>, alsa-devel@alsa-project.org
In-Reply-To: <s5hr7djtkvo.wl%tiwai@suse.de>
References: <200507261247.05684.rjw@sisk.pl>
	 <200507261251.48291.rjw@sisk.pl> <s5hmzo8ljf6.wl%tiwai@suse.de>
	 <20050727205249.GA708@openzaurus.ucw.cz>  <s5hr7djtkvo.wl%tiwai@suse.de>
Content-Type: text/plain
Date: Thu, 28 Jul 2005 16:37:29 +0800
Message-Id: <1122539849.2903.3.camel@linux-hp.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-07-28 at 10:06 +0200, Takashi Iwai wrote:
> At Wed, 27 Jul 2005 22:52:49 +0200,
> Pavel Machek wrote:
> > 
> > Hi!
> > 
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
> 
> Sorry for ignorance, but, is only irq affected?  Are the other
> resources like ioport consistent after resume?
Resource changes might be helpful for resource balance (device hotplug).
But suspend/resume doesn't use it. So resources are consistent after
resume except irq to me.

Thanks,
Shaohua

