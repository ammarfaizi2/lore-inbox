Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932234AbWBCJlE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932234AbWBCJlE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 04:41:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932240AbWBCJlE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 04:41:04 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:48138 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932234AbWBCJlD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 04:41:03 -0500
Date: Fri, 3 Feb 2006 09:40:42 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Glen Turner <glen.turner@aarnet.edu.au>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Kumar Gala <galak@kernel.crashing.org>, linux-kernel@vger.kernel.org
Subject: Re: 8250 serial console fixes -- issue
Message-ID: <20060203094042.GB30738@flint.arm.linux.org.uk>
Mail-Followup-To: Glen Turner <glen.turner@aarnet.edu.au>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Kumar Gala <galak@kernel.crashing.org>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0602011911360.22854-100000@gate.crashing.org> <1138844838.5557.17.camel@localhost.localdomain> <43E2B8D6.1070707@aarnet.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43E2B8D6.1070707@aarnet.edu.au>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 03, 2006 at 12:28:46PM +1030, Glen Turner wrote:
> Hi Alan,
> 
> The serial console driver has a host of issues
> 
> [...]
> 
>  - [SECURITY] 'r' should require DCD to be asserted
>    before outputing characters. Otherwise we talk to
>    Hayes modem command mode.  This allows a non-root
>    user to re-program the modem and is a major security
>    issue is people configure calling line identification
>    or encryption to restrict use of the serial console.

How is this possible?  A normal user can't produce arbitarily formatted
kernel messages, and if they have access to /dev/ttyS they can do what
ever they like with the port anyway.

(If a user can produce arbitarily formatted kernel messages, that in
itself is a security bug - how do you know if that OOPS was produced
by a malicious user, or a real oops?)

>  - 'r' option has insanely slow CTS timeout. So if a
>    terminal server is inactive the kernel can take
>    30 minutes to boot as each character write to the
>    serial console requires a CTS timeout.

You'd rather we threw away these messages?

> I occassionally clean up and repost a patch I wrote years
> ago which never gets integrated (although it ships in the
> patchset of a number of kernels from supercomputer vendors).
> I'm happy to clean it up again if there's a hope of
> integration.

It'd help if you talked to the right person - I've been looking after
the serial layer since 2.5.something.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
