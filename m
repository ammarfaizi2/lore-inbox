Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267228AbSLEFhM>; Thu, 5 Dec 2002 00:37:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267229AbSLEFhM>; Thu, 5 Dec 2002 00:37:12 -0500
Received: from TYO201.gate.nec.co.jp ([210.143.35.51]:26348 "EHLO
	TYO201.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id <S267228AbSLEFhL>; Thu, 5 Dec 2002 00:37:11 -0500
To: James Bottomley <James.Bottomley@steeleye.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] generic device DMA implementation
References: <200212042142.gB4LgfI04384@localhost.localdomain>
Reply-To: Miles Bader <miles@gnu.org>
System-Type: i686-pc-linux-gnu
Blat: Foop
From: Miles Bader <miles@lsi.nec.co.jp>
Date: 05 Dec 2002 14:44:39 +0900
In-Reply-To: <200212042142.gB4LgfI04384@localhost.localdomain>
Message-ID: <buobs41rpdk.fsf@mcspd15.ucom.lsi.nec.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Bottomley <James.Bottomley@steeleye.com> writes:
> > Keep in mind that sometimes the actual _implementation_ is also highly
> > PCI-specific -- that is, what works for PCI devices may not work for
> > other devices and vice-versa.
> 
> that can all be taken care of in the platform implementation.
> 
> In general, the generic device already has enough information that the
> platform implementation can be highly bus specific---and, of course,
> once you know exactly what bus it's on, you can cast it to the bus
> device if you want.

I presume you mean something like (in an arch-specific file somewhere):

void *dma_alloc_consistent (struct device *dev, size_t size,
                            dma_addr_t *dma_handle,
        		    enum dma_conformance_level level)
{
    if (dev->SOME_FIELD == SOME_CONSTANT)
        return my_wierd_ass_pci_alloc_consistent ((struct pci_dev *)dev, ...);
    else
        return 0; /* or kmalloc(...); */
}

?

I did a bit of grovelling, but I'm still not quite sure what test I
can do (i.e., what SOME_FIELD and SOME_CONSTANT should be, if it's
really that simple).

Ah well, as long as it's possible I guess I'll figure it out when the
source hits the fan...

-Miles
-- 
I have seen the enemy, and he is us.  -- Pogo
