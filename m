Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264493AbTIIVeG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 17:34:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264495AbTIIVeF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 17:34:05 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:19474 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S264493AbTIIVdw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 17:33:52 -0400
Date: Tue, 9 Sep 2003 22:33:47 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Zwane Mwaikambo <zwane@linuxpower.ca>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Buggy PCI drivers - do not mark pci_device_id as discardable data
Message-ID: <20030909223347.U4216@flint.arm.linux.org.uk>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Zwane Mwaikambo <zwane@linuxpower.ca>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20030909204803.N4216@flint.arm.linux.org.uk> <Pine.LNX.4.53.0309091559110.14426@montezuma.fsmlabs.com> <20030909220452.S4216@flint.arm.linux.org.uk> <1063142578.30981.22.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1063142578.30981.22.camel@dhcp23.swansea.linux.org.uk>; from alan@lxorguk.ukuu.org.uk on Tue, Sep 09, 2003 at 10:22:59PM +0100
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 09, 2003 at 10:22:59PM +0100, Alan Cox wrote:
> On Maw, 2003-09-09 at 22:04, Russell King wrote:
> > I want this to be foolproof, because its me people bug when their cardbus
> > cards oops when they insert the damned things.  If people are happy to
> > ignore this issue, I'm happy to ignore the bug reports.
> > 
> > It basically isn't something I want to deal with, and we need to find a
> > way to stop these stupidities appearing in the first place.
> > 
> > Any ideas?
> 
> You've already got symbols for initdata start and end, just check the 
> pointers in the pci_register code. I guess you want a per platform
> 
> BUG_IF_INIT(x)

That would work for built-in drivers.  We could couple that with an idea
Kai came up with (in private mail) to catch them in modpost.  However,
the problem with modpost is that it gets false positives for these
drivers which explicitly want to discard their module device id tables.

As we currently stand, there seem to be only four drivers which want to
discard their driver id tables.  Is it really worth adding extra code
to the kernel to try to trap these, or just not mark the device id
tables with __initdata or __devinitdata and detect the bad guys with
a grep?

-- 
Russell King (rmk@arm.linux.org.uk)	http://www.arm.linux.org.uk/personal/
Linux kernel maintainer of:
  2.6 ARM Linux   - http://www.arm.linux.org.uk/
  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
  2.6 Serial core
