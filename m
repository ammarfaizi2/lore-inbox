Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261996AbSKMQZO>; Wed, 13 Nov 2002 11:25:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262023AbSKMQZO>; Wed, 13 Nov 2002 11:25:14 -0500
Received: from atlrel8.hp.com ([156.153.255.206]:64201 "HELO atlrel8.hp.com")
	by vger.kernel.org with SMTP id <S261996AbSKMQZN>;
	Wed, 13 Nov 2002 11:25:13 -0500
Content-Type: text/plain; charset=US-ASCII
From: Bjorn Helgaas <bjorn_helgaas@hp.com>
To: Greg KH <greg@kroah.com>, Miles Bader <miles@gnu.org>
Subject: Re: [parisc-linux] Untested port of parisc_device to generic device interface
Date: Wed, 13 Nov 2002 09:32:00 -0700
User-Agent: KMail/1.4.3
Cc: "J.E.J. Bottomley" <James.Bottomley@steeleye.com>,
       Matthew Wilcox <willy@debian.org>,
       "Adam J. Richter" <adam@yggdrasil.com>, andmike@us.ibm.com, hch@lst.de,
       linux-kernel@vger.kernel.org, mochel@osdl.org,
       parisc-linux@lists.parisc-linux.org
References: <20021109060342.GA7798@kroah.com> <buon0odsyh9.fsf@mcspd15.ucom.lsi.nec.co.jp> <20021113075223.GZ2106@kroah.com>
In-Reply-To: <20021113075223.GZ2106@kroah.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200211130932.00864.bjorn_helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 13 November 2002 12:52 am, Greg KH wrote:
> On Wed, Nov 13, 2002 at 04:46:58PM +0900, Miles Bader wrote:
> > Greg KH <greg@kroah.com> writes:
> > > What is the real reason for needing this, pci_alloc_consistent()?  We
> > > have talked about renaming that to dev_alloc_consistent() in the past,
> > > which I think will work for you, right?
> > 
> > This this would end up [or have the ability to] invoking a bus-specific
> > routine at some point, right?  [so that a truly PCI-specific definition
> > could be still be had]
> 
> If that was needed, yes, we should not break that functionality.
> 
> Are there any existing archs that need more than just dma_mask moved to
> struct device out of pci_dev?  Hm, ppc might need a bit more...

Absolutely.  Boxes with multiple IOMMUs (at least ia64, sparc64, parisc)
need to look up the correct IOMMU with which to map the allocated buffer.
Typically this is in the pci_dev sysdata.

Bjorn

