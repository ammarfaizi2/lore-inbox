Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965005AbWFNPeA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965005AbWFNPeA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 11:34:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965007AbWFNPeA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 11:34:00 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:1293 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S965005AbWFNPd7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 11:33:59 -0400
Date: Wed, 14 Jun 2006 16:33:53 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Stuart MacDonald <stuartm@connecttech.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: serial_core: verify_port() in wrong spot?
Message-ID: <20060614153353.GB17432@flint.arm.linux.org.uk>
Mail-Followup-To: Stuart MacDonald <stuartm@connecttech.com>,
	linux-kernel@vger.kernel.org
References: <20060609162320.GA11997@flint.arm.linux.org.uk> <093501c68bee$6aef1ad0$294b82ce@stuartm>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <093501c68bee$6aef1ad0$294b82ce@stuartm>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 09, 2006 at 01:59:13PM -0400, Stuart MacDonald wrote:
> From: Russell King [rmk@arm.linux.org.uk]
> > I'd rather verify_port didn't get used for that - it's purpose is to
> > validate changes the admin makes to the port.
> 
> I did figure out that's what it's currently used as, but I didn't want
> to introduce a whole new call just to verify that the UART has 9bit
> capability.
> 
> Why aren't user changes validated?

The only things which users can change is low latency, the alternative
(deprecated) "38400-baud" baud rates, and the custom divisor.  None of
these depend on the low level driver, so there's no point asking the
low level driver to validate them.

> 9bit mode is much more than just words of 9 bit length. Parity is
> gone, replaced by the 9th bit; reads and writes have to treat the
> buffers driver-side buffers as 16 bit-wide instead of 8-bit; reads and
> writes to the hardware are correspondingly different; there are new
> interrupts; software flow control is gone; there's special address
> matching and a new ioctl to set that up.

Well, I'll have to read up on this before I can comment any further.
At the moment I don't feel qualified to answer your questions.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
