Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261526AbVCBXjh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261526AbVCBXjh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 18:39:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261525AbVCBXj0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 18:39:26 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:46505 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S261508AbVCBXiB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 18:38:01 -0500
Date: Wed, 2 Mar 2005 17:37:57 -0600
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Jesse Barnes <jbarnes@engr.sgi.com>, linux-pci@atrey.karlin.mff.cuni.cz,
       Matthew Wilcox <matthew@wil.cx>, Linus Torvalds <torvalds@osdl.org>,
       Jeff Garzik <jgarzik@pobox.com>,
       Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       linux-ia64@vger.kernel.org, "Luck, Tony" <tony.luck@intel.com>
Subject: Re: [PATCH/RFC] I/O-check interface for driver's error handling
Message-ID: <20050302233757.GP1220@austin.ibm.com>
References: <422428EC.3090905@jp.fujitsu.com> <Pine.LNX.4.58.0503010844470.25732@ppc970.osdl.org> <20050301165904.GN28741@parcelfarce.linux.theplanet.co.uk> <200503010910.29460.jbarnes@engr.sgi.com> <20050301183333.GB1220@austin.ibm.com> <1109716047.5679.51.camel@gaston> <20050302200216.GM1220@austin.ibm.com> <1109803572.5679.113.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1109803572.5679.113.camel@gaston>
User-Agent: Mutt/1.5.6+20040818i
From: Linas Vepstas <linas@austin.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 03, 2005 at 09:46:12AM +1100, Benjamin Herrenschmidt was heard to remark:
> On Wed, 2005-03-02 at 14:02 -0600, Linas Vepstas wrote:
> > On Wed, Mar 02, 2005 at 09:27:27AM +1100, Benjamin Herrenschmidt was heard to remark:
> 
> > That's a style issue.  Propose an API, I'll code it.   We can have
> > the master recovery thread be a state machine, and so every device
> > driver gets notified of state changes:
> > 
> > typedef enum pci_bus_state {
> >      DEVICE_IO_FROZEN=1,
> >      DEVICE_IO_THAWED,
> >      DEVICE_PERM_FAILURE,
> > };
> > 
> > struct pci_driver {
> >    .... 
> >    void (*io_state_change) (struct pci_dev *dev, pci_bus_state);
> > };
> > 
> > would that work?
> 
> Too much ppc64-centric.

Ah Ben, you are hard to make happy.

> Also, we want to use the re-enable IOs facility of EEH to give the
> driver a chance to extract diagnostic infos from the HW.

Yes, of course. Recovery would have to happen through multiple steps,
one of which is re-enabling i/o.   (Another one would be to ask all of
the device drivers affected by the outage if any of them need a 
device reset.)

Right now, my goal was not to specify the final interface with all the
bits correct, but to get agreement that this particular approach, of
modifying struct pci_driver, would make everyone happy.

--linas


