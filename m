Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263679AbTLDW5A (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Dec 2003 17:57:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263692AbTLDW4z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Dec 2003 17:56:55 -0500
Received: from fed1mtao01.cox.net ([68.6.19.244]:39655 "EHLO
	fed1mtao01.cox.net") by vger.kernel.org with ESMTP id S263679AbTLDWzN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Dec 2003 17:55:13 -0500
Date: Thu, 4 Dec 2003 16:05:28 -0700
From: Jesse Allen <the3dfxdude@hotmail.com>
To: cheuche+lkml@free.fr
Cc: linux-kernel@vger.kernel.org
Subject: Re: NForce2 pseudoscience stability testing (2.6.0-test11) - IRQ flood related ?
Message-ID: <20031204230528.GA189@tesore.local>
References: <3FCF25F2.6060008@netzentry.com> <1070551149.4063.8.camel@athlonxp.bradney.info> <20031204163243.GA10471@forming> <frodoid.frodo.87vfow33zm.fsf@usenet.frodoid.org> <20031204175548.GB10471@forming> <20031204200208.GA4167@localnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031204200208.GA4167@localnet>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 04, 2003 at 09:02:08PM +0100, cheuche+lkml@free.fr wrote:
> Hello,
> 
> Along with the lockups already described here, I've noticed an
> unidentified source of interrupts on IRQ7.
...
> I wonder if people experiencing lockup problems also have these
> noise interrupts,

I just took a look at this, by setting up parport_pc, and yes I get noise.

This was my first sample with a kernel with APIC:
  7:      29230    IO-APIC-edge  parport0

Then I took a look again about 5 seconds later:
  7:      41560    IO-APIC-edge  parport0

And I looked again, and it was higher.  If you take a look repeatally, you see 
it increases for 2-3 seconds, then stops for 2-3, then starts increasing again 
and continues like this.  This is pretty much an idle system other than me
cat'ing.  I'm not using the parallel port at all.

Then I looked at the irq with parport_pc setup and with a kernel with APIC all 
disabled:
  7:          0          XT-PIC  parport0

And it is the same on repeated cat's.

These kernels are exactly the same except ones compiled with UP APIC and the 
other isn't.  I don't know how parport works, but seeing two different events
under this condition does seem suspicious.

> and I don't know if this has something to do with the
> lockups or if it is an independant problem.
> 

I have no idea, but it is suspicious, as I get lockups and this noise with the 
APIC enabled kernel.

Jesse
