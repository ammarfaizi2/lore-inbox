Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261308AbVG1IxQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261308AbVG1IxQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 04:53:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261375AbVG1IxQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 04:53:16 -0400
Received: from fmr19.intel.com ([134.134.136.18]:16261 "EHLO
	orsfmr004.jf.intel.com") by vger.kernel.org with ESMTP
	id S261308AbVG1IxO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 04:53:14 -0400
Subject: Re: [ACPI] Re: [Alsa-devel] [PATCH] 2.6.13-rc3-git5: fix Bug #4416
	(1/2)
From: Shaohua Li <shaohua.li@intel.com>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Takashi Iwai <tiwai@suse.de>, Pavel Machek <pavel@suse.cz>,
       LKML <linux-kernel@vger.kernel.org>,
       ACPI mailing list <acpi-devel@lists.sourceforge.net>,
       Andrew Morton <akpm@osdl.org>, alsa-devel@alsa-project.org
In-Reply-To: <200507281043.14697.rjw@sisk.pl>
References: <200507261247.05684.rjw@sisk.pl>
	 <20050727205249.GA708@openzaurus.ucw.cz> <s5hr7djtkvo.wl%tiwai@suse.de>
	 <200507281043.14697.rjw@sisk.pl>
Content-Type: text/plain
Date: Thu, 28 Jul 2005 16:48:06 +0800
Message-Id: <1122540486.2903.8.camel@linux-hp.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-07-28 at 10:43 +0200, Rafael J. Wysocki wrote:
> Hi,
> 
> On Thursday, 28 of July 2005 10:06, Takashi Iwai wrote:
> > At Wed, 27 Jul 2005 22:52:49 +0200,
> > Pavel Machek wrote:
> > > 
> > > Hi!
> > > 
> > > > > The following patch adds free_irq() and request_irq() to the suspend and
> > > > > resume, respectively, routines in the snd_intel8x0 driver.
> > > > 
> > > > The patch looks OK to me although I have some concerns.
> > > > 
> > > > - The error in resume can't be handled properly.
> > > > 
> > > >   What should we do for the error of request_irq()?
> > > > 
> > > > - Adding this to all drivers seem too much.
> > > 
> > > There's probably no other way. Talk to Len Brown.
> > > 
> > > >   We just need to stop the irq processing until resume, so something
> > > >   like suspend_irq(irq, dev_id) and resume_irq(irq, dev_id) would be
> > > >   more uesful?
> > > 
> > > Its more complex than that. Irq numbers may change during resume.
> > 
> > Hmm, then the patch looks wrong.  It assumes that the irq number is
> > as same as before suspend.
> 
> Well, that''s the theory, but frankly I don't see a practical reason.  I have never
> seen this happening.  Practically, for this to happen, you'll have to reconfigure
> the BIOS accross suspend/resume which is dangerous anyway.
>From my understanding, we should not have such assumption. Say all
device drivers with the same ioapic pin have freed irq. We might mask
the ioapic pin and even free the vector. Then after you request_irq
again, the interrupt might get different vector. If you enable MSI, then
it's broken.
In IA64, we already have such staff (mask ioapic pin and free vector).

Thanks,
Shaohua

