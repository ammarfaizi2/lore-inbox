Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261757AbVBPBMO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261757AbVBPBMO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 20:12:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261963AbVBPBMN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 20:12:13 -0500
Received: from rproxy.gmail.com ([64.233.170.202]:41134 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261757AbVBPBIo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 20:08:44 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=XWz/sNCc8CfoNptVsGjkCUZmFv/yJXdlgCLlKTqRk/XCIuHd/UCvlthlnutp57+hWBITxPVM8BeN9VEE8HoPDQcknKoogdLbc24i+146yMXRYx/W+kQkzY1zUXmoaB6W4+TiH3K6Afy4nL8AMmLwh2o6k/pPCXcMTfsoB0vx3o0=
Message-ID: <9e473391050215170874051b29@mail.gmail.com>
Date: Tue, 15 Feb 2005 20:08:44 -0500
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] quiet non-x86 option ROM warnings
Cc: Jesse Barnes <jbarnes@sgi.com>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <1108515632.13394.59.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <200502151557.06049.jbarnes@sgi.com>
	 <9e473391050215163621dafa65@mail.gmail.com>
	 <200502151645.27774.jbarnes@sgi.com>
	 <1108515632.13394.59.camel@gaston>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There is a new io resource flag as part of the pci rom code,
IORESOURCE_ROM_SHADOW, that is used on x86. If IORESOURCE_ROM_SHADOW
is set, you should ignore the physical ROM and use the copy at C000:0.
Can we build an equivalent flag for PPC? On x86 arch specific code
determines the boot video device and sets the flag.

Acutally, if radeon and rage fb drivers were using the PCI ROM support
(drivers/pci/rom.c) would they be having this problem? The 55AA check
is in the PCI ROM support too.

On Wed, 16 Feb 2005 12:00:31 +1100, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> 
> > I thought the signature described what type of ROM was there?  E.g. 0xaa55
> > means x86 ROM, x0303 means OF ROM, etc.?
> >
> > At any rate, not having a ROM at all (which my case may be) isn't an error
> > either, so I think removing the printk is appropriate regardless.
> 
> Oh, and if this is the PowerBook, then you don't have a ROM attached to
> the video chip, the OF driver is part of the main system ROM.
> 
> Ben.
> 
> 


-- 
Jon Smirl
jonsmirl@gmail.com
