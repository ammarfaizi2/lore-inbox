Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266690AbSKHAfT>; Thu, 7 Nov 2002 19:35:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266692AbSKHAfT>; Thu, 7 Nov 2002 19:35:19 -0500
Received: from deimos.hpl.hp.com ([192.6.19.190]:58850 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S266690AbSKHAfR>;
	Thu, 7 Nov 2002 19:35:17 -0500
Date: Thu, 7 Nov 2002 16:41:55 -0800
To: jt@hpl.hp.com, Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Martin Diehl <lists@mdiehl.de>
Subject: Re: [Serial 2.5]: packet drop problem (FE ?)
Message-ID: <20021108004155.GA837@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
References: <20021107224750.GA699@bougret.hpl.hp.com> <20021108001822.E11437@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021108001822.E11437@flint.arm.linux.org.uk>
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 08, 2002 at 12:18:22AM +0000, Russell King wrote:
> On Thu, Nov 07, 2002 at 02:47:50PM -0800, Jean Tourrilhes wrote:
> > 	I tried swapping the IrDA dongles themselves, and this didn't
> > make any difference. No other device/driver is using irq4. I also try
> > using a FIR as a sender, and I still see this packet dropped in Rx in
> > 2.5.X. And this used to work properly way back when I had 2.4.X on
> > this box.
> > 	I'm kind of suspicious about the "fe" number above. Could
> > anybody tell me a bit more about what "fe" means ?
> 
> FE = framing error, which is an error which is solely detected by the
> hardware when the stop bit(s) are not the mark value.  They can appear
> when the wrong parity setting, number of stop bits, or baud rate is
> programmed.
> 
> If you were overruning the serial port FIFOs, then you would see "oe"
> errors.
> 
> What baud rate are you trying to run the link at?

	115k (max negociated speed).

	The IrDA layer report many CRC errors, that could be dropped
char or flipped bits. I see around one 2000B frame dropped every 10
frame, which would be one byte/bit every 20000B, which is roughly the
frequency of the FE in /proc.
	On the other hand, this number seems a bit low for a
configuration error.

	The serial port is configured via irattach like this :
-----------------------------------------
	tios->c_cflag     = CS8|CREAD|B9600|CLOCAL;
	
	/* Ignore break condition and parity errors */
 	tios->c_iflag     = IGNBRK | IGNPAR;
	tios->c_oflag     = 0;
	tios->c_lflag     = 0; /* set input mode (non-canonical, no echo,..) */
	tios->c_cc[VMIN]  = 1; /* num of chars to wait for, before delivery */
	tios->c_cc[VTIME] = 0; /* timeout before delivery */
-----------------------------------------
	Now, it's possible that somehow irattach did mess up this
bit.
	Is there a way to see the current flag configuration of the
port with setserial or /proc ?

> Russell King

	Thanks for your help...

	Jean
