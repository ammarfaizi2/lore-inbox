Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262200AbVFHMUf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262200AbVFHMUf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 08:20:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262196AbVFHMUf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 08:20:35 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:50133 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262193AbVFHMTd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 08:19:33 -0400
Date: Wed, 8 Jun 2005 14:19:13 +0200
From: Pavel Machek <pavel@suse.cz>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Adam Belay <abelay@novell.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jgarzik@pobox.com>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>, Karsten Keil <kkeil@suse.de>
Subject: Re: [PATCH] fix tulip suspend/resume
Message-ID: <20050608121912.GB1898@elf.ucw.cz>
References: <20050606224645.GA23989@pingi3.kke.suse.de> <Pine.LNX.4.58.0506061702430.1876@ppc970.osdl.org> <20050607025054.GC3289@neo.rr.com> <20050607105552.GA27496@pingi3.kke.suse.de> <20050607205800.GB8300@neo.rr.com> <1118190373.6850.85.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1118190373.6850.85.camel@gaston>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > pci_power_t pci_choose_state(struct pci_dev *dev, pm_message_t state)
> > {
> > 	if (!pci_find_capability(dev, PCI_CAP_ID_PM))
> > 		return PCI_D0;
> > 
> > 	switch (state) {
> > 	case 0: return PCI_D0;
> > 	case 3: return PCI_D3hot;
> > 	default:
> > 		printk("They asked me for state %d\n", state);
> > 		BUG();
> > 	}
> > 	return PCI_D0;
> > }
> 
> Gack ! I need to remember to fix that one before I change PMSG_FREEZE
> definition to be different than PMSG_SUSPEND upstream.
> 
> Pavel, do you know that there are other ways to deal with errors than
> just BUG()'ing all over the place ? :)

And how would you propose to deal this this error? PCI_ERROR probably
needs to be invented (for acpi people), but I do not think I want
callers to check for it.
								Pavel
