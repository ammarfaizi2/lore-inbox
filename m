Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262406AbVFIOPt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262406AbVFIOPt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Jun 2005 10:15:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262407AbVFIOPt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Jun 2005 10:15:49 -0400
Received: from cantor2.suse.de ([195.135.220.15]:34701 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S262406AbVFIOPm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Jun 2005 10:15:42 -0400
Date: Thu, 9 Jun 2005 16:15:34 +0200
From: Andi Kleen <ak@suse.de>
To: Greg KH <gregkh@suse.de>
Cc: Grant Grundler <grundler@parisc-linux.org>, Andi Kleen <ak@suse.de>,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       Roland Dreier <roland@topspin.com>,
       Arjan van de Ven <arjan@infradead.org>,
       Andrew Vasquez <andrew.vasquez@qlogic.com>,
       Jeff Garzik <jgarzik@pobox.com>,
       "David S. Miller" <davem@davemloft.net>, tom.l.nguyen@intel.com
Subject: Re: [Penance PATCH] PCI: clean up the MSI code a bit
Message-ID: <20050609141534.GF23831@wotan.suse.de>
References: <20050608063559.GA22869@suse.de> <20050608134109.GW23831@wotan.suse.de> <20050608171440.GD5908@colo.lackof.org> <20050608174548.GA3725@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050608174548.GA3725@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 08, 2005 at 10:45:48AM -0700, Greg KH wrote:
> On Wed, Jun 08, 2005 at 11:14:40AM -0600, Grant Grundler wrote:
> > On Wed, Jun 08, 2005 at 03:41:09PM +0200, Andi Kleen wrote:
> > > I disagree it should stay as it is. Basically you are trading
> > > a bit less complexity in Infiniband now for a lot of code everywhere.
> > 
> > It's not just infiniband. It's tg3 and e1000 as well.
> 
> Yes, it's every device that wants to enable MSI.  So far, only one

No, it is every device that wants to use MSI-X. 

Also see the proposals from Jeff/Stefan et.al. for simpler interfaces
for this. No need to actually make it messy if we have nice helpers.

> driver that wants to enable MSI, has to handle broken devices.  And odds
> are, that driver just isn't tested properly yet :)
> 
> So I stand by my decision now, it's just too complex to enable MSI for

I think you decision is wrong here.

> everyone and expect drivers to disable it properly if they need to.  The
> logic is just convoluted (see the patch for details.)  As proof, I got
> it completly wrong the first time, and I'm still not sure that I got it
> correct after working on this for a while. :)
> 
> In the end, the pci_enable/pci_disable interface is the way to go.

No, it isnt.

-Andi
