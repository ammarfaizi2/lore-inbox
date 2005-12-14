Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964859AbVLNQzz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964859AbVLNQzz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 11:55:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932465AbVLNQzz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 11:55:55 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:23052 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932400AbVLNQzy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 11:55:54 -0500
Date: Wed, 14 Dec 2005 16:55:49 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Serial: bug in 8250.c when handling PCI or other level triggers
Message-ID: <20051214165549.GE7124@flint.arm.linux.org.uk>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	linux-kernel@vger.kernel.org
References: <1134573803.25663.35.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1134573803.25663.35.camel@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 14, 2005 at 03:23:23PM +0000, Alan Cox wrote:
> The receive_chars function is designed to handle the case where the port
> is jammed full on by aborting after 256 characters in one IRQ.
> Unfortunately the author of this code forgot that some systems are level
> triggered. On these systems the IRQ simply gets invoked again and the
> count loop just makes the problem take longer to clear.

If we trigger this, we can assume that the port is dead anyway, or
we're in a situation where the host CPU can not keep up with the
data stream.

If we want to handle this more gracefully as you suggest, we need
to disable the interrupt from the chip entirely, and flag an error
to the TTY layer.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
