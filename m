Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262577AbVBCBOK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262577AbVBCBOK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 20:14:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262686AbVBCBE5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 20:04:57 -0500
Received: from gate.crashing.org ([63.228.1.57]:59077 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262542AbVBCAa0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 19:30:26 -0500
Subject: Re: pci: Arch hook to determine config space size
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Brian King <brking@us.ibm.com>,
       Linux Arch list <linux-arch@vger.kernel.org>,
       Matthew Wilcox <matthew@wil.cx>, Greg KH <greg@kroah.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Christoph Hellwig <hch@infradead.org>,
       Paul Mackerras <paulus@samba.org>,
       linuxppc64-dev <linuxppc64-dev@ozlabs.org>,
       linux-pci@atrey.karlin.mff.cuni.cz
In-Reply-To: <200502021105.42249.arnd@arndb.de>
References: <200501281456.j0SEuI12020454@d01av01.pok.ibm.com>
	 <41FF0B0D.8020003@us.ibm.com> <1107233864.5963.65.camel@gaston>
	 <200502021105.42249.arnd@arndb.de>
Content-Type: text/plain
Date: Thu, 03 Feb 2005 11:23:35 +1100
Message-Id: <1107390215.30709.88.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-02-02 at 11:05 +0100, Arnd Bergmann wrote:

> How about something along the lines of this patch? Instead of adding a
> pointer to the pci data from the device node, it embeds the node inside
> a new struct pci_device_node. The patch is not complete and therefore
> not expected to work as is, but maybe you want to reuse it.
> 
> The interesting part that is missing is creating and destroying 
> pci_device_nodes in prom.c, maybe you have an idea how to do that.
> 
> I'm also not sure about eeh. Are the eeh functions known to be called
> only for device_nodes of PCI devices? If not, eeh_mode and 
> eeh_config_addr might have to stay inside of device_node.

I'd rather not go that way for now. There are at least PCI and VIO
devices concerned by this, and maybe more (depending on how I deal
with macio devices for example). We also want, ultimately, to have
the DMA routines be function pointers in this auxilliary structure.

Ben.


