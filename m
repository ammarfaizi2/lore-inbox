Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261648AbVGaJof@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261648AbVGaJof (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Jul 2005 05:44:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261650AbVGaJoe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Jul 2005 05:44:34 -0400
Received: from grendel.sisk.pl ([217.67.200.140]:37572 "HELO mail.sisk.pl")
	by vger.kernel.org with SMTP id S261648AbVGaJod (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Jul 2005 05:44:33 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: linux-kernel@vger.kernel.org
Subject: Re: revert yenta free_irq on suspend
Date: Sun, 31 Jul 2005 11:49:38 +0200
User-Agent: KMail/1.8.1
Cc: "Brown, Len" <len.brown@intel.com>, "Linus Torvalds" <torvalds@osdl.org>,
       "Russell King" <rmk+lkml@arm.linux.org.uk>,
       "Hugh Dickins" <hugh@veritas.com>, "Andrew Morton" <akpm@osdl.org>,
       "Dominik Brodowski" <linux@dominikbrodowski.net>,
       "Daniel Ritz" <daniel.ritz@gmx.ch>, Li Shaohua <shaohua.li@intel.com>
References: <F7DC2337C7631D4386A2DF6E8FB22B3004311E37@hdsmsx401.amr.corp.intel.com>
In-Reply-To: <F7DC2337C7631D4386A2DF6E8FB22B3004311E37@hdsmsx401.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507311149.39835.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday, 31 of July 2005 07:03, Brown, Len wrote:
> >So I guess I'll just have to revert the ACPI change that 
> >caused drivers to do request_irq/free_irq. I'd prefer it
> >if the ACPI people did that revert themselves, though.
> 
> If that is what you want, I'll be happy to do it.
> 
> If one believes that suspend/resume is working on a large number of
> systems -- working to a level that a distro can acutally support it,
> then restoring our temporary resume IRQ router hack to make many systems
> work
> is clearly the right thing to do.
> 
> But that believe would be total fantasy -- supsend/resume is not
> working on a large number of machines, and no distro is currently
> able to support it.  (I'm talking about S3 suspend to RAM primarily,
> suspend to disk is less interesting -- though Red Hat doesn't
> even support _that_)
> 
> We can got back to the old hack, but it will probably just delay
> the day that suspend/resume is working broadly, and actually
> can be deployed and supported by distros.

May I propose to keep this change in -mm?

This issue has already been discussed on the linux-pm list and the people
there seem to agree thet the way to go is to convert all PCI drivers to the
model in which they drop their IRQs on suspend and request them back on
resume (ref. http://lists.osdl.org/pipermail/linux-pm/2005-May/000955.html).

There are some drivers that already do it (eg the USB drivers), but there are
many drivers that don't and in fact the recent problems have been related to
them.  If the change stays in -mm we will be able to convert the drivers
gradually and they will hopefully get some testing.  When it's done, it
will be safe to push the change along with the converted drivers to
mainline.

Greets,
Rafael


-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
