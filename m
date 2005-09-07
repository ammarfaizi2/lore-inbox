Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932239AbVIGUdU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932239AbVIGUdU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Sep 2005 16:33:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932244AbVIGUdU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Sep 2005 16:33:20 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:9491 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932239AbVIGUdU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Sep 2005 16:33:20 -0400
Date: Wed, 7 Sep 2005 21:33:16 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Kars de Jong <jongk@linux-m68k.org>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: 8250_hp300: initialisation ordering bug
Message-ID: <20050907213316.G19199@flint.arm.linux.org.uk>
Mail-Followup-To: Kars de Jong <jongk@linux-m68k.org>,
	Linux Kernel List <linux-kernel@vger.kernel.org>
References: <20050904111901.A30509@flint.arm.linux.org.uk> <1126124269.3968.5.camel@kars.perseus.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1126124269.3968.5.camel@kars.perseus.home>; from jongk@linux-m68k.org on Wed, Sep 07, 2005 at 10:17:49PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 07, 2005 at 10:17:49PM +0200, Kars de Jong wrote:
> Yes, you are right. I am working on rewriting the driver a bit to use a
> platform device for the APCI driver, I'll take your bug report into
> account as well.

Thanks.

> On a related note: can I use the "serial8250" platform driver also for
> non-ISA devices (like my APCI platform device)? The comments in
> drivers/serial/8250.c suggest it's for ISA devices only, but I don't see
> a particular reason for not using it for my APCI devices.

The legacy platform device (serial8250_isa_devs) is for the old
legacy ISA tables, found in include/asm-*/serial.h.

Other serial8250 platform devices can be used to register other
devices - preferably groups of platform specific serial ports.

However, if you're talking about registering a set of devices
found on a different bus type (eg, PCI) then look at how 8250_pci
handles that.  I'd prefer bus-specific device registration to be
done in a similar way to 8250_pci rather than creating extra
platform devices.

I hope that's clear.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
