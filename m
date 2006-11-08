Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754465AbWKHIrv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754465AbWKHIrv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 03:47:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754463AbWKHIrv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 03:47:51 -0500
Received: from gate.crashing.org ([63.228.1.57]:57004 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1754464AbWKHIru (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 03:47:50 -0500
Subject: Re: DMA APIs gumble grumble
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Muli Ben-Yehuda <muli@il.ibm.com>
Cc: linux-input@atrey.karlin.mff.cuni.cz,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       "David S. Miller" <davem@davemloft.net>,
       Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>,
       Greg KH <greg@kroah.com>
In-Reply-To: <20061108082536.GA3405@rhun.haifa.ibm.com>
References: <1162950877.28571.623.camel@localhost.localdomain>
	 <20061108082536.GA3405@rhun.haifa.ibm.com>
Content-Type: text/plain
Date: Wed, 08 Nov 2006 19:47:33 +1100
Message-Id: <1162975653.28571.723.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-11-08 at 10:25 +0200, Muli Ben-Yehuda wrote:
> On Wed, Nov 08, 2006 at 12:54:37PM +1100, Benjamin Herrenschmidt wrote:
> 
> >  - For platforms like powerpc where I can have multiple busses on
> > different IOMMU's and with possibly different DMA ops, I really need to
> > have a per-device data structure for use by the DMA ops (in fact, in my
> > case, containing the DMA ops themselves). Right now, I defined a notion
> > of "device extension" (struct device_ext) that my current implementation
> > puts in device->firmware_data (don't look for it upstream, it's all
> > patches queuing up for 2.6.20 and about to go into powerpc.git), but
> > that I'd like to have flat in struct device instead. Would it be agreed
> > that linux/device.h includes itself an asm/device.h which contains a
> > definition for a struct device_ext that is within struct device ? That
> > would also avoid a pointer indirection which is a good thing for DMA
> > operations
> 
> I want multiple dma_ops for Calgary on x86-64, so strong thumbs up for
> doing this in a generic manner. device_ext kinda sucks as a name,
> though... if it's used for just dma_ops, how about device_dma_ops?
> 
> I agree with the rest of your suggestions too, FWIW.

Yes, I need multiple dma_ops for powerpc too and additional void * data
that go with them (iommu instance).

I use it for more than dma ops though. I posted the actual structure
content in another reply to Dave.

I agree, though, device_ext sucks as a name, you are welcome to propose
something better, I'm no good at finding names :-)

Ben.


