Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030277AbWFIQX1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030277AbWFIQX1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 12:23:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030279AbWFIQX1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 12:23:27 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:4621 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1030277AbWFIQX0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 12:23:26 -0400
Date: Fri, 9 Jun 2006 17:23:20 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Stuart MacDonald <stuartm@connecttech.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: serial_core: verify_port() in wrong spot?
Message-ID: <20060609162320.GA11997@flint.arm.linux.org.uk>
Mail-Followup-To: Stuart MacDonald <stuartm@connecttech.com>,
	linux-kernel@vger.kernel.org
References: <090301c68bd4$560c92b0$294b82ce@stuartm>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <090301c68bd4$560c92b0$294b82ce@stuartm>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 09, 2006 at 10:52:31AM -0400, Stuart MacDonald wrote:
> However, in serial_core.c:set_uart_info(), there is a problem. The
> flag should be within the purview of UPF_USR_MASK so that
> non-privileged users can turn it on or off, and yet, I don't want the
> mode to be enabled on UARTs that don't have it which requires
> verification from the low-level driver. There is only one call to
> ops->verify_port(), and it's not in the correct place for this to
> happen.

I'd rather verify_port didn't get used for that - it's purpose is to
validate changes the admin makes to the port.

I don't know why you think that setting 9bit mode should be done this
way rather than through the usual termios methods - the termios methods
already have a way to control the length of each character, so it would
seem logical to put the control in there.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
