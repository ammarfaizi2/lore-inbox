Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932183AbWHKLmF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932183AbWHKLmF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Aug 2006 07:42:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932149AbWHKLmE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Aug 2006 07:42:04 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:11225 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932173AbWHKLmC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Aug 2006 07:42:02 -0400
Subject: Re: Serial driver 8250 hangs the kernel with the VIA Nehemiah...
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Chris Pringle <chris.pringle@miranda.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <44DC6524.4000401@miranda.com>
References: <44DC6524.4000401@miranda.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 11 Aug 2006 13:02:08 +0100
Message-Id: <1155297728.24077.52.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Gwe, 2006-08-11 am 12:08 +0100, ysgrifennodd Chris Pringle:
> > Unlikely as it would affect both. More likely would be that the ISA bus
> > clock is generated off the PCI bus clock and you have one of the
> > multipliers wrong or too high for the board.
> >   
> Thats interesting, but wouldn't this produce strange side affects for 
> the 2.4 kernel as well? 2.4 works fine on both VIAs and Celerons.

That I wonder about. The power management stuff and some other things
that matter for timing are different however.

> I'll give the interrupt disabling a go...

Its just a guess but if you have low latency stuff, you have pre-empt
enabled and you actually depend upon the semantics of inb_p/outb_p
giving delays reliably then I'm not convinced are guarantees are strong
enough

Specifically we don't have any pre-empt protection between the I/O delay
and the I/O so we could violate it as we don't have pre-empt disables in
inb_p/outb_p and if your CPU context switch is quick enough it could
trigger a problem.

Alan

