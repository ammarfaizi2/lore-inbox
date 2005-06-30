Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262889AbVF3Isq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262889AbVF3Isq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Jun 2005 04:48:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262891AbVF3Isq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Jun 2005 04:48:46 -0400
Received: from mail.kroah.org ([69.55.234.183]:5839 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262889AbVF3IsN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Jun 2005 04:48:13 -0400
Date: Wed, 29 Jun 2005 23:42:00 -0700
From: Greg KH <greg@kroah.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Neil Horman <nhorman@redhat.com>,
       linux-kernel@vger.kernel.org, jeff.garzik@pobox.com, akpm@osdl.org
Subject: Re: [Patch] Janitorial cleanup of GET_INDEX macro in arch/i386/pci/fixup.c
Message-ID: <20050630064200.GA23852@kroah.com>
References: <20050627140914.GD20880@hmsendeavour.rdu.redhat.com> <Pine.LNX.4.58.0506271516530.19755@ppc970.osdl.org> <20050627223239.GA24080@kroah.com> <42C18543.4090604@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42C18543.4090604@pobox.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 28, 2005 at 01:13:39PM -0400, Jeff Garzik wrote:
> Greg KH wrote:
> >On Mon, Jun 27, 2005 at 03:19:11PM -0700, Linus Torvalds wrote:
> >
> >>
> >>On Mon, 27 Jun 2005, Neil Horman wrote:
> >>
> >>>Patch to clean up the implementation of the GET_INDEX macro in the i386 
> >>>pci
> >>>fixup code so that it uses the PCI_DEVFN macro, rather than 
> >>>re-implements it.
> >>
> >>This looks wrong:
> >>
> >>
> >>>-#define GET_INDEX(a, b) ((((a) - PCI_DEVICE_ID_INTEL_MCH_PA) << 3) + 
> >>>((b) & 7))
> >>>+#define GET_INDEX(a, b) PCI_DEVFN((a - PCI_DEVICE_ID_INTEL_MCH_PA),b)
> >>
> >>that first argument looks like it has parentheses at the wrong place, it 
> >>should be
> >>
> >>	(a) - PCI_DEVICE_ID_INTEL_MCH_PA
> >>
> >>rather than
> >>
> >>	(a - PCI_DEVICE_ID_INTEL_MCH_PA)
> >>
> >>methinks.
> >>
> >>Other than that... Greg?
> >
> >
> >I'd like to say yes, but I'll get an ack by the pci express people from
> >Intel first (PCI_DEVFN masks off bits that might be needed here, don't
> >really know...)  Also, this is only used for an array index, not a
> >pci devfn memory access (look at how it is used in the code...)
> >
> >I'll put it in my tree for now, and let it get testing, I would not
> >recommend it for yours just yet.
> 
> Please let me know, as I suggested this patch to Neil.
> 
> It sure seems like the code wants a real PCI devfn, even though it is 
> obviously doing a table index.
> 
> Comments?

I told Andrew to drop the patch, as the code does not want a real PCI devfn.

thanks,

greg k-h
