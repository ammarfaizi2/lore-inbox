Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262460AbVCBUH0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262460AbVCBUH0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 15:07:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262459AbVCBUGe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 15:06:34 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:47095 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S262451AbVCBUCZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 15:02:25 -0500
Date: Wed, 2 Mar 2005 14:02:16 -0600
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Jesse Barnes <jbarnes@engr.sgi.com>, linux-pci@atrey.karlin.mff.cuni.cz,
       Matthew Wilcox <matthew@wil.cx>, Linus Torvalds <torvalds@osdl.org>,
       Jeff Garzik <jgarzik@pobox.com>,
       Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       linux-ia64@vger.kernel.org, "Luck, Tony" <tony.luck@intel.com>
Subject: Re: [PATCH/RFC] I/O-check interface for driver's error handling
Message-ID: <20050302200216.GM1220@austin.ibm.com>
References: <422428EC.3090905@jp.fujitsu.com> <Pine.LNX.4.58.0503010844470.25732@ppc970.osdl.org> <20050301165904.GN28741@parcelfarce.linux.theplanet.co.uk> <200503010910.29460.jbarnes@engr.sgi.com> <20050301183333.GB1220@austin.ibm.com> <1109716047.5679.51.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1109716047.5679.51.camel@gaston>
User-Agent: Mutt/1.5.6+20040818i
From: Linas Vepstas <linas@austin.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 02, 2005 at 09:27:27AM +1100, Benjamin Herrenschmidt was heard to remark:
> On Tue, 2005-03-01 at 12:33 -0600, Linas Vepstas wrote:
> 
> > The current proposal (and prototype) has a "master recovery thread"
> > to handle the coordinated reset of the pci controller.  This master
> > recovery thyread makes three calls in struct pci_driver:
> > 
> >    void (*frozen) (struct pci_dev *);  /* called when dev is first frozen */
> >    void (*thawed) (struct pci_dev *);  /* called after card is reset */
> >    void (*perm_failure) (struct pci_dev *);  /* called if card is dead */
> 
> See my other emails. I think only one callback is enough, and I think we
> need more parameters.

That's a style issue.  Propose an API, I'll code it.   We can have
the master recovery thread be a state machine, and so every device
driver gets notified of state changes:

typedef enum pci_bus_state {
     DEVICE_IO_FROZEN=1,
     DEVICE_IO_THAWED,
     DEVICE_PERM_FAILURE,
};

struct pci_driver {
   .... 
   void (*io_state_change) (struct pci_dev *dev, pci_bus_state);
};

would that work?

--linas
