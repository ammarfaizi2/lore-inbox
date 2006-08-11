Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751105AbWHKKQP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751105AbWHKKQP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Aug 2006 06:16:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751107AbWHKKQP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Aug 2006 06:16:15 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:16279 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751105AbWHKKQO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Aug 2006 06:16:14 -0400
Subject: Re: Serial driver 8250 hangs the kernel with the VIA Nehemiah...
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Chris Pringle <chris.pringle@miranda.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <44DC4530.4040906@miranda.com>
References: <44DC4530.4040906@miranda.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 11 Aug 2006 11:36:09 +0100
Message-Id: <1155292569.24077.41.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Gwe, 2006-08-11 am 09:52 +0100, ysgrifennodd Chris Pringle:
> on it. However, when the port is receiving a lot of data, it has the
> tendency to either get corrupted data, or to crash the kernel.

What do the crash traces look like

> The "inb" as it is will sometimes return bad data - I'm guessing this
> is due to ISA bus instability... Anyway I changed it to "inb_p" which
> cured the corruption problem, but has introduced another issue - it
> hangs the kernel.

Maybe you need to have a chat with your hardware guys. Certainly if
inb_p makes a difference you've got hardware not software side problems.

> Interestingly, it only hangs on systems with a VIA Nehemiah CPU, the
> Intel Celerons seem to work fine. Could this be a problem with writing
> to that dreaded port 0x080 within inb_p?

Unlikely as it would affect both. More likely would be that the ISA bus
clock is generated off the PCI bus clock and you have one of the
multipliers wrong or too high for the board.

> it only occur on the VIA chip and not the Celeron? I don't think the
> problem is there when the low latency patches are not applied - so I'm
> thinking it's probably a timing problem of some sort.

That bit is interesting. Something really off the wall to try - disable
interrupts around the inb_p(), especially if you are using pre-emption
and let me know what happens.

Alan

