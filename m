Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264361AbUAKPC2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jan 2004 10:02:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265882AbUAKPC2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jan 2004 10:02:28 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:16909 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S264361AbUAKPC0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jan 2004 10:02:26 -0500
Date: Sun, 11 Jan 2004 15:02:23 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: kernel 2.6: can't get 3c575/PCMCIA working - other PCMCIA card work
Message-ID: <20040111150223.A8427@flint.arm.linux.org.uk>
Mail-Followup-To: linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <20040106111939.GA2046@piper.madduck.net> <20040111120053.C1931@flint.arm.linux.org.uk> <20040111123208.GA4766@piper.madduck.net> <20040111125404.E1931@flint.arm.linux.org.uk> <20040111144343.GA8410@piper.madduck.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040111144343.GA8410@piper.madduck.net>; from madduck@madduck.net on Sun, Jan 11, 2004 at 03:43:43PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 11, 2004 at 03:43:43PM +0100, martin f krafft wrote:
> also sprach Russell King <rmk+lkml@arm.linux.org.uk> [2004.01.11.1354 +0100]:
> > Cardbus cards look exactly like normal PCI cards, and are therefore
> > the drivers are handled by the PCI subsystem.  PCMCIA helps out only
> > to detect the card insertion/removal events.
> 
> Are you sure about the latter.

Yes.

> Cause the driver gets loaded whether cardmgr is started or not. But in
> any case, cardmgr does not configure the interface.

cardmgr doesn't play a part when you've inserted a cardbus card - it
doesn't even know that a card has been inserted into the slot.

> Where can I find
> the hook for Cardbus cards to do configuration after initialisation?

It's all done via the hotplug subsystem, which is integrated into the
driver model.

Basically, we discover that a cardbus card has been inserted, and ask
the PCI layer to scan the slot.  We add the new device to the list of
PCI devices, which automatically causes the hotplug system to call
/sbin/hotplug for the new PCI device.

The hotplug scripts are then supposed to load the driver as necessary
(using /etc/modules.conf) which creates a network interface.  This then
causes the hotplug scripts to be invoked again, this time for the new
network interface, which should configure it.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
