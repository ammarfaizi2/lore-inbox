Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261164AbVCZQhm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261164AbVCZQhm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Mar 2005 11:37:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261167AbVCZQhm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Mar 2005 11:37:42 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:34572 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261164AbVCZQhe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Mar 2005 11:37:34 -0500
Date: Sat, 26 Mar 2005 16:37:29 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Phil Oester <kernel@linuxace.com>
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>, Luca <kronos@kronoz.cjb.net>,
       linux-kernel@vger.kernel.org
Subject: Re: Garbage on serial console after serial driver loads
Message-ID: <20050326163729.A23306@flint.arm.linux.org.uk>
Mail-Followup-To: Phil Oester <kernel@linuxace.com>,
	Jan Engelhardt <jengelh@linux01.gwdg.de>,
	Luca <kronos@kronoz.cjb.net>, linux-kernel@vger.kernel.org
References: <20050325202414.GA9929@dreamland.darkstar.lan> <20050325203853.C12715@flint.arm.linux.org.uk> <20050325210132.GA11201@dreamland.darkstar.lan> <Pine.LNX.4.61.0503261115480.28431@yvahk01.tjqt.qr> <20050326151005.D12809@flint.arm.linux.org.uk> <20050326155549.GA5881@linuxace.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050326155549.GA5881@linuxace.com>; from kernel@linuxace.com on Sat, Mar 26, 2005 at 07:55:49AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 26, 2005 at 07:55:49AM -0800, Phil Oester wrote:
> On Sat, Mar 26, 2005 at 03:10:05PM +0000, Russell King wrote:
> > Doesn't matter.  The problem is that dwmw2's NS16550A patch (from ages
> > ago) changes the prescaler setting for this device so we can use the
> > higher speed baud rates.  This means any programmed divisor (programmed
> > at early serial console initialisation time) suddenly becomes wrong as
> > soon as we fiddle with the prescaler during normal UART initialisation
> > time.
> 
> FWIW, I see the same thing here on some Dell Poweredge boxes:
> 
> serio: i8042 AUX port at 0x60,0x64 irq 12
> serio: i8042 KBD port at 0x60,0x64 irq 1
> Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
> ttyS0 at I/O 0x3f8 (irq = 4) is a NS16550A
> ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
> <garbage>
> 
> But intererstingly, on identical boxes, the garbage only appears on
> those hooked up to a PortMaster device - those using a Cyclades never
> display this problem. (???)

Sorry, I don't understand your scenarios.  Can you explain the
circumstances under which you see corruption?

>From the kernel messages you've quoted above, I can only think that
you're not using ttyS0 as the serial console - if you were, my
understanding of this issue would indicate that you should get the
garbage immediately after the line starting "Serial:"

Either my understanding of the cause of this problem is wrong, or
I'm not understanding your setup.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
