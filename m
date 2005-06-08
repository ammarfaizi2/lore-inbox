Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261398AbVFHRtD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261398AbVFHRtD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 13:49:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261470AbVFHRsF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 13:48:05 -0400
Received: from lyle.provo.novell.com ([137.65.81.174]:55338 "EHLO
	lyle.provo.novell.com") by vger.kernel.org with ESMTP
	id S261464AbVFHRp5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 13:45:57 -0400
Date: Wed, 8 Jun 2005 10:45:48 -0700
From: Greg KH <gregkh@suse.de>
To: Grant Grundler <grundler@parisc-linux.org>
Cc: Andi Kleen <ak@suse.de>, linux-pci@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org, Roland Dreier <roland@topspin.com>,
       Arjan van de Ven <arjan@infradead.org>,
       Andrew Vasquez <andrew.vasquez@qlogic.com>,
       Jeff Garzik <jgarzik@pobox.com>,
       "David S. Miller" <davem@davemloft.net>, tom.l.nguyen@intel.com
Subject: Re: [Penance PATCH] PCI: clean up the MSI code a bit
Message-ID: <20050608174548.GA3725@suse.de>
References: <20050608063559.GA22869@suse.de> <20050608134109.GW23831@wotan.suse.de> <20050608171440.GD5908@colo.lackof.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050608171440.GD5908@colo.lackof.org>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 08, 2005 at 11:14:40AM -0600, Grant Grundler wrote:
> On Wed, Jun 08, 2005 at 03:41:09PM +0200, Andi Kleen wrote:
> > I disagree it should stay as it is. Basically you are trading
> > a bit less complexity in Infiniband now for a lot of code everywhere.
> 
> It's not just infiniband. It's tg3 and e1000 as well.

Yes, it's every device that wants to enable MSI.  So far, only one
driver that wants to enable MSI, has to handle broken devices.  And odds
are, that driver just isn't tested properly yet :)

So I stand by my decision now, it's just too complex to enable MSI for
everyone and expect drivers to disable it properly if they need to.  The
logic is just convoluted (see the patch for details.)  As proof, I got
it completly wrong the first time, and I'm still not sure that I got it
correct after working on this for a while. :)

In the end, the pci_enable/pci_disable interface is the way to go.

thanks,

greg k-h
