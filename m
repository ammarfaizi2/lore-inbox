Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261969AbVF0JVE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261969AbVF0JVE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 05:21:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261973AbVF0JVE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 05:21:04 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:52237 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261969AbVF0JUw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 05:20:52 -0400
Date: Mon, 27 Jun 2005 10:20:47 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Vitaly Wool <vwool@dev.rtsoft.ru>
Cc: Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] SPI core -- revisited
Message-ID: <20050627102047.B10822@flint.arm.linux.org.uk>
Mail-Followup-To: Vitaly Wool <vwool@dev.rtsoft.ru>,
	Arjan van de Ven <arjan@infradead.org>,
	linux-kernel@vger.kernel.org
References: <20050626193621.8B8E44C4D1@abc.pervushin.pp.ru> <200506270049.10970.adobriyan@gmail.com> <1119819580.3215.47.camel@laptopd505.fenrus.org> <42BF7496.7080204@dev.rtsoft.ru> <1119860886.3186.30.camel@laptopd505.fenrus.org> <42BFC348.5040709@dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <42BFC348.5040709@dev.rtsoft.ru>; from vwool@dev.rtsoft.ru on Mon, Jun 27, 2005 at 01:13:44PM +0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 27, 2005 at 01:13:44PM +0400, Vitaly Wool wrote:
> Arjan van de Ven wrote:
> >how is that??
>
> These functions are not exactly *wrappers*, there's some little 
> additional logic inside.
> spi-pnx0105_atmel.c uses spi_pnx_msg_buff_t structure to embed physical 
> and virtual address and length of the memory area allocated by 
> consistent_alloc, so if we just get rid of the alloc/free functions, 
> we'll copy wrong data from the userspace and nothing'll work.
> 
> Let's look at it from another point. When a read request comes from the 
> userspace to spi-dev, spi-dev should allocate  memory and copy the user 
> data in there. The problem is it is not (and shouldn't be) aware whether 
> the transfer is gonna be DMA or not so spi-dev can't choose 
> theappropriate method of memory allocation. Therefore it's reasonable to 
> let algorithm provide routines to do that.

Sorry, this isn't making sense.  Are you implying that you want to use
DMA to copy data from user to kernel space?  Or something else?

In any case, I do hope that you are aware that copy_to_user/copy_from_user
have rather important side effects other than just copying data?  They
cause page faults which ensure that the user space pages are paged in
and/or copied if written to as appropriate.

In another post, you mention that this patch was not provided for review.
However, it _is_ effectively provided for review because it's an
illustration of _how_ the interfaces are used - and we're reviewing
the interfaces provided by the SPI core.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
