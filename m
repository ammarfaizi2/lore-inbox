Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262340AbVDFXEB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262340AbVDFXEB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Apr 2005 19:04:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262341AbVDFXEB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Apr 2005 19:04:01 -0400
Received: from gate.crashing.org ([63.228.1.57]:35794 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262340AbVDFXD6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Apr 2005 19:03:58 -0400
Subject: Re: [linux-usb-devel] USB glitches after suspend on ppc
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Brownell <david-b@pacbell.net>
Cc: Linux-USB <linux-usb-devel@lists.sourceforge.net>,
       Colin Leroy <colin@colino.net>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       "debian-powerpc@lists.debian.org" <debian-powerpc@lists.debian.org>
In-Reply-To: <200504061311.53720.david-b@pacbell.net>
References: <20050405204449.5ab0cdea@jack.colino.net>
	 <200504051353.36788.david-b@pacbell.net>
	 <20050406192007.7f71c61d@jack.colino.net>
	 <200504061311.53720.david-b@pacbell.net>
Content-Type: text/plain
Date: Thu, 07 Apr 2005 09:02:57 +1000
Message-Id: <1112828577.9568.199.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Interesting.  Looks like pci_enable_wake(dev, state, 0) isn't actually
> disabling wakeup on your hardware.  (Assuming CONFIG_USB_SUSPEND=n; if
> not, then it's odd that the system went back to sleep!)  Do you think
> that might be related to those calls manipulating the Apple ASICs being
> in the OHCI layer rather than up nearer the generic PCI glue?  (I still
> think they don't belong in USB code -- ohci or usbcore -- at all.  If
> the platform-specific PCI hooks don't suffice, they need fixing.)

There are no platform hooks in the right place for now afaik. Anyway, I
think Colin's controller is an OHCI/EHCI NEC chip, so not an Apple ASIC,
it's not doing anything in those calls.

> Thanks for the testing update.  I'm glad to know that there seems to
> be only one (minor) glitch that's PPC-specific!

Which is just an off-the-shelves NEC EHCI chip.

> > - once out of two resumes, resume leaves the ports unpowered; so I still
> > need my usb-ehci-power.patch that re-powers ports unconditionnaly.
> 
> OK, I just posted the patch cleaning up EHCI port power switching;
> that should remove the need for that separate patch.  (As well as
> fixing some minor annoyances.)
> 
> - Dave
> 
> 
-- 
Benjamin Herrenschmidt <benh@kernel.crashing.org>

