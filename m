Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751199AbVJOS6T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751199AbVJOS6T (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Oct 2005 14:58:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751200AbVJOS6T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Oct 2005 14:58:19 -0400
Received: from sccrmhc11.comcast.net ([204.127.202.55]:52639 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S1751199AbVJOS6S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Oct 2005 14:58:18 -0400
Date: Sat, 15 Oct 2005 11:55:02 -0700
From: jbarnes@virtuousgeek.org
To: linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net
Subject: ohci1394 unhandled interrupts bug in 2.6.14-rc2
Message-ID: <20051015185502.GA9940@plato.virtuousgeek.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been experiencing a bug in the Fedora kernels for awhile involving
the ohci1394 driver.  If I include the driver in my initrd (causing it
to be loaded at boot time), the IRQ corresponding to my TI OHCI firewire
controller is disabled (message says "Disabling IRQ #11", I think due to
the kernel irq debug code noticing that it hasn't been handled too many
times).  Since this IRQ is shared with my pcmcia, wireless, and usb
devices (don't ask me why it's wired this way, this is a Toshiba
Satellite laptop), nothing important works after the IRQ is disabled.

I've reproduced this problem under 2.6.14-rc2, which includes Al Viro's
latest fix to initialize interrupt handler spinlock (which I was hoping
would fix the problem but didn't).

Is this a known issue?  Does the interrupt handler need to special case
initialization somehow and return IRQ_HANDLED even if there's no event
sometimes?

Thanks,
Jesse
