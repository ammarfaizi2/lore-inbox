Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261406AbVACIrb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261406AbVACIrb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 03:47:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261407AbVACIrb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 03:47:31 -0500
Received: from gprs214-248.eurotel.cz ([160.218.214.248]:28295 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S261406AbVACIr1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 03:47:27 -0500
Date: Mon, 3 Jan 2005 09:47:13 +0100
From: Pavel Machek <pavel@ucw.cz>
To: "Barry K. Nathan" <barryn@pobox.com>
Cc: lindqvist@netstar.se, edi@gmx.de, john@hjsoft.com,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.10: e100 network broken after swsusp/resume
Message-ID: <20050103084713.GB2099@elf.ucw.cz>
References: <20041228144741.GA2969@butterfly.hjsoft.com> <20050101172344.GA1355@elf.ucw.cz> <20050102055753.GB7406@ip68-4-98-123.oc.oc.cox.net> <20050102184239.GA21322@butterfly.hjsoft.com> <1104696556.2478.12.camel@pefyra> <20050103051018.GA4413@ip68-4-98-123.oc.oc.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050103051018.GA4413@ip68-4-98-123.oc.oc.cox.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > The Documentation/kernel-parameters.txt says this about pci=routeirq:
> > "Do IRQ routing for all PCI devices. This is normally done in
> > pci_enable_device(), so this option is a temporary workaround for broken
> > drivers that don't call it."
> > 
> > Ie, it doesn't sound too bad to use it until the problem is solved.
> > And I don't know if this particular issue is a case of broken drivers,
> > but that was what the parameter was added to work around.
> 
> I don't think this is a case of broken drivers. So far in this thread, it's
> been seen with e100, 8139too, snd-intel8x0, and probably one of the USB
> drivers too. And the problem happens even if the module is unloaded and
> reloaded -- unless I'm seriously missing something, this probably means
> pci_enable_device() is unable to do its job properly for some reason --
> but only after a swsusp resume.
...
> So, I think this bug probably lies in ACPI or swsusp. I highly *highly*
> doubt it's driver bugs. Hopefully I'll have time later tonight or
> tomorrow morning to see if I can figure anything else out...

Actually, as you found out in earlier mail, problem is in the driver;
but it is the interrupt controller driver.

Right soution is to save APICs state during sysdev_suspend(), and
resture it during sysdev_resume().
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
