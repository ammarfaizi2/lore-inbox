Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261216AbVBQWru@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261216AbVBQWru (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Feb 2005 17:47:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261215AbVBQWrt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Feb 2005 17:47:49 -0500
Received: from gate.crashing.org ([63.228.1.57]:12713 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261211AbVBQWrT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Feb 2005 17:47:19 -0500
Subject: Re: [PATCH] quiet non-x86 option ROM warnings
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Jesse Barnes <jbarnes@sgi.com>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <9e473391050217083312685e44@mail.gmail.com>
References: <200502151557.06049.jbarnes@sgi.com>
	 <1108515817.13375.63.camel@gaston> <200502161554.02110.jbarnes@sgi.com>
	 <1108601294.5426.1.camel@gaston>
	 <9e473391050217083312685e44@mail.gmail.com>
Content-Type: text/plain
Date: Fri, 18 Feb 2005 09:45:50 +1100
Message-Id: <1108680350.5665.7.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-02-17 at 11:33 -0500, Jon Smirl wrote:
> On Thu, 17 Feb 2005 11:48:14 +1100, Benjamin Herrenschmidt
> <benh@kernel.crashing.org> wrote:
> > On Wed, 2005-02-16 at 15:54 -0800, Jesse Barnes wrote:
> > > On Tuesday, February 15, 2005 5:03 pm, Benjamin Herrenschmidt wrote:
> > > > What about printing "No PCI ROM detected" ? I like having that info when
> > > > getting user reports, but I agree that a less worrying message would
> > > > be good.
> > >
> > > Ok, how about this then?  It changes the printks in both drivers to KERN_INFO
> > > and describes the situation a bit more accurately.
> > >
> > > Signed-off-by: Jesse Barnes <jbarnes@sgi.com>
> > >
> > > Thanks,
> > > Jesse
> > >
> > > P.S. Jon, I think the pci_map_rom code is buggy--if the option ROM signature
> > > is missing or indicates that there's no ROM, the routine still returns a
> > > valid pointer making the caller thing it succeeded.  If we fix that up we can
> > > fix up the callers.
> > 
> > No, pci_map_rom shouldn't test the signature IMHO. While PCI ROMs should
> > have the signature to be recognized as containing valid firmware images
> > on x86 BIOSes an OF, it's just a convention on these platforms, and I
> > would rather let people put whatever they want in those ROMs and still
> > let them map it...
> > 
> 
> pci_map_rom will return a pointer to any ROM it finds. It the
> signature is invalid the size returned will be zero. Is this ok or do
> we want it to do something different?

Can't the size be obtained like any other BAR ?

Ben.


