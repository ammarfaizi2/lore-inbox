Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281317AbRKLIbS>; Mon, 12 Nov 2001 03:31:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281340AbRKLIbI>; Mon, 12 Nov 2001 03:31:08 -0500
Received: from galba.tp1.ruhr-uni-bochum.de ([134.147.240.75]:36879 "EHLO
	galba.tp1.ruhr-uni-bochum.de") by vger.kernel.org with ESMTP
	id <S281317AbRKLIaw>; Mon, 12 Nov 2001 03:30:52 -0500
Date: Mon, 12 Nov 2001 09:30:47 +0100 (CET)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
To: Keith Owens <kaos@ocs.com.au>
cc: Thomas Hood <jdthood@home.dhs.org>, <linux-kernel@vger.kernel.org>,
        <jdthood@mail.com>
Subject: Re: [PATCH] parport_pc to use pnpbios_register_driver() 
In-Reply-To: <32053.1005530189@kao2.melbourne.sgi.com>
Message-ID: <Pine.LNX.4.33.0111120921110.16450-100000@chaos.tp1.ruhr-uni-bochum.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Nov 2001, Keith Owens wrote:

> >The reasoning behind this is the following: When you have a driver 
> >built-in, but pnpbios modular, the driver cannot use pnpbios 
> >functionality. The above definition reflects exactly this.
> 
> Does this combination make sense?  If you are building a pnpbios driver
> into the kernel then the configuration should force pnpbios support to
> be built in as well.  We don't allow this combination for things like
> scsi or ide, they require the common support to be built in if any
> drivers are built in.  IMHO this problem should be fixed in .config,
> not in driver source.

The affected drivers usually support different interfaces to the hardware, 
like ISA, ISAPnP, PCI, so it makes sense to build them w/o ISAPnP support. 
For instance, people may want to have built-in serial support (w/o ISAPnP 
support is fine, because they've only got a standard SuperI/O chip), but 
also modular isapnp and sound driver support, so they can demand load 
sound support if necessary.

Making ISAPnP mandatory only because you build a driver which supports
ISAPnP hardware is not an option IMO. This would force people to build
ISAPnP support who don't even have an ISA bus (only because the driver for
their PCI card also supports an ISAPnP variant).

--Kai


