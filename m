Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751839AbWDDIUQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751839AbWDDIUQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 04:20:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751840AbWDDIUP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 04:20:15 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:3344 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751839AbWDDIUO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 04:20:14 -0400
Date: Tue, 4 Apr 2006 09:20:05 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: "Hyok S. Choi" <hyok.choi@samsung.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.17-rc1] [SERIAL] DCC(JTAG) serial and the console emulation support(revised#2)
Message-ID: <20060404082005.GB8573@flint.arm.linux.org.uk>
Mail-Followup-To: "Hyok S. Choi" <hyok.choi@samsung.com>,
	linux-kernel@vger.kernel.org
References: <20060403112410.14105.55427.stgit@hyoklinux.sec.samsung.com> <20060403194448.GC5616@flint.arm.linux.org.uk> <200604041127.07290.hyok.choi@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200604041127.07290.hyok.choi@samsung.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 04, 2006 at 11:27:06AM +0900, Hyok S. Choi wrote:
> On Tuesday 04 April 2006 04:44 am, Russell King wrote:
> > On Mon, Apr 03, 2006 at 08:24:10PM +0900, Hyok S. Choi wrote:
> > 
> > > +static void dcc_shutdown(struct uart_port *port)
> > > +{
> > > +#ifdef DCC_IRQ_USED /* real IRQ used */
> > > +	free_irq(port->irq, port);
> > > +#else
> > > +	spin_lock(&port->lock);
> > > +	cancel_rearming_delayed_work(&dcc_poll_task);
> > 
> > cancel_rearming_delayed_work() might sleep due to it calling
> > flush_workqueue.  Therefore, you must not be holding a spinlock.
> 
> Thus, I've just revised the code to lock around a counter variable
> operation, which is used for life control of the polling task.
> I've just posted the revised #3. :-)

Why do you think you need such complexity?

cancel_rearming_delayed_work() will wait until the poll task has
completed and has been removed from the system.  It's explicitly
designed for work handlers which self-rearm.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
