Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261831AbVCLBh6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261831AbVCLBh6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 20:37:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261897AbVCLBfa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 20:35:30 -0500
Received: from ozlabs.org ([203.10.76.45]:9903 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261890AbVCLBd3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 20:33:29 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16946.18186.86274.528426@cargo.ozlabs.ibm.com>
Date: Sat, 12 Mar 2005 12:34:02 +1100
From: Paul Mackerras <paulus@samba.org>
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Jesse Barnes <jbarnes@engr.sgi.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>, werner@sgi.com,
       Linus Torvalds <torvalds@osdl.org>, davej@redhat.com,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: AGP bogosities
In-Reply-To: <1110583375.4822.88.camel@eeyore>
References: <16944.62310.967444.786526@cargo.ozlabs.ibm.com>
	<200503102002.47645.jbarnes@engr.sgi.com>
	<1110515459.32556.346.camel@gaston>
	<200503110839.15995.jbarnes@engr.sgi.com>
	<1110563965.4822.22.camel@eeyore>
	<16946.7941.404582.764637@cargo.ozlabs.ibm.com>
	<1110583375.4822.88.camel@eeyore>
X-Mailer: VM 7.19 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bjorn Helgaas writes:

> I still don't quite understand this.  If the host bridge is not a
> PCI device, what PCI device contains the AGP capability that controls
> the host bridge?  I assume you're saying that you are required to

The AGP spec shows an example northbridge implementation that has the
AGP interface circuitry as a PCI-to-PCI bridge.  You don't have to do
it that way, but in any case you need some sort of PCI device to
represent the target (host) end of the AGP link.

> have TWO PCI devices that have the AGP capability, one for the AGP
> device and one for the bridge.

Yes, exactly.

> HP boxes certainly don't have that (zx6000 sample below).  I guess
> it wouldn't be the first time we deviated from a spec ;-)
> 
> Can you point me to the relevant section?

In the AGP 2.0 spec, the clearest statement I can find is in section
6.1.5, on page 248, where it says "Configuration registers are used by
the operating system to initialize A.G.P. features.  These features
must be supported by both A.G.P. master and target devices in the
following registers.", followed by a description of various PCI config
space registers.  In the context, "configuration registers" means
registers in the config space of a PCI device.  The AGP 3.0 spec is a
delta from the AGP 2.0 spec and doesn't revoke that requirement
anywhere that I could see.

Paul.
