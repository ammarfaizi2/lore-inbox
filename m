Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263034AbVCQJ5x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263034AbVCQJ5x (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Mar 2005 04:57:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263035AbVCQJ5x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Mar 2005 04:57:53 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:55314 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S263034AbVCQJ5e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Mar 2005 04:57:34 -0500
Date: Thu, 17 Mar 2005 09:57:28 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: moreau francis <francis_moreau2000@yahoo.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [UART] 8250:RTS/CTS flow control issue.
Message-ID: <20050317095728.A29592@flint.arm.linux.org.uk>
Mail-Followup-To: moreau francis <francis_moreau2000@yahoo.fr>,
	linux-kernel@vger.kernel.org
References: <20050315160554.2871.qmail@web25104.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050315160554.2871.qmail@web25104.mail.ukl.yahoo.com>; from francis_moreau2000@yahoo.fr on Tue, Mar 15, 2005 at 05:05:54PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 15, 2005 at 05:05:54PM +0100, moreau francis wrote:
> Does it mean that we can't do any reliable flow
> controls with 8250 UART ? In that case a simple
> workaround would be to limit tx fifo to 1 byte...

With a popular 8250 UART on the other end, you need to ensure that
you disable the CTS signal with sufficient time (== at least the
number of bytes in the transmit FIFO) so that the transmission stops.

This is because many 8250 UARTs don't have any hardware linkage
between the CTS signal and the transmitter.  Later 8250 UARTs which
do have automatic hardware flow control allow for this, as do
most other serial peripherals.

I, therefore, strongly suggest that you arrange to do the same -
iow, deassert RTS when your buffer is approaching approx. 2/3 full
rather than absolutely full.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
