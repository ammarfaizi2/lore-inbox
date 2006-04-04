Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964967AbWDDC1g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964967AbWDDC1g (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Apr 2006 22:27:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964969AbWDDC1f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Apr 2006 22:27:35 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:56528 "EHLO
	mailout3.samsung.com") by vger.kernel.org with ESMTP
	id S964967AbWDDC1f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Apr 2006 22:27:35 -0400
Date: Tue, 04 Apr 2006 11:27:06 +0900
From: "Hyok S. Choi" <hyok.choi@samsung.com>
Subject: Re: [PATCH 2.6.17-rc1] [SERIAL] DCC(JTAG) serial and the console
 emulation support(revised#2)
In-reply-to: <20060403194448.GC5616@flint.arm.linux.org.uk>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org
Message-id: <200604041127.07290.hyok.choi@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 7BIT
Content-disposition: inline
User-Agent: KMail/1.8.3
References: <20060403112410.14105.55427.stgit@hyoklinux.sec.samsung.com>
 <20060403194448.GC5616@flint.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 04 April 2006 04:44 am, Russell King wrote:
> On Mon, Apr 03, 2006 at 08:24:10PM +0900, Hyok S. Choi wrote:
> 
> > +static void dcc_shutdown(struct uart_port *port)
> > +{
> > +#ifdef DCC_IRQ_USED /* real IRQ used */
> > +	free_irq(port->irq, port);
> > +#else
> > +	spin_lock(&port->lock);
> > +	cancel_rearming_delayed_work(&dcc_poll_task);
> 
> cancel_rearming_delayed_work() might sleep due to it calling
> flush_workqueue.  Therefore, you must not be holding a spinlock.

Thus, I've just revised the code to lock around a counter variable
operation, which is used for life control of the polling task.
I've just posted the revised #3. :-)

-- 
Hyok
ARM Linux 2.6 MPU/noMMU Project http://opensrc.sec.samsung.com/
