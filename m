Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264385AbTLVJse (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Dec 2003 04:48:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264386AbTLVJse
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Dec 2003 04:48:34 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:6931 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S264385AbTLVJsc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Dec 2003 04:48:32 -0500
Date: Mon, 22 Dec 2003 09:48:29 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Andres Salomon <dilinger@voxel.net>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] CONFIG_PCMCIA_PROBE fix
Message-ID: <20031222094829.B13978@flint.arm.linux.org.uk>
Mail-Followup-To: Andres Salomon <dilinger@voxel.net>,
	linux-kernel@vger.kernel.org, akpm@osdl.org
References: <1072072123.27831.6.camel@spiral.internal>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1072072123.27831.6.camel@spiral.internal>; from dilinger@voxel.net on Mon, Dec 22, 2003 at 12:48:44AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 22, 2003 at 12:48:44AM -0500, Andres Salomon wrote:
> Some time ago, Russell King submitted a patch to use CONFIG_PCMCIA_PROBE
> instead of CONFIG_ISA in pcmcia probing code.  Unfortunately,
> CONFIG_PCMCIA_PROBE still is only set if CONFIG_ISA is set.  This means
> that if ISA isn't enabled, certain things break in 2.6; for example, my
> pcmcia nic/modem (using pcnet_cs/serial_cs).  These worked fine in 2.4;
> I tracked the behavior to the fact that if irq_mask is set on a pcmcia
> socket (instead of pci_irq), and PCMCIA_PROBE isn't set,
> pcmcia_request_irq refuses to assign an irq.  Most of the pcmcia bridges
> appear to set an irq_mask, so the attached patch changes Kconfig to set
> CONFIG_PCMCIA_PROBE if any of those bridges are selected.
> 
> Please apply this (or an alternative fix), as it fixes a 2.6 regression
> in pcmcia functionality.

Please don't.  David Hinds has a better fix for this, which changes
the way we handle the allocation of IRQs.  David's change is all
round a far better way to handle the problem - if all ISA interrupts
are used or unavailable, we fall back to using the PCI interrupt
instead.

Please also note that there /is/ a PCMCIA list which patches should
be forwarded to - linux-pcmcia which is at lists.infradead.org

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
