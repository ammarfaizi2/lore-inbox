Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261621AbVFIF7n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261621AbVFIF7n (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Jun 2005 01:59:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262282AbVFIF7m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Jun 2005 01:59:42 -0400
Received: from mail.kroah.org ([69.55.234.183]:27546 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262281AbVFIF7Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Jun 2005 01:59:24 -0400
Date: Wed, 8 Jun 2005 22:26:08 -0700
From: Greg KH <gregkh@suse.de>
To: Stefan Smietanowski <stesmi@stesmi.com>
Cc: Greg KH <gregkh@suse.de>, Arjan van de Ven <arjan@infradead.org>,
       Andrew Vasquez <andrew.vasquez@qlogic.com>,
       Jeff Garzik <jgarzik@pobox.com>,
       "David S. Miller" <davem@davemloft.net>, tom.l.nguyen@intel.com,
       roland@topspin.com, linux-pci@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org, ak@suse.de
Subject: Re: [RFC PATCH] PCI: remove access to pci_[enable|disable]_msi() for drivers
Message-ID: <20050609052608.GA21618@kroah.com>
References: <20050607002045.GA12849@suse.de> <20050607010911.GA9869@plap.qlogic.org> <20050607051551.GA17734@suse.de> <1118129500.5497.16.camel@laptopd505.fenrus.org> <20050607161029.GB15345@suse.de> <42A7CB87.40706@stesmi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42A7CB87.40706@stesmi.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 09, 2005 at 06:54:31AM +0200, Stefan Smietanowski wrote:
> > 
> > The issue is, if pci_enable_msix() fails, we want to fall back to MSI,
> > so you need to call pci_enable_msi() for that (after calling
> > pci_disable_msi() before calling pci_enable_msix(), what a mess...)
> > 
> > So we still need both functions, and for MSI-X, the logic involved in
> > enabling it is horrible.  Let me see if this can be made saner...
> 
> Why not make pci_switch_to_msix() (yeah, horrible name) instead?
> 
> pci_switch_to_msix(dev)
> {
>   pci_disable_msi(dev);
>   if (!psi_enable_msix(dev))
>     pci_enable_msi(dev);
> }
> 
> And it can naturally inform the caller if it failed or not.

Yes, that would work, if you want to go down that path :)

After trying this all out, I'm convinced that we should just stick with
what we have.

thanks,

greg k-h
