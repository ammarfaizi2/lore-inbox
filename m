Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265848AbUAHRnt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 12:43:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265784AbUAHRlr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 12:41:47 -0500
Received: from mtvcafw.SGI.COM ([192.48.171.6]:251 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id S265806AbUAHRkC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 12:40:02 -0500
Date: Thu, 8 Jan 2004 09:39:49 -0800
To: Leonid Grossman <leonid.grossman@s2io.com>
Cc: "'Grant Grundler'" <grundler@parisc-linux.org>,
       linux-kernel@vger.kernel.org, jeremy@sgi.com,
       "'Matthew Wilcox'" <willy@debian.org>,
       linux-pci@atrey.karlin.mff.cuni.cz, Jame.Bottomley@steeleye.com
Subject: Re: [RFC] Relaxed PIO read vs. DMA write ordering
Message-ID: <20040108173949.GB11168@sgi.com>
Mail-Followup-To: Leonid Grossman <leonid.grossman@s2io.com>,
	'Grant Grundler' <grundler@parisc-linux.org>,
	linux-kernel@vger.kernel.org, jeremy@sgi.com,
	'Matthew Wilcox' <willy@debian.org>,
	linux-pci@atrey.karlin.mff.cuni.cz, Jame.Bottomley@steeleye.com
References: <20040108063829.GC22317@colo.lackof.org> <005b01c3d603$d01b6c90$0400a8c0@S2IOtech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <005b01c3d603$d01b6c90$0400a8c0@S2IOtech.com>
User-Agent: Mutt/1.5.4i
From: jbarnes@sgi.com (Jesse Barnes)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 08, 2004 at 08:23:49AM -0800, Leonid Grossman wrote:
> > I interpret this to mean:
> >    Setting the RO bit in the PCI-X Command Register only enables
> >    the device to choose when to set RO Attribute bit when the device
> >    generates a PCI-X bus cycle.
> 
> Yes, this is exactly how (at least our 10GbE) PCI-X ASICs work.
> If the RO bit is set, the device decides whether the transaction
> requires strong ordering,
> and sets RO attribute accordingly.

Excellent, a card in the wild that actually does this! :)  Ok, now I'll
take of my sn2 tunnel vision glasses--we don't want another readX
variant, but it sounds like we'll need pcix_enable_relaxed() _and_
pci_sync_consistent() to support non-coherent platforms well.  How does
that sound?

Thanks,
Jesse
