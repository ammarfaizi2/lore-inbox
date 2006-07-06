Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030198AbWGFJwA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030198AbWGFJwA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 05:52:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030200AbWGFJwA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 05:52:00 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:41483 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1030198AbWGFJwA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 05:52:00 -0400
Date: Thu, 6 Jul 2006 10:51:50 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Andrew Morton <akpm@osdl.org>
Cc: Haavard Skinnemoen <hskinnemoen@atmel.com>, linux-kernel@vger.kernel.org,
       torvalds@osdl.org
Subject: Re: AVR32 architecture patch against Linux 2.6.18-rc1 available
Message-ID: <20060706095150.GA1399@flint.arm.linux.org.uk>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	Haavard Skinnemoen <hskinnemoen@atmel.com>,
	linux-kernel@vger.kernel.org, torvalds@osdl.org
References: <20060706105227.220565f8@cad-250-152.norway.atmel.com> <20060706021906.1af7ffa3.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060706021906.1af7ffa3.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 06, 2006 at 02:19:06AM -0700, Andrew Morton wrote:
> - What are these for?
> 
> 	+EXPORT_SYMBOL(clk_get);
> 	+EXPORT_SYMBOL(clk_put);
> 	+EXPORT_SYMBOL(clk_enable);
> 	+EXPORT_SYMBOL(clk_disable);
> 	+EXPORT_SYMBOL(clk_get_rate);
> 	+EXPORT_SYMBOL(clk_round_rate);
> 	+EXPORT_SYMBOL(clk_set_rate);
> 	+EXPORT_SYMBOL(clk_set_parent);
> 	+EXPORT_SYMBOL(clk_get_parent);

Part of the clock framework.  No, not the one that you've probably
heard about (which is in connection with time, and IMHO incorrectly
named).

This one is to do with controlling the clock sources for peripherals
in systems, to allow drivers to be shared between platforms with the
minimum of crap in drivers.

For example, the ARM Ltd AMBA "devices" end up being embedded into ARM
SoCs, MIPS SoCs and now probably AVR32 SoCs.  These drivers need a way
to be told, eg, their clock source rate in the case of a UART, and be
able to control the clock rate in the case of an LCD controller.  It's
also advantageous for power saving to be able to turn clock sources
on and off.

You can have hardware situations where the clock source for UARTs
depend on where they are on the bus, possibly clocked at different
rates, or all UARTs are clocked from one source.

How that is achieved is extremely SoC or platform specific, and as such
I put together a well defined API (include/linux/clk.h) which gives:

1. an API for drivers to follow to achieve achieve inter-operability and
   re-use with the minimum of fuss.
2. complete flexibility to the platform code to implement the backend
   how they see fit, using whatever structures they see fit.

It's great that the AVR32 folk are reusing this.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
