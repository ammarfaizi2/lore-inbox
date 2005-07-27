Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262243AbVG0N5z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262243AbVG0N5z (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 09:57:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262246AbVG0N5z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 09:57:55 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:63760 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262243AbVG0N5y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 09:57:54 -0400
Date: Wed, 27 Jul 2005 14:57:47 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Brad Davis <enrock@gmail.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: US Robotics (Hardware) Modem Not Detected
Message-ID: <20050727145747.A29785@flint.arm.linux.org.uk>
Mail-Followup-To: Brad Davis <enrock@gmail.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <88e823ff0507270645613b1ca@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <88e823ff0507270645613b1ca@mail.gmail.com>; from enrock@gmail.com on Wed, Jul 27, 2005 at 07:45:21AM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 27, 2005 at 07:45:21AM -0600, Brad Davis wrote:
> I'm trying to get a PCI-USRobotics Modem (Yes, it is a true hardware
> modem) working on a G4 with Kernel version 2.6.10/2.6.11.
> 
> When I try to "modprobe 8250_pci". I get the following
> error message:
> 
> WARNING: Error inserting 8250
> (/lib/modules/2.6.10enrock.2/kernel/drivers/serial/8250.ko): No such
> device

This would be the root case.  8250 is _never_ supposed to fail with
ENODEV, even if it doesn't detect any devices itself.  And doesn't
fail like this.

> FATAL: Error inserting 8250_pci
> (/lib/modules/2.6.10enrock.2/kernel/drivers/serial/8250_pci.ko):
> Unknown symbol in module, or unknown parameter (see dmesg)
> 
> It looks to me like the 8250 module isn't recognizing the modem as a
> seial port. The appropriate lines from dmesg are:
> 
> serial8250_init: nothing to do on PowerMac

serial8250_init does not contain any such message, so you're not
running a mainline kernel, but some patched version.  Are these
patches available somewhere?

I guess these patches are your problem, and it seems that there's
at least one which is completely unnecessary or inappropriate.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
