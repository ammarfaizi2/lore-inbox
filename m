Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750980AbWBZWlw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750980AbWBZWlw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Feb 2006 17:41:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751412AbWBZWlw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Feb 2006 17:41:52 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:43793 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1750980AbWBZWlw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Feb 2006 17:41:52 -0500
Date: Sun, 26 Feb 2006 22:41:45 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Karol Kozimor <sziwan@hell.org.pl>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] Convert serial_core oopses to BUG_ON
Message-ID: <20060226224145.GE31256@flint.arm.linux.org.uk>
Mail-Followup-To: Karol Kozimor <sziwan@hell.org.pl>,
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
References: <5Kr1a-6MF-15@gated-at.bofh.it> <5KraE-6XP-15@gated-at.bofh.it> <5KyFv-RL-15@gated-at.bofh.it> <20060226223448.GA27562@hell.org.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060226223448.GA27562@hell.org.pl>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 26, 2006 at 11:34:48PM +0100, Karol Kozimor wrote:
> Thus wrote Russell King:
> > > > Calling serial functions to flush buffers, or try to send more data
> > > >  after the port has been closed or hung up is a bug in the code doing
> > > >  the calling, not in the serial_core driver.
> > > > 
> > > >  Make this explicitly obvious by adding BUG_ON()'s.
> > > 
> > > If we make it
> > > 
> > >       if (!info) {
> > >               WARN_ON(1);
> > >               return;
> > >       }
> > > 
> > > will that allow people's kernels to limp along until it gets fixed?
> > "until" - I think you mean "if anyone ever bothers" so no I don't agree.
> 
> Russel, I agree this should be clearly marked and an oops seems okay here,
> but we're talking dead systems here (dead as in all interrupts masked type
> of dead). Most users won't even be aware an oops occured, let alone be able
> to read the messages on the console. 
> 
> I was just lucky because after the first one I got (#5958, a regular oops)
> I tried to nail it down in text mode, with the console loglevel upped a
> bit, so I was able to see what the panic (#6131) was all about.
> 
> I think we really need those *_ON()s at least in uart_write().

I don't think it'll make a blind bit of difference.  The oopses have
been known about (to me and others) since about October 2005...  Pavel
Machek was the first to report the hci_uart problems.

I diagnosed the uart_flush_buffer() oops being caused by hci_uart back
in October and where did that get us - nowhere at the time, but later
another bug report in bugzilla against serial and no progress.

Excuse me if I'm despondent on this issue - I'm personally looking for
a way out of being assigned blame for the crap known as hci_uart.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
