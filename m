Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161154AbWBQVjT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161154AbWBQVjT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 16:39:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161155AbWBQVjS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 16:39:18 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:62987 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1161154AbWBQVjS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 16:39:18 -0500
Date: Fri, 17 Feb 2006 21:39:03 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Paul Fulghum <paulkf@microgate.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] SIIG 8-port serial boards support
Message-ID: <20060217213903.GE13502@flint.arm.linux.org.uk>
Mail-Followup-To: Paul Fulghum <paulkf@microgate.com>,
	linux-kernel@vger.kernel.org
References: <20060124082538.GB4855@pazke> <20060124210140.GB23513@flint.arm.linux.org.uk> <20060202102644.GC5034@flint.arm.linux.org.uk> <20060202132726.GD24903@pazke> <20060202201734.GA17329@flint.arm.linux.org.uk> <20060203091308.GA19805@pazke> <20060203092435.GA30738@flint.arm.linux.org.uk> <20060217113942.GA30787@pazke> <20060217200213.GA13502@flint.arm.linux.org.uk> <43F63FD0.3060300@microgate.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43F63FD0.3060300@microgate.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 17, 2006 at 03:27:44PM -0600, Paul Fulghum wrote:
> Russell King wrote:
> >So, there are three distinct flow control scenarios:
> 
> So I'm clear on how you interpret these,
> am I correct with the following?
> 
> >- conventional RTS/CTS
> RTS active = ready to receive
> CTS active = allowed to send
> 
> >- alternative RTS/CTS
> RTS active = on before send, off after send
> CTS active = allowed to send

I'll have to dig through my archives to confirm this one.

> >- RS485
> RTS active = on before send, off after send (RTS enables driver)
> CTS ignored (2 wire mode, no CTS)
> 
> So maybe the extra control fields would be:
> CRTSONTX - RTS on before send, off after send
> CTXONCTS - wait for CTS before sending

That's a possibility, except that programs today expect CRTSCTS to
enable RTS/CTS flow control.

What I suggest is to use CRTSCTS to enable the chosen flow control
method.  Then we have a set of cflag bits which describe the flow
control mode, eg CFLOWRS485, CFLOWMODEM, CFLOWALT (probably needs
better names.)  CFLOWMODEM being the conventional mode should have
an all zeros value.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
