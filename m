Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261347AbUF3Tay@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261347AbUF3Tay (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 15:30:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261602AbUF3Tax
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 15:30:53 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:45576 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261347AbUF3Taj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 15:30:39 -0400
Date: Wed, 30 Jun 2004 20:30:30 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Pavel Machek <pavel@ucw.cz>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] Provide console_suspend() and console_resume()
Message-ID: <20040630203030.B1496@flint.arm.linux.org.uk>
Mail-Followup-To: Pavel Machek <pavel@ucw.cz>,
	Linux Kernel List <linux-kernel@vger.kernel.org>
References: <20040614151217.H14403@flint.arm.linux.org.uk> <20040614151307.I14403@flint.arm.linux.org.uk> <20040630123727.GA16409@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040630123727.GA16409@elf.ucw.cz>; from pavel@ucw.cz on Wed, Jun 30, 2004 at 02:37:29PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 30, 2004 at 02:37:29PM +0200, Pavel Machek wrote:
> Hi!
> 
> > Add console_suspend() and console_resume() methods so the serial drivers
> > can disable console output before suspending a port, and re-enable output
> > afterwards.
> 
> Could it be called console_stop()/console_start()? suspend/resume
> sounds like power managment, and it is unrelated....

It is power management related!  However, we decided that console_start/
console_stop was a better name for it.

That said, it is _NOT_ intended for general use since there is NO
counting of how many times console_stop() is called.  It is merely
used by the serial driver to prevent further serial console output
before shutting the console port down for power management.

This avoids the problem where, on resume, we haven't even enabled
the UART - if we were to attempt to write to the UART in this
circumstance, it would not be setup in any way - no baud rate,
and in fact, since it is disabled, we'd spin for ever waiting for
the port to say its completed transmission of the first byte.

So yes, it most definitely _is_ power management related.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
