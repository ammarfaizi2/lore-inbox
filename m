Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262100AbVCRXOh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262100AbVCRXOh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Mar 2005 18:14:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262108AbVCRXOh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Mar 2005 18:14:37 -0500
Received: from gate.crashing.org ([63.228.1.57]:42452 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262100AbVCRXO3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Mar 2005 18:14:29 -0500
Subject: Re: PCI Error Recovery API Proposal. (WAS::
	[PATCH/RFC]PCIErrorRecovery)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Grant Grundler <grundler@parisc-linux.org>
Cc: "Nguyen, Tom L" <tom.l.nguyen@intel.com>,
       Paul Mackerras <paulus@samba.org>,
       Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>,
       Greg KH <greg@kroah.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>, ak@muc.de,
       linuxppc64-dev <linuxppc64-dev@ozlabs.org>,
       linux-pci@atrey.karlin.mff.cuni.cz
In-Reply-To: <20050318181005.GA30909@colo.lackof.org>
References: <C7AB9DA4D0B1F344BF2489FA165E5024081326E8@orsmsx404.amr.corp.intel.com>
	 <20050318181005.GA30909@colo.lackof.org>
Content-Type: text/plain
Date: Sat, 19 Mar 2005 10:13:02 +1100
Message-Id: <1111187582.1236.192.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-03-18 at 11:10 -0700, Grant Grundler wrote:
> On Fri, Mar 18, 2005 at 09:24:02AM -0800, Nguyen, Tom L wrote:
> > >Likewise, with EEH the device driver could take recovery action on its
> > >own.  But we don't want to end up with multiple sets of recovery code
> > >in drivers, if possible.  Also we want the recovery code to be as
> > >simple as possible, otherwise driver authors will get it wrong.
> > 
> > Drivers own their devices register sets.  Therefore if there are any
> > vendor unique actions that can be taken by the driver to recovery we
> > expect the driver to do so.
> ...
> 
> All drivers also need to cleanup driver state if they can't
> simply recover (and restart pending IOs). ie they need to release
> DMA resources and return suitable errors for pending requests.

Additionally, in "real life", very few errors are cause by known errata.
If the drivers know about the errata, they usually already work around
them. Afaik, most of the errors are caused by transcient conditions on
the bus or the device, like a bit beeing flipped, or thermal
conditions... 

> To the driver writer, it's all "platform" code.
> Folks who maintain PCI (and other) services differentiate between
> "generic" and "arch/platform" specific. Think first like a driver
> writer and then worry about if/how that can be divided between platform
> generic and platform/arch specific code.
> 
> Even PCI-Express has *some* arch specific component. At a minimum each
> architecture has it's own chipset and firmware to deal with
> for PCI Express bus discovery and initialization. But driver writers
> don't have to worry about that and they shouldn't for error
> recovery either.

Exactly. A given platform could use Intel's code as-is, or may choose to
do things differently while still showing the same interface to drivers.
Eventually we may end up adding platform hooks to the generic PCIE code
like we have in the PCI code if some platforms require them.



