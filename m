Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932442AbWEECWz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932442AbWEECWz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 May 2006 22:22:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932443AbWEECWz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 May 2006 22:22:55 -0400
Received: from smtp107.sbc.mail.mud.yahoo.com ([68.142.198.206]:51616 "HELO
	smtp107.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932442AbWEECWz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 May 2006 22:22:55 -0400
From: David Brownell <david-b@pacbell.net>
To: Greg KH <greg@kroah.com>, Nathan Becker <nathanbecker@gmail.com>
Subject: Re: USB 2.0 ehci failure with large amount of RAM (4GB) on x86_64
Date: Thu, 4 May 2006 19:22:50 -0700
User-Agent: KMail/1.7.1
Cc: ak@suse.de, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net
References: <2151339d0605032148n5d6936ay31ab017fbabc65b3@mail.gmail.com> <2151339d0605032152g64ec77bfhe90dc08180463c31@mail.gmail.com> <20060504052751.GA23054@kroah.com>
In-Reply-To: <20060504052751.GA23054@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605041922.52243.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Wed, May 03, 2006 at 09:52:11PM -0700, Nathan Becker wrote:
> > Hi,
> > 
> > I recently added two more memory modules to my Gigabyte K8NXP-SLI
> > motherboard, bringing the total up to 4GB.  I had 2GB previously and
> > things were running well with kernel 2.6.16.9 x86_64. The CPU is an
> > AMD 4800+ X2.
> > 
> > After the upgrade, USB 2.0 stopped working...

There's an erratum in NF4 parts affecting certain EHCI accesses to
memory addresses over the 2GB mark, and you might be seeing this.

Presumably you're running with the GART IOMMU?  If not, then turn
that on.  Maybe even turn on IOMMU_DEBUG.

Another experiment might be taking the PCI_VENDOR_ID_NVIDIA case
in drivers/usb/host/ehci-pci.c and adding a call to dma_set_mask()
in addition to the existing call.

- Dave

