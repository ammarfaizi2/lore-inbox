Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261551AbVBAE75@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261551AbVBAE75 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 23:59:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261548AbVBAE75
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 23:59:57 -0500
Received: from gate.crashing.org ([63.228.1.57]:38571 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261546AbVBAE7x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 23:59:53 -0500
Subject: Re: pci: Arch hook to determine config space size
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Brian King <brking@us.ibm.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
       Linux Arch list <linux-arch@vger.kernel.org>,
       Matthew Wilcox <matthew@wil.cx>, Greg KH <greg@kroah.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Christoph Hellwig <hch@infradead.org>,
       Paul Mackerras <paulus@samba.org>,
       linuxppc64-dev <linuxppc64-dev@ozlabs.org>,
       linux-pci@atrey.karlin.mff.cuni.cz
In-Reply-To: <41FF0B0D.8020003@us.ibm.com>
References: <200501281456.j0SEuI12020454@d01av01.pok.ibm.com>
	 <20050131192955.GJ31145@parcelfarce.linux.theplanet.co.uk>
	 <41FEA4AA.1080407@us.ibm.com> <200501312256.44692.arnd@arndb.de>
	 <41FEB492.2020002@us.ibm.com> <1107227727.5963.46.camel@gaston>
	 <41FF0B0D.8020003@us.ibm.com>
Content-Type: text/plain
Date: Tue, 01 Feb 2005 15:57:44 +1100
Message-Id: <1107233864.5963.65.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-01-31 at 22:52 -0600, Brian King wrote:

> Assuming I am reading the spec correctly, this is only a property of the 
> PHB, so I could move it into the pci_controller struct instead.

Note that Arnd seems to imply the opposite ...

BTW. I'm thinking about moving all those PCI/VIO related fields out of
struct device_node to their own structure and keep only a pointer to
that structure in device_node. That way, we avoid the bloat for every
single non-pci node in the system, and we can have different structures
for different bus types (along with proper iommu function pointers and
that sort-of-thing).

So if you think you really need a per-device info here, feel free to
add it to device_node for now, and I'll move it to the new structure
along with the rest of the stuff once I find time to do this patch.

Ben.


