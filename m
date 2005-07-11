Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262466AbVGKTt5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262466AbVGKTt5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 15:49:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262506AbVGKTsP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 15:48:15 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:35087 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262255AbVGKTpn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 15:45:43 -0400
Date: Mon, 11 Jul 2005 20:45:34 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Pavel Machek <pavel@ucw.cz>
Cc: lenz@cs.wisc.edu, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: arm: how to operate leds on zaurus?
Message-ID: <20050711204534.C1540@flint.arm.linux.org.uk>
Mail-Followup-To: Pavel Machek <pavel@ucw.cz>, lenz@cs.wisc.edu,
	kernel list <linux-kernel@vger.kernel.org>
References: <20050711193454.GA2210@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050711193454.GA2210@elf.ucw.cz>; from pavel@ucw.cz on Mon, Jul 11, 2005 at 09:34:54PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 11, 2005 at 09:34:54PM +0200, Pavel Machek wrote:
> Hi!
> 
> 2.6.12-rc5 (and newer) does not boot on sharp zaurus sl-5500. It
> blinks with green led, fast; what does it mean? I'd like to verify if
> it at least reaches .c code in setup.c. I inserted this code at
> begining of setup.c:674...
> 
> #define locomo_writel(val,addr) ({ *(volatile u16 *)(addr) = (val); })
> #define LOCOMO_LPT_TOFH         0x80
> #define LOCOMO_LED              0xe8
> #define LOCOMO_LPT0             0x00
> 
>       locomo_writel(LOCOMO_LPT_TOFH, LOCOMO_LPT0 + LOCOMO_LED);
> 
> ...but that does not seem to do a trick -- it only breaks the boot :-(

Basically because you do not have access to IO during the early boot.
The easiest debugging solution is to enable CONFIG_DEBUG_LL and
throw a printascii(printk_buf) into printk.c, after vscnprintf.
That might get you some boot messages through the serial port (if
it's implemented it correctly.)

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
