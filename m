Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262641AbVGHMi4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262641AbVGHMi4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 08:38:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262626AbVGHMiz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 08:38:55 -0400
Received: from ra.tuxdriver.com ([24.172.12.4]:23051 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S262641AbVGHMiR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 08:38:17 -0400
Date: Fri, 8 Jul 2005 08:37:50 -0400
From: "John W. Linville" <linville@tuxdriver.com>
To: david-b@pacbell.net
Cc: ink@jurassic.park.msu.ru, rmk+lkml@arm.linux.org.uk, matthew@wil.cx,
       linux-pm@lists.osdl.org, linux-pci@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org, grundler@parisc-linux.org
Subject: Re: [linux-pm] [patch 2.6.13-rc2] pci: restore BAR values in pci_set_power_state for D3hot->D0
Message-ID: <20050708123747.GA13445@tuxdriver.com>
Mail-Followup-To: david-b@pacbell.net, ink@jurassic.park.msu.ru,
	rmk+lkml@arm.linux.org.uk, matthew@wil.cx, linux-pm@lists.osdl.org,
	linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
	grundler@parisc-linux.org
References: <20050701014056.GA13710@tuxdriver.com> <20050701022634.GA5629.1@tuxdriver.com> <20050702072954.GA14091@colo.lackof.org> <20050702090913.B1506@flint.arm.linux.org.uk> <20050705200555.GA4756@parcelfarce.linux.theplanet.co.uk> <20050705224620.B15292@flint.arm.linux.org.uk> <20050706033454.A706@den.park.msu.ru> <20050708005701.GA13384@tuxdriver.com> <20050708005934.GB13384@tuxdriver.com> <20050708034302.267AF85EC2@adsl-69-107-32-110.dsl.pltn13.pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050708034302.267AF85EC2@adsl-69-107-32-110.dsl.pltn13.pacbell.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 07, 2005 at 08:43:02PM -0700, david-b@pacbell.net wrote:
> > Some PCI devices lose all configuration (including BARs) when
> > transitioning from D3hot->D0.  This leaves such a device in an

> Hmm, I wonder if I missed something in previous email, but exactly
> why isn't this the responsibility of the driver for that device?

It certainly could be handled that way.  Of course, that could
mean replicating essentially identical code across dozens (or more)
drivers.  Plus, many of those drivers might only need such changes for
one variation of a device or for devices under a handful of BIOSen.
Those drivers probably won't get fixed anytime soon unless some kernel
hacker happens to stumble into such a situation.  In the meantime,
those drivers fail to work when they "should" be working.

In my mind, this is a documented behaviour that should not be
unexpected.  It is not some random quirk of some oddball device.
A few simple steps taken when this situation is recognized can allow
drivers to remain unaware of this detail of PCI PM.  That seems
worthwhile to me.

John
-- 
John W. Linville
linville@tuxdriver.com
