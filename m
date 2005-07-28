Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261402AbVG1LN7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261402AbVG1LN7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 07:13:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261404AbVG1LN7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 07:13:59 -0400
Received: from grendel.sisk.pl ([217.67.200.140]:40923 "HELO mail.sisk.pl")
	by vger.kernel.org with SMTP id S261402AbVG1LN6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 07:13:58 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Shaohua Li <shaohua.li@intel.com>
Subject: Re: [ACPI] Re: [Alsa-devel] [PATCH] 2.6.13-rc3-git5: fix Bug #4416 (1/2)
Date: Thu, 28 Jul 2005 13:18:56 +0200
User-Agent: KMail/1.8.1
Cc: Takashi Iwai <tiwai@suse.de>, Pavel Machek <pavel@suse.cz>,
       LKML <linux-kernel@vger.kernel.org>,
       ACPI mailing list <acpi-devel@lists.sourceforge.net>,
       Andrew Morton <akpm@osdl.org>, alsa-devel@alsa-project.org
References: <200507261247.05684.rjw@sisk.pl> <200507281043.14697.rjw@sisk.pl> <1122540486.2903.8.camel@linux-hp.sh.intel.com>
In-Reply-To: <1122540486.2903.8.camel@linux-hp.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507281318.57011.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, 28 of July 2005 10:48, Shaohua Li wrote:
> On Thu, 2005-07-28 at 10:43 +0200, Rafael J. Wysocki wrote:
> > Hi,
> > 
> > On Thursday, 28 of July 2005 10:06, Takashi Iwai wrote:
> > > At Wed, 27 Jul 2005 22:52:49 +0200,
> > > Pavel Machek wrote:
> > > > 
> > > > Hi!
> > > > 
> > > > > > The following patch adds free_irq() and request_irq() to the suspend and
> > > > > > resume, respectively, routines in the snd_intel8x0 driver.
> > > > > 
> > > > > The patch looks OK to me although I have some concerns.
> > > > > 
> > > > > - The error in resume can't be handled properly.
> > > > > 
> > > > >   What should we do for the error of request_irq()?
> > > > > 
> > > > > - Adding this to all drivers seem too much.
> > > > 
> > > > There's probably no other way. Talk to Len Brown.
> > > > 
> > > > >   We just need to stop the irq processing until resume, so something
> > > > >   like suspend_irq(irq, dev_id) and resume_irq(irq, dev_id) would be
> > > > >   more uesful?
> > > > 
> > > > Its more complex than that. Irq numbers may change during resume.
> > > 
> > > Hmm, then the patch looks wrong.  It assumes that the irq number is
> > > as same as before suspend.
> > 
> > Well, that''s the theory, but frankly I don't see a practical reason.  I have never
> > seen this happening.  Practically, for this to happen, you'll have to reconfigure
> > the BIOS accross suspend/resume which is dangerous anyway.
> From my understanding, we should not have such assumption. Say all
> device drivers with the same ioapic pin have freed irq. We might mask
> the ioapic pin and even free the vector. Then after you request_irq
> again, the interrupt might get different vector. If you enable MSI, then
> it's broken.
> In IA64, we already have such staff (mask ioapic pin and free vector).

All right then.  Still the patch is urgently needed for some systems that do
not have MSI and IMO the detection of the IRQ change can be implemented
on top of it.

Greets,
Rafael


-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
