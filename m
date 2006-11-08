Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754439AbWKHIZk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754439AbWKHIZk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 03:25:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754440AbWKHIZk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 03:25:40 -0500
Received: from mtagate6.uk.ibm.com ([195.212.29.139]:57688 "EHLO
	mtagate6.uk.ibm.com") by vger.kernel.org with ESMTP
	id S1754424AbWKHIZj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 03:25:39 -0500
Date: Wed, 8 Nov 2006 10:25:36 +0200
From: Muli Ben-Yehuda <muli@il.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-input@atrey.karlin.mff.cuni.cz,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       "David S. Miller" <davem@davemloft.net>,
       Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>,
       Greg KH <greg@kroah.com>
Subject: Re: DMA APIs gumble grumble
Message-ID: <20061108082536.GA3405@rhun.haifa.ibm.com>
References: <1162950877.28571.623.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1162950877.28571.623.camel@localhost.localdomain>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 08, 2006 at 12:54:37PM +1100, Benjamin Herrenschmidt wrote:

>  - For platforms like powerpc where I can have multiple busses on
> different IOMMU's and with possibly different DMA ops, I really need to
> have a per-device data structure for use by the DMA ops (in fact, in my
> case, containing the DMA ops themselves). Right now, I defined a notion
> of "device extension" (struct device_ext) that my current implementation
> puts in device->firmware_data (don't look for it upstream, it's all
> patches queuing up for 2.6.20 and about to go into powerpc.git), but
> that I'd like to have flat in struct device instead. Would it be agreed
> that linux/device.h includes itself an asm/device.h which contains a
> definition for a struct device_ext that is within struct device ? That
> would also avoid a pointer indirection which is a good thing for DMA
> operations

I want multiple dma_ops for Calgary on x86-64, so strong thumbs up for
doing this in a generic manner. device_ext kinda sucks as a name,
though... if it's used for just dma_ops, how about device_dma_ops?

I agree with the rest of your suggestions too, FWIW.

Cheers,
Muli
