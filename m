Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135567AbRARUx5>; Thu, 18 Jan 2001 15:53:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135958AbRARUxs>; Thu, 18 Jan 2001 15:53:48 -0500
Received: from mail.zmailer.org ([194.252.70.162]:11534 "EHLO zmailer.org")
	by vger.kernel.org with ESMTP id <S135567AbRARUxg>;
	Thu, 18 Jan 2001 15:53:36 -0500
Date: Thu, 18 Jan 2001 22:53:16 +0200
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: idalton@ferret.phonewave.net
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Linux not adhering to BIOS Drive boot order?
Message-ID: <20010118225316.L25659@mea-ext.zmailer.org>
In-Reply-To: <mike@UDel.Edu> <200101171616.LAA01194@localhost.localdomain> <20010118065012.B26045@cadcamlab.org> <20010118095906.A8983@ferret.phonewave.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010118095906.A8983@ferret.phonewave.net>; from idalton@ferret.phonewave.net on Thu, Jan 18, 2001 at 09:59:06AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 18, 2001 at 09:59:06AM -0800, idalton@ferret.phonewave.net wrote:
...
> > Yes.  PCI-based drivers will most likely use bus order since the kernel
> > provides facilities to do this easily.  For a single driver driving
> > multiple cards on multiple bus types, who knows.
> 
> Multiple bus types... Compaq server with PCI and EISA, for example? IIRC
> the EISA bus is bridged onto one of the PCI busses. Perhaps a
> breadth-first scan; PCI busses first, then bridged devices on PCI, then
> internal non-PCI busses, then external busses.
> 
> Are there any systems where a non-PCI bus is not connected through a
> PCI-foo bridge?

	Yes.

	Oh, you propably won't meet them in PC world, but pick
	any UltraSPARC; PCI and SBUS are on parallel "hoses".
	("hose" is term used at Alpha code for the IO-bus to
	 CPU/MEMORY bus interface, sort of "north bridge".)
	Actually those UltraSPARC systems have core-bus called UPA,
	and IO-busses, like PCI and SBUS, are connected there...

	Also these "big" systems often do come with multiple "hoses"
	of same type.

	If you look carefully at intel things, there is this "FSB"
	which is the real core-bus, and IO-busses hang on it.


	I have never myself seen big Digital Alpha system where IO-
	busses are anything but PCI, but there exists options to place
	there FutureBus+, PCI, VME, TurboChannel, and several other
	DEC proprietary things.  With 43-45 bits of physical address
	space out of the processors, it is trivial to plug in multiple
	32-bit address space busses.

	In coherent view NUMA implementation of Linux, there possibly
	comes even the detail about which NUMA node the busses reside at.

> -- Ferret

/Matti Aarnio
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
