Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274983AbTHLBxi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 21:53:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274990AbTHLBxi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 21:53:38 -0400
Received: from [66.212.224.118] ([66.212.224.118]:1540 "EHLO
	hemi.commfireservices.com") by vger.kernel.org with ESMTP
	id S274983AbTHLBxV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 21:53:21 -0400
Date: Mon, 11 Aug 2003 21:41:30 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: Greg KH <greg@kroah.com>
Cc: long <tlnguyen@snoqualmie.dp.intel.com>, jun.nakajima@intel.com,
       linux-kernel@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net,
       tom.l.nguyen@intel.com
Subject: Re: Updated MSI Patches
In-Reply-To: <20030811211654.GA18578@kroah.com>
Message-ID: <Pine.LNX.4.53.0308112134400.26153@montezuma.mastecende.com>
References: <200308112051.h7BKp9ZU003007@snoqualmie.dp.intel.com>
 <20030811211654.GA18578@kroah.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Aug 2003, Greg KH wrote:

> > There are two types of MSI capable devices: one supports the MSI 
> > capability structure and other supports the MSI-X capability structure.
> > The patches provide two APIs msix_alloc_vectors/msix_free_vectors for 
> > only devices, which support the MSI-X capability structure, to request
> > for additional messages. By default, each MSI/MSI-X capable device 
> > function is allocated with one vector for below reasons:
> > - To achieve a backward compatibility with existing drivers if possible.
> > - Due to the current implementation of vector assignment, all devices 
> >   that support the MSI-capability structure work with no more than one 
> >   allocated vector.
> > - The hardware devices, which support the MSI-X capability structure, 
> >   may indicate the maximum capable number of vectors supported (32 
> >   vectors as example). However, the device drivers may require only 
> >   four. With provided APIs, the optimization of MSI vector allocation 
> >   is achievable.

IMO Multiplexing would be preferred, we can't be allocating that many 
vectors for one device/device driver

> > I hope there may be a way to determine the number of vectors supported 
> > by CPU during the run-time. I look at the file ../include/asm-i386/mach-
> > default/irq_vectors.h, the maximum of vectors (256) is already well 
> > commented.
> 
> Yeah, but that's in reference to APIC interrupt sources, right?  Does
> that correspond to these "vectors" too?  If so, why not just use the
> existing NR_IRQS value instead of creating your own?

There isn't a 1:1 relationship between NR_IRQS and NR_VECTORS we really 
shouldn't mix them together. NR_IRQS can be much higher than 256 whilst 
on i386 we're fixed to 256 vectors due to that being the Interrupt 
Descriptor Table capacity. It is still possible to service more interrupt 
lines than 256 on SMP however by making IDTs per 'interrupt servicing 
node'

	Zwane

