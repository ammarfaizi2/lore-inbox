Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263019AbUCSRJU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Mar 2004 12:09:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262850AbUCSRJU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Mar 2004 12:09:20 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:30915 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261915AbUCSRJN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Mar 2004 12:09:13 -0500
Date: Fri, 19 Mar 2004 17:09:09 +0000
From: Matthew Wilcox <willy@debian.org>
To: Matthew Wilcox <willy@debian.org>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@zip.com.au>, Greg KH <greg@kroah.com>,
       David Mosberger <davidm@hpl.hp.com>, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org
Subject: Re: [2/3] Use insert_resource in pci_claim_resource
Message-ID: <20040319170909.GR25059@parcelfarce.linux.theplanet.co.uk>
References: <20040318235024.GH25059@parcelfarce.linux.theplanet.co.uk> <20040318235217.GJ25059@parcelfarce.linux.theplanet.co.uk> <20040319095600.A9678@flint.arm.linux.org.uk> <20040319145212.GN25059@parcelfarce.linux.theplanet.co.uk> <20040319153639.E14431@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040319153639.E14431@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 19, 2004 at 03:36:39PM +0000, Russell King wrote:
> On Fri, Mar 19, 2004 at 02:52:12PM +0000, Matthew Wilcox wrote:
> > But I do think insert_resource is the right call to make.  If the device has
> > the wrong resources, that means something's gone awfully wrong earlier in
> > the pci code.
> 
> Sure, but due to the request_resource semantics, it provides a good way
> to catch this should it occur.

Now that I try it, we lose.  ACPI allows us an unlimited number of resources
that can be routed to each bus, and pci_bus only has space for 4.  On my
rx2600 box, we have 5 resources pointing to bus 0x20:

# cat /proc/iomem /proc/ioports |grep :20
90000000-97ffffff : PCI Bus 0000:20
ff5e0000-ff5e0007 : PCI Bus 0000:20
ff5e2000-ff5e2007 : PCI Bus 0000:20
90004000000-90103fffffe : PCI Bus 0000:20
00002000-00002fff : PCI Bus 0000:20

Sure, you can argue that some of these should be coalesced and others
aren't used, but I'm not comfortable diddling with that in the kernel,
or asking firmware to change that.  And nobody knows what tomorrow will
bring in terms of PCI bus topologies.  So I'd like the insert_resource
patch to go in.

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
