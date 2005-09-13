Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932621AbVIMMCg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932621AbVIMMCg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 08:02:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932622AbVIMMCg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 08:02:36 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:32531 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932621AbVIMMCf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 08:02:35 -0400
Date: Tue, 13 Sep 2005 13:02:29 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Hironobu Ishii <hishii@soft.fujitsu.com>,
       Taku Izumi <izumi2005@soft.fujitsu.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: performance-improvement-of-serial-console-via-virtual.patch added to -mm tree
Message-ID: <20050913130229.B14342@flint.arm.linux.org.uk>
Mail-Followup-To: Hironobu Ishii <hishii@soft.fujitsu.com>,
	Taku Izumi <izumi2005@soft.fujitsu.com>, akpm@osdl.org,
	linux-kernel@vger.kernel.org
References: <200509072146.j87LkNv8004076@shell0.pdx.osdl.net> <20050907224911.H19199@flint.arm.linux.org.uk> <4394.10.124.102.246.1126165652.squirrel@dominion> <20050913091740.A8256@flint.arm.linux.org.uk> <00b601c5b858$8a8c4ad0$dba0220a@CARREN> <20050913125326.A14342@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050913125326.A14342@flint.arm.linux.org.uk>; from rmk+lkml@arm.linux.org.uk on Tue, Sep 13, 2005 at 12:53:26PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 13, 2005 at 12:53:26PM +0100, Russell King wrote:
> The only things which the console code can rely on being initialised
> is the port address description (iobase / membase / iotype / regshift),
> the flow control (UPF_CONS_FLOW) in flags, and in the case of Xscale
> systems, the capabilities.  Everything else will be in an indeterminent
> state as far as the serial console code is concerned, and therefore can
> not be relied upon.

Additionally, once all architectures convert to initialising their
serial ports via platform devices (which means include/asm-*/serial.h
becomes essentially empty) and we eliminate serial8250_console_init(),
the 8250 console code can start assuming that more of the uart_port
structure will be initialised.

At that point, we can start to think about using FIFOs for the
console.

However, this is an exercise for architecture maintainers to do
who in theory know the requirements for their platforms.  So far
I've seen little progress on this though.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
