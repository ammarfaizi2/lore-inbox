Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261955AbVF0WdB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261955AbVF0WdB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 18:33:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261958AbVF0WdB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 18:33:01 -0400
Received: from mail.kroah.org ([69.55.234.183]:41347 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261955AbVF0Wc6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 18:32:58 -0400
Date: Mon, 27 Jun 2005 15:32:39 -0700
From: Greg KH <greg@kroah.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Neil Horman <nhorman@redhat.com>, linux-kernel@vger.kernel.org,
       jeff.garzik@pobox.com, akpm@osdl.org
Subject: Re: [Patch] Janitorial cleanup of GET_INDEX macro in arch/i386/pci/fixup.c
Message-ID: <20050627223239.GA24080@kroah.com>
References: <20050627140914.GD20880@hmsendeavour.rdu.redhat.com> <Pine.LNX.4.58.0506271516530.19755@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0506271516530.19755@ppc970.osdl.org>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 27, 2005 at 03:19:11PM -0700, Linus Torvalds wrote:
> 
> 
> On Mon, 27 Jun 2005, Neil Horman wrote:
> >
> > Patch to clean up the implementation of the GET_INDEX macro in the i386 pci
> > fixup code so that it uses the PCI_DEVFN macro, rather than re-implements it.
> 
> This looks wrong:
> 
> > -#define GET_INDEX(a, b) ((((a) - PCI_DEVICE_ID_INTEL_MCH_PA) << 3) + ((b) & 7))
> > +#define GET_INDEX(a, b) PCI_DEVFN((a - PCI_DEVICE_ID_INTEL_MCH_PA),b)
> 
> that first argument looks like it has parentheses at the wrong place, it 
> should be
> 
> 	(a) - PCI_DEVICE_ID_INTEL_MCH_PA
> 
> rather than
> 
> 	(a - PCI_DEVICE_ID_INTEL_MCH_PA)
> 
> methinks.
> 
> Other than that... Greg?

I'd like to say yes, but I'll get an ack by the pci express people from
Intel first (PCI_DEVFN masks off bits that might be needed here, don't
really know...)  Also, this is only used for an array index, not a
pci devfn memory access (look at how it is used in the code...)

I'll put it in my tree for now, and let it get testing, I would not
recommend it for yours just yet.

thanks,

greg k-h
