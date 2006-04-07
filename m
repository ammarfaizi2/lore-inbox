Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932390AbWDGJQQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932390AbWDGJQQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 05:16:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932396AbWDGJQQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 05:16:16 -0400
Received: from rtsoft2.corbina.net ([85.21.88.2]:27082 "HELO
	mail.dev.rtsoft.ru") by vger.kernel.org with SMTP id S932390AbWDGJQQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 05:16:16 -0400
Message-ID: <44362DDE.3010203@gmail.com>
Date: Fri, 07 Apr 2006 13:16:14 +0400
From: Vitaly Wool <vitalywool@gmail.com>
User-Agent: Mail/News 1.5 (X11/20060228)
MIME-Version: 1.0
To: David Brownell <david-b@pacbell.net>
CC: Kumar Gala <galak@kernel.crashing.org>, Greg KH <greg@kroah.com>,
       linux-kernel@vger.kernel.org, spi-devel-general@lists.sourceforge.net
Subject: Re: [spi-devel-general] Re: [PATCH] spi: Added spi master driver
 for Freescale MPC83xx SPI controller
References: <Pine.LNX.4.44.0604061329550.20620-100000@gate.crashing.org> <200604062222.05661.david-b@pacbell.net>
In-Reply-To: <200604062222.05661.david-b@pacbell.net>
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> I guess I'm surprised you're not using txrx_buffers() and having
> that whole thing be IRQ driven, so the per-word cost eliminates
> the task scheduling.  You already paid for IRQ handling ... why
> not have it store the rx byte into the buffer, and write the tx
> byte froom the other buffer?  That'd be cheaper than what you're
> doing now ... in both time and code.  Only wake up a task at
> the end of a given spi_transfer().
>   
I might be completely wrong here, but I was asking myself this very 
question, and it looks like that's the way to implement full duplex 
transfers.
For txrx_buffers to be properly implemented, you need to take a lot of 
things into account. The main idea is not to lose the data in the 
receive buffer due to overflow, and thus you need to set up 'Rx buffer 
not free' int or whatever similar which will actually trigger after the 
first word is sent. So therefore implementing txrx_buffers within these 
conditions doesn't make much sense IMHO, unless you meant having a 
separate thread to read from the Rx buffer, which is woken up on, say, 
half-full Rx buffer.

Vitaly
