Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261790AbVFGAAO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261790AbVFGAAO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Jun 2005 20:00:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261791AbVFFX6X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Jun 2005 19:58:23 -0400
Received: from lyle.provo.novell.com ([137.65.81.174]:18265 "EHLO
	lyle.provo.novell.com") by vger.kernel.org with ESMTP
	id S261784AbVFFX4g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Jun 2005 19:56:36 -0400
Date: Mon, 6 Jun 2005 16:56:18 -0700
From: Greg KH <gregkh@suse.de>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: "David S. Miller" <davem@davemloft.net>, tom.l.nguyen@intel.com,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       roland@topspin.com
Subject: Re: pci_enable_msi() for everyone?
Message-ID: <20050606235618.GA12143@suse.de>
References: <20050603224551.GA10014@kroah.com> <20050605.124612.63111065.davem@davemloft.net> <20050606225548.GA11184@suse.de> <42A4D771.7080400@pobox.com> <20050606231325.GA11610@suse.de> <42A4E213.8050102@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42A4E213.8050102@pobox.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 06, 2005 at 07:53:55PM -0400, Jeff Garzik wrote:
> Greg KH wrote:
> >On Mon, Jun 06, 2005 at 07:08:33PM -0400, Jeff Garzik wrote:
> >
> >>Greg KH wrote:
> >>
> >>>Why would it matter?  The driver shouldn't care if the interrupts come
> >>>in via the standard interrupt way, or through MSI, right?  And if it
> >>
> >>It matters.
> >>
> >>Not only the differences DaveM mentioned, but also simply that you may 
> >>assume your interrupt is not shared with anyone else.
> >
> >
> >Ok, and again, how would the call, pci_in_msi_mode(struct pci_dev *dev)
> >not allow for the driver to determine this?
> 
> Let me see if I understand this correctly :)
> 
> A technology (MSI) allows one to more efficiently call interrupt 
> handlers, with fewer bus reads...  and you want to add a test to each 
> interrupt handler -- a test which adds several bus reads to the hot path 
> of every MSI driver?

hell no.

> We want to -decrease- the overhead involved with an interrupt, but 
> pci_in_msi_mode() increases it.

No, just call pci_in_msi_mode() where you were previously calling
pci_enable_msi() to test to see if we are in msi mode.

Patches in a bit to hopefully better show what I am talking about...

thanks,

greg k-h
