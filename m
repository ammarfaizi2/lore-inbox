Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262135AbVAEALh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262135AbVAEALh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 19:11:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262295AbVAEAIp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 19:08:45 -0500
Received: from gprs215-128.eurotel.cz ([160.218.215.128]:18560 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S262360AbVADVoI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 16:44:08 -0500
Date: Tue, 4 Jan 2005 22:43:15 +0100
From: Pavel Machek <pavel@suse.cz>
To: Martin Lucina <mato@kotelna.sk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] swsusp: properly suspend and resume *all* devices
Message-ID: <20050104214315.GB1520@elf.ucw.cz>
References: <20041228144741.GA2969@butterfly.hjsoft.com> <20050101172344.GA1355@elf.ucw.cz> <20050102055753.GB7406@ip68-4-98-123.oc.oc.cox.net> <20050102184239.GA21322@butterfly.hjsoft.com> <1104696556.2478.12.camel@pefyra> <20050103051018.GA4413@ip68-4-98-123.oc.oc.cox.net> <20050103084713.GB2099@elf.ucw.cz> <20050103101423.GA4441@ip68-4-98-123.oc.oc.cox.net> <20050103150505.GA4120@ip68-4-98-123.oc.oc.cox.net> <loom.20050104T093741-631@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <loom.20050104T093741-631@post.gmane.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > devices. This has been the case since at least 2.6.9, if not earlier.
> > 
> > One effect of this is that resuming fails to properly reconfigure
> > interrupt routers. In 2.6.9 this was obscured by other kernel code,
> > but in 2.6.10 this often causes post-resume APIC errors and near-total
> > failure of some PCI devices (e.g. network, sound and USB controllers).
> 
> I'm seeing a variation (?) of this problem with 2.6.10. I have the same symptoms
> as you describe above, but on a machine without an APIC, using APM for
> suspend/resume. (Toshiba Portege 7220cte, which has an Intel 440BX chipset)
> 
> Obviously, I don't get the APIC errors, but everything else is the same, random
> devices fail and need to be reloaded (3c59x and uhci-hcd in particular), plus
> the system appears to panic somewhere along the way to resume occasionally (as I
> assume from the hung machine and blinking CAPS LOCK), which didn't happen
> previously (2.6.9, 2.6.8.1, ...). I also see lots of 
> 
> drivers/usb/input/hid-core.c: input irq status -84 received
> 
> until I do a 'rmmod uhci_hcd; modprobe uhci_hcd'. This used to happen with 2.6.9
> as well, but the system would recover after about 20 messages or so like this
> after a resume.
> 
> Any suggestions about where to look to track this down?

USB stuff should be discussed on the USB mailing list. Unload uhci_hcd
before suspend and reload it after resume to make sure it does not
interfere.

Check if 3c59x has suspend/resume support. If not, add it.

Panic... we really need to know why it panicked. VESAFB does not
support blanking, just switch to VESAFB and you should be able to see
the messages. 
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
