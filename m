Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262185AbUK0ESo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262185AbUK0ESo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 23:18:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262160AbUK0D5r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 22:57:47 -0500
Received: from zeus.kernel.org ([204.152.189.113]:53187 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S262464AbUKZTbH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 14:31:07 -0500
Date: Thu, 25 Nov 2004 12:28:01 +0100
From: Pavel Machek <pavel@ucw.cz>
To: "Zhu, Yi" <yi.zhu@intel.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-pm@lists.osdl.org
Subject: Re: [linux-pm] [PATCH] make pm_suspend_disk suspend/resume sysdev and dpm_off_irq
Message-ID: <20041125112801.GB1014@elf.ucw.cz>
References: <3ACA40606221794F80A5670F0AF15F8403BD586A@pdsmsx403>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ACA40606221794F80A5670F0AF15F8403BD586A@pdsmsx403>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >> This patch makes the new swsusp code ( pm_suspend_disk since
> >> 2.6.9-rc3) call suspend/resume functions for sysdev and devices in
> >> dpm_off_irq list. Otherwise, PCI link device in the system won't
> >> provide correct interrupt for PCI devices during resume.
> > 
> > I do not think this is right approach; you enable interrupts
> > then disable that again, potentially without interrupt controller
> > being initialized. 
> > 
> > This should be better patch:
> 
> Agreed. Your patch solves the bug. But do you plan to deal with the 
> devices in dpm_off_irq list?

Ouch, okay... Calling irq-off phase of device_suspend() is not
intuitive at all and I hate that -EAGAIN idea.

...ouch, wait, it is less messy than I expected. I have no business
calling sysdev_suspend directly.

I'll test the patch and post it in the next message.
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
