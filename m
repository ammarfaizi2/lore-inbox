Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261763AbVCQQRh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261763AbVCQQRh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Mar 2005 11:17:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261937AbVCQQRh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Mar 2005 11:17:37 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:20233 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261763AbVCQQRe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Mar 2005 11:17:34 -0500
Date: Thu, 17 Mar 2005 16:17:29 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: moreau francis <francis_moreau2000@yahoo.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [UART] 8250:RTS/CTS flow control issue.
Message-ID: <20050317161729.A12344@flint.arm.linux.org.uk>
Mail-Followup-To: moreau francis <francis_moreau2000@yahoo.fr>,
	linux-kernel@vger.kernel.org
References: <20050317143450.83739.qmail@web25101.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050317143450.83739.qmail@web25101.mail.ukl.yahoo.com>; from francis_moreau2000@yahoo.fr on Thu, Mar 17, 2005 at 03:34:49PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 17, 2005 at 03:34:49PM +0100, moreau francis wrote:
> But why should I "degrade" my UART because some 8250
> devices have
> poor hardware implementation. Maybe we should limit
> their tx fifo to
> one byte when rts/cts flow control is enabled...

Because you don't actually understand what "hardware" and "software" flow
control refer to.  It doesn't refer to the way the control is derived, as
your messages appear to imply.

What it does refer to is the *signalling* method:

* Hardware flow control is performed using the RTS and CTS signals.
  These signals may be software controlled.

* Software flow control means sending an XOFF character to stop
  transmission, and another character to start transmission.

In both flow control scenarios, it is very common that there may be some
latency between the reception of the "stop transmission" signal and the
transmission actually stopping.

This is precisely why the 8250 UARTs which do have "automatic flow
control" incorporated into the receiver have *large* FIFOs with
programmable trigger levels - it allows for the latency at the
transmission end.

If you want it to be immediate, then I'm afraid you're going to have a
relatively hard time, with compatibility problems with various systems.
You can't really dictate to people that they must turn off the FIFOs on
their UARTs for your product to work.  (Well, you can, but _you_ would
have to support them.)

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
