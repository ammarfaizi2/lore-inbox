Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161748AbWKHXmL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161748AbWKHXmL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 18:42:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161753AbWKHXmL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 18:42:11 -0500
Received: from gate.crashing.org ([63.228.1.57]:452 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1161748AbWKHXmJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 18:42:09 -0500
Subject: Re: DMA APIs gumble grumble
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Muli Ben-Yehuda <muli@il.ibm.com>, linux-input@atrey.karlin.mff.cuni.cz,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       "David S. Miller" <davem@davemloft.net>,
       Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>,
       Greg KH <greg@kroah.com>
In-Reply-To: <20061108225612.GA12345@flint.arm.linux.org.uk>
References: <1162950877.28571.623.camel@localhost.localdomain>
	 <20061108082536.GA3405@rhun.haifa.ibm.com>
	 <1162975653.28571.723.camel@localhost.localdomain>
	 <20061108225612.GA12345@flint.arm.linux.org.uk>
Content-Type: text/plain
Date: Thu, 09 Nov 2006 10:41:21 +1100
Message-Id: <1163029281.28571.767.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-11-08 at 22:56 +0000, Russell King wrote:
> On Wed, Nov 08, 2006 at 07:47:33PM +1100, Benjamin Herrenschmidt wrote:
> > Yes, I need multiple dma_ops for powerpc too
> 
> Ditto for ARM.

Ok, so there is some interest in having the dma_ops in struct device
beyond powerpc.

I'll put together today a patch doing:

 - add #include <asm/device.h> to linux/device.h
 - add a device.h file in asm/* that does:

	struct dev_sysdata {
	};

 - add a struct dev_sysdata sysdata; field to struct device

That patch alone is 0 overhead and allows archs to start adding things.
I'll then modify my pending patches for 2.6.20 to use that instead of my
current device_ext thing.

Is that ok with everybody for 2.6.20 ?

Then, we can do, in no special order:

  - on x86, put the acpi data in there and remove firmware_data from
struct device

  - on x86, m32, frv, put the dma_coherent_mem pointer in there too and
remove it from struct device

  - you can use it on ARM to put your dma_operations pointer as I'm
doing in for powerpc

  - x86 can do the same 

etc...

Cheers,
Ben.


