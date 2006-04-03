Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964854AbWDCTo4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964854AbWDCTo4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Apr 2006 15:44:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964856AbWDCTo4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Apr 2006 15:44:56 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:57359 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S964854AbWDCToz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Apr 2006 15:44:55 -0400
Date: Mon, 3 Apr 2006 20:44:48 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: "Hyok S. Choi" <hyok.choi@samsung.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.17-rc1] [SERIAL] DCC(JTAG) serial and the console emulation support(revised#2)
Message-ID: <20060403194448.GC5616@flint.arm.linux.org.uk>
Mail-Followup-To: "Hyok S. Choi" <hyok.choi@samsung.com>,
	linux-kernel@vger.kernel.org
References: <20060403112410.14105.55427.stgit@hyoklinux.sec.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060403112410.14105.55427.stgit@hyoklinux.sec.samsung.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 03, 2006 at 08:24:10PM +0900, Hyok S. Choi wrote:

The number of comments is getting smaller.  Only two remaining.

> +	help
> +	  Say Y here if you want to install DCC driver as a normal serial port
> +	  /dev/ttyS0 (major 4, minor 64). Otherwise, it appears as /dev/ttyJ0
> +	  (major 4, minor 128) and can co-exist with other UARTs, such as
> +	  8250/16C550 compatibles.

Help doesn't match code.

> +static void dcc_shutdown(struct uart_port *port)
> +{
> +#ifdef DCC_IRQ_USED /* real IRQ used */
> +	free_irq(port->irq, port);
> +#else
> +	spin_lock(&port->lock);
> +	cancel_rearming_delayed_work(&dcc_poll_task);

cancel_rearming_delayed_work() might sleep due to it calling
flush_workqueue.  Therefore, you must not be holding a spinlock.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
