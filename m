Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262052AbVFHAaw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262052AbVFHAaw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Jun 2005 20:30:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262053AbVFHAaw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Jun 2005 20:30:52 -0400
Received: from gate.crashing.org ([63.228.1.57]:49818 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262052AbVFHAaq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Jun 2005 20:30:46 -0400
Subject: Re: [PATCH] fix tulip suspend/resume
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Adam Belay <abelay@novell.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jgarzik@pobox.com>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>, Karsten Keil <kkeil@suse.de>
In-Reply-To: <20050607205800.GB8300@neo.rr.com>
References: <20050606224645.GA23989@pingi3.kke.suse.de>
	 <Pine.LNX.4.58.0506061702430.1876@ppc970.osdl.org>
	 <20050607025054.GC3289@neo.rr.com>
	 <20050607105552.GA27496@pingi3.kke.suse.de>
	 <20050607205800.GB8300@neo.rr.com>
Content-Type: text/plain
Date: Wed, 08 Jun 2005 10:26:12 +1000
Message-Id: <1118190373.6850.85.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> pci_power_t pci_choose_state(struct pci_dev *dev, pm_message_t state)
> {
> 	if (!pci_find_capability(dev, PCI_CAP_ID_PM))
> 		return PCI_D0;
> 
> 	switch (state) {
> 	case 0: return PCI_D0;
> 	case 3: return PCI_D3hot;
> 	default:
> 		printk("They asked me for state %d\n", state);
> 		BUG();
> 	}
> 	return PCI_D0;
> }

Gack ! I need to remember to fix that one before I change PMSG_FREEZE
definition to be different than PMSG_SUSPEND upstream.

Pavel, do you know that there are other ways to deal with errors than
just BUG()'ing all over the place ? :)

Ben.


