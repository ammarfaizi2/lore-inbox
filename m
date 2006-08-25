Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422905AbWHYU6j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422905AbWHYU6j (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 16:58:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422909AbWHYU6j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 16:58:39 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:31150 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1422905AbWHYU6j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 16:58:39 -0400
Subject: Re: Strange transmit corruption in jsm driver on geode sc1200
	system
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20060825203047.GH13641@csclub.uwaterloo.ca>
References: <20060825203047.GH13641@csclub.uwaterloo.ca>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 25 Aug 2006 22:20:17 +0100
Message-Id: <1156540817.3007.270.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Gwe, 2006-08-25 am 16:30 -0400, ysgrifennodd Lennart Sorensen:
> The driver is doing memcpy_toio to tranfer data to the transmit FIFO
> (which is a 64byte memory mapped block of memory on the PCI bus as far
> as I can tell).  The data in the transmit queue is in the right order

That should be staying in order unless the device memory is mislabelled
and prefetchable etc.

> being passed to memcpy_toio, but somehow by the time it is in the uart
> and goes out the transmiter, every 4th byte is moved 3 bytes back.

What happens if you swap the memcpy_toio with while() writeb() ?

> I read something about the geodes doing memory write reordering, but
> that it is supposed to magically not screw up PCI writes.  I have no
> idea if it is or not though.

They do a lot of stuff but it should not affect the PCI side and I'd
expect it to do other things than byte lane re-ordering.

> Does anyone have any suggestions for something to try?

Is the buffer 32bit aligned ?


