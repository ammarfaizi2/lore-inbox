Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261906AbVDKT6h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261906AbVDKT6h (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 15:58:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261908AbVDKT6g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 15:58:36 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:57871 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261906AbVDKT5x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 15:57:53 -0400
Date: Mon, 11 Apr 2005 20:57:45 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: rafael2k <rafael@riseup.net>
Cc: dahinds@users.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: pcnet_cs problems in ARM handheld
Message-ID: <20050411205745.B5070@flint.arm.linux.org.uk>
Mail-Followup-To: rafael2k <rafael@riseup.net>,
	dahinds@users.sourceforge.net, linux-kernel@vger.kernel.org
References: <200504111622.54719.rafael@riseup.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200504111622.54719.rafael@riseup.net>; from rafael@riseup.net on Mon, Apr 11, 2005 at 04:22:52PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 11, 2005 at 04:22:52PM +0000, rafael2k wrote:
> Hi David and others kernel developers,
> Thanx for your pcnet_cs driver! I use it since old days :-P
> 
> I bought a IC-CARD+ pcnet_cs compatible pcmcia nic, and i'm using it on a 
> StrongARM HP Jornada 710. My kernel is a 2.4.18-rmk3-hh10 and my pcmcia-cs 
> version is 3.1.33
> 
> From dmesg I got this messages:
> 
> --
> jornada720_pcmcia_configure_socket(): config socket 0 vcc 50 vpp 0
> jornada720_pcmcia_configure_socket(): config socket 0 vcc 50 vpp 0
> eth0: NE2000 Compatible: io 0xc2800300, irq 114, hw_addr 00:80:C8:88:00:56
> eth0: interrupt(s) dropped!
> NETDEV WATCHDOG: eth0: transmit timed out
> eth0: Tx timed out, lost interrupt? TSR=0x3, ISR=0x96, t=39.
> NETDEV WATCHDOG: eth0: transmit timed out
> eth0: Tx timed out, lost interrupt? TSR=0x3, ISR=0x3, t=55.
> NETDEV WATCHDOG: eth0: transmit timed out
> eth0: Tx timed out, lost interrupt? TSR=0x3, ISR=0x3, t=49.
> NETDEV WATCHDOG: eth0: transmit timed out
> eth0: Tx timed out, lost interrupt? TSR=0x3, ISR=0x3, t=88.
> eth0: interrupt(s) dropped!
> NETDEV WATCHDOG: eth0: transmit timed out
> eth0: Tx timed out, lost interrupt? TSR=0x3, ISR=0x3, t=77.

This looks like a case of the old 2.4 interrupt handling problems
which got resolved by rewriting the ARM interrupt handling
infrastructure during 2.5.

The problem occurs because of the need to handle edge-triggered
interrupts (as is the case with Intel CPUs) differently from
level-triggered interrupts, especially when the peripherals are
designed to be used with level-triggered inputs.

In effect, you can end up with the situation where the device has
its interrupt asserted, but because the CPU doesn't see a change
of state, it "forgets" about the interrupt input.

I'm not aware of a solution for this problem with 2.4 kernels.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
