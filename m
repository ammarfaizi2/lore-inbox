Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751680AbWADK5n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751680AbWADK5n (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 05:57:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751681AbWADK5n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 05:57:43 -0500
Received: from mail.suse.de ([195.135.220.2]:27780 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751679AbWADK5n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 05:57:43 -0500
From: Andi Kleen <ak@suse.de>
To: Dieter =?iso-8859-1?q?St=FCken?= <stueken@conterra.de>
Subject: Re: X86_64 + VIA + 4g problems
Date: Wed, 4 Jan 2006 11:57:35 +0100
User-Agent: KMail/1.8.2
Cc: linux-kernel@vger.kernel.org
References: <43B90A04.2090403@conterra.de> <p731wzpjtvm.fsf@verdi.suse.de> <43BBA2FE.5060006@conterra.de>
In-Reply-To: <43BBA2FE.5060006@conterra.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200601041157.35449.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 04 January 2006 11:27, Dieter Stüken wrote:
> Andi Kleen wrote:
> > [can you please not always drop me from cc with each reply?] 
> 
> sorry, I thought the other way around: it would be annoying
> to get each mail twice...
> 
> I just found a mailing list "discuss@x86-64.org". Would it be
> better to turn over there, instead of polluting linux.kernel
> by this?

I already cc'ed it with the reply to your first mail, but you and your
colleague with the same problem persistently destroyed
the cc list with each reply so I gave up eventually.

No need to send it there again now.

> 
> >> But swiotlb=force works well! 
> >
> > This means your PCI bridge doesn't support addresses >4GB. 
> >
> >> The pci-gart.c patch seems to disable dma.
> > 
> > Only DMA for addresses >4GB.
> > 
> > If your torture test involves more than 64MB of IO in flight
> > you might also need to increase the bounce buffer area
> > with swiotlb=128M or somesuch. 
> 
> I'm about to understand whats going on. So should I use the
> dma patch INSTEAD of "swiotlb=force"? I'll try that tonight.
> 
> > When you not compile in the SKGE network driver does everything else work? 
> 
> I may test it again, but all seemed to work without any patch or
> swiotlb settings when running without the SKGE network driver.

That's likely because the SKGE driver is your only device
that can DMA >4GB.  Typical lowend IDE, sound etc. devices have
already 4GB limits and would be forced through bounce buffering
anyways. The patch just forces that for all devices.

Also it's only a hack and would need to be made VIA specific. But 
I'm trying to get confirmation of the problem from VIA first
because it's pretty drastic action. It's still possible that 
it's only a BIOS bug or somesuch that could be worked around
by setting the right magic bits

We had a similar problem some time ago with a small number
of NF4 boards where it turned out to be a broken BIOS not
programming the bridge correclty.

One contributing factor is likely that the cheap boards are
normally not tested with 4GB RAM, and VIA is normally only found
on cheap boards.

-Andi
