Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261497AbVFFPEH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261497AbVFFPEH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Jun 2005 11:04:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261498AbVFFPEG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Jun 2005 11:04:06 -0400
Received: from zproxy.gmail.com ([64.233.162.198]:43490 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261497AbVFFPDv convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Jun 2005 11:03:51 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=aOq3Fea2biV6g/pUWmsjBDPv2II2tH3f7xa7rhkRlogIn+XA5ZDPPg11Z8bFH6Y30XtdBZj+8LTkNoBLsT0lC9qsSwXF+EWRZuvEXJFpmR5ytHMnOhay8Y7YHHGPvTco1beXHDrhDbb26FXGhFzIxwsCB2+mZDV8KdYOYof3R8E=
Message-ID: <4789af9e0506060803161a8382@mail.gmail.com>
Date: Mon, 6 Jun 2005 09:03:50 -0600
From: Jim Ramsay <jim.ramsay@gmail.com>
Reply-To: Jim Ramsay <jim.ramsay@gmail.com>
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: Bug in 8520.c - port.type not set for serial console
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200505311625.46084.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <4789af9e05053015385667923@mail.gmail.com>
	 <200505311625.46084.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/31/05, Bjorn Helgaas <bjorn.helgaas@hp.com> wrote:
> On Monday 30 May 2005 4:38 pm, Jim Ramsay wrote:
> > I am attempting to get the 8520.c driver's serial console working with
> > a 16550A UART implementation, and have run into what I consider to be
> > a bug:  In short, the proper 'port.type' for this serial port is not
> > set until the module init (serial8250_init) is called, so the FCR is
> > set incorrectly during serial8250_console_init for any port type which
> > is different than UNKNOWN.
> >
> > The exact problem is that the FCR is being set to '0x0' for a port
> > type of 'UNKNOWN', when for my specific 16550A, it should be set to
> > '0xC1' - and this makes my screen fill with empty characters instead
> > of the printk output I need.
> 
> Shouldn't a 16550A UART work correctly with FCR==0x0, i.e., with FIFOs
> disabled?  Is your UART broken?

That's a good question.  I'll me looking into this in the near future.

> Serial console output is always polled, one character at a time, so
> you shouldn't need FIFOs until later.

True, as long as it works that way... so far I haven't seen it
actually function properly yet with FCR set to 0.

-- 
Jim Ramsay
"Me fail English?  That's unpossible!"
