Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262704AbUCSOwW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Mar 2004 09:52:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262859AbUCSOwW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Mar 2004 09:52:22 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:41914 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262704AbUCSOwS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Mar 2004 09:52:18 -0500
Date: Fri, 19 Mar 2004 14:52:12 +0000
From: Matthew Wilcox <willy@debian.org>
To: Matthew Wilcox <willy@debian.org>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@zip.com.au>, Greg KH <greg@kroah.com>,
       David Mosberger <davidm@hpl.hp.com>, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org
Subject: Re: [2/3] Use insert_resource in pci_claim_resource
Message-ID: <20040319145212.GN25059@parcelfarce.linux.theplanet.co.uk>
References: <20040318235024.GH25059@parcelfarce.linux.theplanet.co.uk> <20040318235217.GJ25059@parcelfarce.linux.theplanet.co.uk> <20040319095600.A9678@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040319095600.A9678@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 19, 2004 at 09:56:00AM +0000, Russell King wrote:
> I think we want to preserve the existing behaviour rather than change
> it.  We really do want to request the device resource against its
> immediate parent because that is the way PCI works - if a devices
> resources don't fall within the parent bus resources, we want to
> know about it.
> 
> May I suggest that ia64 sets the parent bus resources appropriately,
> which should relieve this problem (iow, pci_root_bus->resource[0..3])?
> If pci_find_parent_resource() is returning the wrong thing, its likely
> that other users of this function will also be getting the wrong answer.

I see what's going on ... pci_read_bridge_bases() returns immediately
because this is the root bus.  So we need to point the root bus resources
elsewhere ...  this looks doable.

But I do think insert_resource is the right call to make.  If the device has
the wrong resources, that means something's gone awfully wrong earlier in
the pci code.

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
