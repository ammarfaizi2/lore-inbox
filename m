Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129047AbRBGVzo>; Wed, 7 Feb 2001 16:55:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129092AbRBGVzf>; Wed, 7 Feb 2001 16:55:35 -0500
Received: from front1.grolier.fr ([194.158.96.51]:28854 "EHLO
	front1.grolier.fr") by vger.kernel.org with ESMTP
	id <S129047AbRBGVzS> convert rfc822-to-8bit; Wed, 7 Feb 2001 16:55:18 -0500
Date: Wed, 7 Feb 2001 21:50:46 +0100 (CET)
From: Gérard Roudier <groudier@club-internet.fr>
To: "Richard B. Johnson" <root@chaos.analogic.com>
cc: davej@suse.de, Alan Cox <alan@redhat.com>, becker@scyld.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Hamachi not doing pci_enable before reading resources
In-Reply-To: <Pine.LNX.3.95.1010207144124.1258B-100000@chaos.analogic.com>
Message-ID: <Pine.LNX.4.10.10102072135320.905-100000@linux.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


You missed the newer statements about every piece of hardware being
assumed to be hot-pluggable and all the hardware being under full control
by CPU.

You also missed the well known point that only device drivers are broken
under Linux and that all the generic O/S code is just perfect. :-)

  Gérard.

On Wed, 7 Feb 2001, Richard B. Johnson wrote:

> On Wed, 7 Feb 2001 davej@suse.de wrote:
> 
> > 
> > Hi Alan,
> > 
> >  Another driver not doing pci_enable_device() early enough.
> > 
> > Dave.
> > 
> 
> A PCI device does not and should not be enabled to probe for resources!
> It is only devices that have BIOS that require the device to be enabled
> for memory I/O prior to downloading the BIOS into RAM. The BARs are
> read/writable (and are required to be), even when the Mem/I/O bits
> in the cmd/status register are clear.
> 
> This is a required condition!  You certainly don't want to write all
> ones to a decode (to find the resource length) of a live, on-line chip!
> If the chip hickups (think network chips connected to networks, on a
> warm-boot), you will trash lots of stuff in memory.
> 
> It looks as though you are "fixing" drivers that are not broken and,
> in fact, are trying to do the right thing. Maybe the PCI code in the
> kernel is preventing access to resources unless the device has been
> enabled??? If so, it's broken and should be fixed, instead of all
> the drivers.
> 
> Cheers,
> Dick Johnson
> 
> Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).
> 
> "Memory is like gasoline. You use it up when you are running. Of
> course you get it all back when you reboot..."; Actual explanation
> obtained from the Micro$oft help desk.
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
> 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
