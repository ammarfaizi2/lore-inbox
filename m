Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317054AbSFAUO3>; Sat, 1 Jun 2002 16:14:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317052AbSFAUO2>; Sat, 1 Jun 2002 16:14:28 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:56838
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S317051AbSFAUO1>; Sat, 1 Jun 2002 16:14:27 -0400
Date: Sat, 1 Jun 2002 13:13:33 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Anthony Spinillo <tspinillo@linuxmail.org>, linux-kernel@vger.kernel.org
Subject: Re: INTEL 845G Chipset IDE Quandry
In-Reply-To: <1022935203.20348.22.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.10.10206011258160.5846-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Alan,

This is one of the versions of INTEL which has extra bandwidth if you want
wanted to the async IO.  Meaning the device could be set faster than the
host when reading from the host.  However when writing to the host the
device "must" be set to match.  The buffer is not capable of safely
handling the extra push.

So in 2.4 we will properly time the host, unlike 2.5 which has elected to
overdrive the hardware.

The effect is the following.  "LINUS are you listening?"

Ultra DMA 100 uses 4 data clocks to transfer "X" amount of data.
Ultra DMA 133 uses 3 data clocks to transfer "X" amount of data.

So if a bad host trys to push the limits, it ends up missing a data
strobe and the DATA goes away quietly without warning.  NICE!

Maybe now people will understand why 2.5 is falling apart and it is not
Martin's fault.  He is just getting bad information and bad patches.
He actual has nearly the same model I was working on to use fucntion
pointers in the style of "MiniPort (tm)".  I will explain why this is
desired later.

Cheers,

Andre Hedrick
LAD Storage Consulting Group

PS AntonA, my promise to you to inform Linus of one of the major design
flaws of 2.5 is now met.

On 1 Jun 2002, Alan Cox wrote:

> On Sat, 2002-06-01 at 12:03, Anthony Spinillo wrote:
> > PCI_IDE: unknown IDE controller on PCI bus 00 device
> > f9, VID=8086, DID=24cb
> > PCI: Device 00:1f.1 not available because of resource
> > collisions
> > PCI_IDE: (ide_setup_pci_device:) Could not enable
> > device.
> 
> If you look with lspci -v you will find your BIOS has mismapped or
> forgotten to map some of the control register space for that device.
> 
> Alan
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

