Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S273111AbTHKTN0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 15:13:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S273019AbTHKTLy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 15:11:54 -0400
Received: from b.smtp-out.sonic.net ([208.201.224.39]:8347 "HELO
	b.smtp-out.sonic.net") by vger.kernel.org with SMTP id S273015AbTHKTLq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 15:11:46 -0400
X-envelope-info: <dhinds@sonic.net>
Date: Mon, 11 Aug 2003 12:00:48 -0700
From: David Hinds <dhinds@sonic.net>
To: Jochen Friedrich <jochen@scram.de>
Cc: Russell King <rmk@arm.linux.org.uk>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       dahinds@users.sourceforge.net
Subject: Re: PCI1410 Interrupt Problems
Message-ID: <20030811120048.A13992@sonic.net>
References: <20030807000914.J16116@flint.arm.linux.org.uk> <Pine.LNX.4.44.0308112028300.10344-100000@gfrw1044.bocc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0308112028300.10344-100000@gfrw1044.bocc.de>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 11, 2003 at 08:33:23PM +0200, Jochen Friedrich wrote:
> Hi Russell,
> 
> > Unfortunately, there are some hacks in the kernel at the moment which
> > mess up the Cardbus IRQ routing by touching this register - the kernel
> > should not be the one to play with hardware design specific register
> > settings, especially when they are applied without thought across
> > many hardware variants.
> 
> after thinking a bit, i believe, you're right here. Initially, i just
> wanted to have an option to mess with this register, but there is already
> the setpci tool which can do exactly this. So for now, i just added the
> setpci command to my modules.conf and i'm set.
> 
> It's just a shame that PCI/Cardbus bridge manufacturers try to save a few
> cents by not soldering the configuration EEPROM to their board and supply
> some specialized drivers for Win just to make their crap work. So if you
> place 2 different cards in the same PC with the same PCI1410 but different
> pin mapping, you're doomed...

I do think there is room for having some sane default settings to be
used when an unconfigured bridge is detected.  For most of the TI
bridges, there is only one reasonable default for how to enable PCI
interrupt delivery.  The important part here is "unconfigured bridge":
never fool with interrupt delivery on a bridge that has been set up
by the BIOS, which covers essentially all laptops.

-- Dave
