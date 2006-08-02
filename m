Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932251AbWHBWFv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932251AbWHBWFv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 18:05:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932262AbWHBWFv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 18:05:51 -0400
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:21776 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932251AbWHBWFt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 18:05:49 -0400
Date: Wed, 2 Aug 2006 23:05:33 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>, Dave Jones <davej@redhat.com>,
       "Rafael J. Wysocki" <rjw@sisk.pl>,
       Jesse Brandeburg <jesse.brandeburg@gmail.com>,
       Andrew Morton <akpm@osdl.org>, stern@rowland.harvard.edu,
       linux-kernel@vger.kernel.org, cpufreq@www.linux.org.uk
Subject: Re: Linux v2.6.18-rc3
Message-ID: <20060802220533.GB19669@flint.arm.linux.org.uk>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	Dave Jones <davej@redhat.com>, "Rafael J. Wysocki" <rjw@sisk.pl>,
	Jesse Brandeburg <jesse.brandeburg@gmail.com>,
	Andrew Morton <akpm@osdl.org>, stern@rowland.harvard.edu,
	linux-kernel@vger.kernel.org, cpufreq@www.linux.org.uk
References: <20060731081112.05427677.akpm@osdl.org> <20060801215919.8596da9d.akpm@osdl.org> <4807377b0608021257p27882866i69a5a0a4a1f05dda@mail.gmail.com> <200608022216.54797.rjw@sisk.pl> <20060802202309.GD7173@flint.arm.linux.org.uk> <20060802203236.GC23389@redhat.com> <20060802205824.GA17599@flint.arm.linux.org.uk> <Pine.LNX.4.64.0608021416200.4168@g5.osdl.org> <20060802213834.GB17599@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060802213834.GB17599@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 02, 2006 at 10:38:34PM +0100, Russell King wrote:
> On Wed, Aug 02, 2006 at 02:18:55PM -0700, Linus Torvalds wrote:
> > The serial layer should use set_termios() when users set the termios state 
> > (surprise surprise), not to emulate suspend/restore.
> 
> Yes Linus, you're obviously right.  Would you mind re-engineering this
> while I'm away for the next few days.  For _ALL_ serial drivers, not
> just 8250.  Thanks.

BTW, you'll need to replicate some of the quirk behaviour on some 8250
compatible UARTs when restoring registers - you can't blindly write
the registers in any one particular order.

Some UARTs have side effects which reset some features if you do that
(eg, TI16750 UARTs with 64 byte FIFOs need a different register writing
order from everything else, otherwise it turns off the 64-byte FIFOs.)
Others require you to write a sequence of values to a register, etc.

Okay, consider me gone from this point forwards for the next few days.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
