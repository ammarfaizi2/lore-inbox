Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932446AbVIMIRt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932446AbVIMIRt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 04:17:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932447AbVIMIRt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 04:17:49 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:16141 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932446AbVIMIRs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 04:17:48 -0400
Date: Tue, 13 Sep 2005 09:17:40 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Taku Izumi <izumi2005@soft.fujitsu.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: performance-improvement-of-serial-console-via-virtual.patch added to -mm tree
Message-ID: <20050913091740.A8256@flint.arm.linux.org.uk>
Mail-Followup-To: Taku Izumi <izumi2005@soft.fujitsu.com>, akpm@osdl.org,
	linux-kernel@vger.kernel.org
References: <200509072146.j87LkNv8004076@shell0.pdx.osdl.net> <20050907224911.H19199@flint.arm.linux.org.uk> <4394.10.124.102.246.1126165652.squirrel@dominion>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <4394.10.124.102.246.1126165652.squirrel@dominion>; from izumi2005@soft.fujitsu.com on Thu, Sep 08, 2005 at 04:47:32PM +0900
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 08, 2005 at 04:47:32PM +0900, Taku Izumi wrote:
> >I don't think we want this.  With early serial console, tx_loadsz is
> >not guaranteed to be initialised, and may in fact be zero.
> 
> >Plus there's no guarantee that the FIFOs will actually be enabled, so
> >I think it's better that this patch doesn't go to mainline.
> 
> Our server has a virtual serial port, but its performance seems to be poor.
> It takes 10 seconds to output 4000 characters (from kernel) to serial
> console. By applying my patch, its peformance could be improved. ( 0.4
> seconds / 4000 characters output), so I think it is useful to use FIFO at
> serial8250_console_write function like transmit_chars function. Where
> should I correct in order to use FIFO?

The problem is that we don't know:

* if there is a FIFO
* what size the FIFO is
* if it has been initialised
* how much data is already contained in the FIFO

So we can't really blindly initialise the FIFO in the console write
method.  Neither can we initialise it in the console setup.  If we
could initialise it, we can't blindly load 16 bytes into the FIFO
at a time.

I don't think it's technically practical to use the FIFO for the
console and still have a reliable serial port.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
