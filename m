Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261212AbVBQWsp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261212AbVBQWsp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Feb 2005 17:48:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261211AbVBQWso
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Feb 2005 17:48:44 -0500
Received: from gate.crashing.org ([63.228.1.57]:15273 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261212AbVBQWsf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Feb 2005 17:48:35 -0500
Subject: Re: [PATCH] quiet non-x86 option ROM warnings
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jesse Barnes <jbarnes@sgi.com>
Cc: Jon Smirl <jonsmirl@gmail.com>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <200502170945.30536.jbarnes@sgi.com>
References: <200502151557.06049.jbarnes@sgi.com>
	 <200502170929.54100.jbarnes@sgi.com>
	 <9e47339105021709321dc72ab2@mail.gmail.com>
	 <200502170945.30536.jbarnes@sgi.com>
Content-Type: text/plain
Date: Fri, 18 Feb 2005 09:47:15 +1100
Message-Id: <1108680436.5665.9.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-02-17 at 09:45 -0800, Jesse Barnes wrote:
> On Thursday, February 17, 2005 9:32 am, Jon Smirl wrote:
> > On Thu, 17 Feb 2005 09:29:53 -0800, Jesse Barnes <jbarnes@sgi.com> wrote:
> > > On Thursday, February 17, 2005 8:33 am, Jon Smirl wrote:
> > > > > No, pci_map_rom shouldn't test the signature IMHO. While PCI ROMs
> > > > > should have the signature to be recognized as containing valid
> > > > > firmware images on x86 BIOSes an OF, it's just a convention on these
> > > > > platforms, and I would rather let people put whatever they want in
> > > > > those ROMs and still let them map it...
> > > >
> > > > pci_map_rom will return a pointer to any ROM it finds. It the
> > > > signature is invalid the size returned will be zero. Is this ok or do
> > > > we want it to do something different?
> > >
> > > Shouldn't it return NULL if the signature is invalid?
> >
> > But then you couldn't get to your non-standard ROMs
> 
> Ok, how does this one look to you guys?  The r128 driver would need similar 
> fixes.

We could provide additional helpers, like pci_find_rom_partition(),
which takes the architecture code as an argument. It would check the
signature, and iterate all "partitions" til it finds the proper
architecture (or none).

Sorry, I'm still in the middle of breakfast, so no patch attached :)

Ben.


