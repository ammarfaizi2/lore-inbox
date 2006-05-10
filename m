Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965013AbWEJQ1Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965013AbWEJQ1Q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 12:27:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965014AbWEJQ1Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 12:27:16 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:14092 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S965013AbWEJQ1P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 12:27:15 -0400
Date: Wed, 10 May 2006 17:27:08 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Dave Jiang <djiang@mvista.com>
Cc: linux-kernel@vger.kernel.org, mgreer@mvista.com
Subject: Re: [PATCH] MPSC serial driver tx locking
Message-ID: <20060510162708.GD32632@flint.arm.linux.org.uk>
Mail-Followup-To: Dave Jiang <djiang@mvista.com>,
	linux-kernel@vger.kernel.org, mgreer@mvista.com
References: <20060510003552.GB22447@blade.az.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060510003552.GB22447@blade.az.mvista.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 09, 2006 at 05:35:52PM -0700, Dave Jiang wrote:
> @@ -1997,7 +2018,7 @@ mpsc_drv_probe(struct platform_device *d
>  			if (!(rc = mpsc_make_ready(pi)))
>  				if (!(rc = uart_add_one_port(&mpsc_reg,
>  					&pi->port)))
> -					rc = 0;
> +					spin_lock_init(&pi->tx_lock);

You publish the port to the uart layer and then do initialisation.
What if someone nips in and starts using the port between registering
it and initialising the spinlock?  (that's a general principle - for
any device driver, never publish the device interfaces until you've
completed all initialisation.)

Why not do the spinlock initialisation first?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
