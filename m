Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135245AbQLIBJA>; Fri, 8 Dec 2000 20:09:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132832AbQLIBIt>; Fri, 8 Dec 2000 20:08:49 -0500
Received: from adsl-151-196-236-18.baltmd.adsl.bellatlantic.net ([151.196.236.18]:5936
	"EHLO vaio.greennet") by vger.kernel.org with ESMTP
	id <S130471AbQLIBIl>; Fri, 8 Dec 2000 20:08:41 -0500
Date: Fri, 8 Dec 2000 19:42:46 -0500 (EST)
From: Donald Becker <becker@scyld.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: question about tulip patch to set CSR0 for pci 2.0 bus
In-Reply-To: <E144XcX-0004gd-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.10.10012081934270.797-100000@vaio.greennet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 9 Dec 2000, Alan Cox wrote:

> > Just in case you didn't catch it: this is not a PCI v2.0 vs. v2.1 issue.
> > The older Tulips work great with PCI v2.0 and v2.1.  The bug is with longer
> > bursts and a specific i486 chipset/motherboard.
> 
> Which chipset. I can then add it to the PCI quirks and we can do it nicely
> in 2.4 so that drivers can test the pci quirk list

I had the problem with the Intel Saturn II chipset used on the Asus SP3G.
The same problem was reported with the Saturn I on the SP3.

The bug manifests as occasional bus-master transfer data corruption.

The work-around was to change the Tulip PCI control register to use 
  8 longword cache alignment, 8 longword burst.
when the Tulip driver was run on a 486.

The old non-module work-around was
    if (x86 <= 4)
	  printk(KERN_INFO "%s: This is a 386/486 PCI system, setting cache "
			 "alignment to %x.\n", dev->name,
			 0x01A00000 | (x86 <= 4 ? 0x4800 : 0x8000));

I removed this code and replaced with the ability to set the variable "csr0"
as a module option.  There is no way to activate the fix with a built-in
driver.

Donald Becker				becker@scyld.com
Scyld Computing Corporation		http://www.scyld.com
410 Severn Ave. Suite 210		Second Generation Beowulf Clusters
Annapolis MD 21403			410-990-9993

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
