Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263029AbVGNOIb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263029AbVGNOIb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 10:08:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261405AbVGNOIb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 10:08:31 -0400
Received: from wproxy.gmail.com ([64.233.184.205]:56172 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S263029AbVGNOIY convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 10:08:24 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=oh8O3bzsSdQKsogOJZwC0Wo6vwamfftfyPaVRY7QtqYRNuwGrtj40xqeBDjjZX8e5sh2pL5NKaso7CEW1njJx4o45ke8ZBMntxWEJKjIjKPuD+SCKYTBmv6KkHtwApyfRShMTlN31ppQpl5AEU/alH2WCfY9CySOJypSzKujvto=
Message-ID: <9e47339105071407073f07bed7@mail.gmail.com>
Date: Thu, 14 Jul 2005 10:07:34 -0400
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Greg KH <greg@kroah.com>,
       Andrew Morton <akpm@osdl.org>, Jon Smirl <jonsmirl@gmail.com>,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [patch 2.6] remove PCI_BRIDGE_CTL_VGA handling from setup-bus.c
In-Reply-To: <20050714145327.B7314@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050714155344.A27478@jurassic.park.msu.ru>
	 <20050714145327.B7314@flint.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/14/05, Russell King <rmk+lkml@arm.linux.org.uk> wrote:
> On Thu, Jul 14, 2005 at 03:53:44PM +0400, Ivan Kokshaysky wrote:
> > The setup-bus code doesn't work correctly for configurations
> > with more than one display adapter in the same PCI domain.
> > This stuff actually is a leftover of an early 2.4 PCI setup code
> > and apparently it stopped working after some "bridge_ctl" changes.
> > So the best thing we can do is just to remove it and rely on the fact
> > that any firmware *has* to configure VGA port forwarding for the boot
> > display device properly.
> 
> What happens when there is no firmware?
> 
> I'm sure this code would not have been added had there not been a reason
> for it.  Do we know why it was added?

I'm don't think it has ever been working in the 2.6 series. If you are
getting rid of it get rid of the #define PCI_BRIDGE_CTL_VGA in pci.h
too since this code was the only user.

Looking at the code as written I don't think it would work on my
machine with multiple VGA devices on different buses. I use the system
BIOS to enable the one I want and it sets up the bridges.

This code is part of VGA arbitration which BenH is addressing with a
more globally comprehensive patch. Ben's code will probably replace
it.

-- 
Jon Smirl
jonsmirl@gmail.com
