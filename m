Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267254AbUJWLAa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267254AbUJWLAa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Oct 2004 07:00:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267283AbUJWLAa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Oct 2004 07:00:30 -0400
Received: from hirsch.in-berlin.de ([192.109.42.6]:61878 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S267254AbUJWLAX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Oct 2004 07:00:23 -0400
X-Envelope-From: kraxel@bytesex.org
Date: Sat, 23 Oct 2004 12:37:24 +0200
From: Gerd Knorr <kraxel@bytesex.org>
To: Dominik Karall <dominik.karall@gmx.net>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-mm1
Message-ID: <20041023103724.GC18314@bytesex>
References: <20041022032039.730eb226.akpm@osdl.org> <200410230214.00100.dominik.karall@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200410230214.00100.dominik.karall@gmx.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 23, 2004 at 02:13:57AM +0200, Dominik Karall wrote:
> On Friday 22 October 2004 12:20, Andrew Morton wrote:
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9/2.6.9-m
> >m1/
> 
> I got this error without starting any tv application:
> saa7134[0]/irq[10,4251666]: r=0x20 s=0x00 PE
> saa7134[0]/irq: looping -- clearing PE (parity error!) enable bit

It's the saa7134 chip raising the IRQ with "parity error" bit set in the
IRQ status register.  Permanent error, acking the bit to the chip
doesn't make it go away, so the driver disables this IRQ condition to
make the card quiet.

Not sure why this happens, it really shouldn't see parity errors on the
PCI bus.  I've never seen that myself on my machines, probably it is
hardware related.

  Gerd

-- 
return -ENOSIG;
