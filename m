Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261555AbVBNUDp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261555AbVBNUDp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Feb 2005 15:03:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261549AbVBNUB2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Feb 2005 15:01:28 -0500
Received: from atlmail.prod.rxgsys.com ([64.74.124.160]:44006 "EHLO
	bastet.signetmail.com") by vger.kernel.org with ESMTP
	id S261552AbVBNUA6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Feb 2005 15:00:58 -0500
Date: Mon, 14 Feb 2005 15:00:43 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: Roland Dreier <roland@topspin.com>
Cc: Greg KH <greg@kroah.com>, Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: avoiding pci_disable_device()...
Message-ID: <20050214200043.GA15868@havoc.gtf.org>
References: <4210021F.7060401@pobox.com> <20050214190619.GA9241@kroah.com> <4211013E.6@pobox.com> <52hdke29sh.fsf@topspin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52hdke29sh.fsf@topspin.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 14, 2005 at 11:58:38AM -0800, Roland Dreier wrote:
>     Jeff> * pci_request_regions() should be axiomatic.  By that I mean,
>     Jeff> pci_enable_device() should
>     Jeff> 	(a) handle pci_request_regions() completely
>     Jeff> 	(b) fail if regions are not available
> 
> There's one pitfall here: for a device using MSI-X, the MSI-X table is
> going to be somewhere in one of the device's BARs.  When the device
> driver does pci_enable_msix(), drivers/pci/msi.c will do
> request_region() on this table.  If the device driver has already done
> pci_request_regions(), then this will fail and the driver won't be
> able to use MSI-X.  The current solution is for the driver to avoid
> requesting the whole BAR where the MSI-X table is.


That's an MSI bug.

A current PCI driver -should- be using pci_request_regions().

	Jeff



