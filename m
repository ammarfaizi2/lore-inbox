Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279418AbRKMVmF>; Tue, 13 Nov 2001 16:42:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279412AbRKMVl4>; Tue, 13 Nov 2001 16:41:56 -0500
Received: from sushi.toad.net ([162.33.130.105]:8930 "EHLO sushi.toad.net")
	by vger.kernel.org with ESMTP id <S279382AbRKMVlm>;
	Tue, 13 Nov 2001 16:41:42 -0500
Subject: Re: [PATCH] parport_pc to use pnpbios_register_driver()
From: Thomas Hood <jdthood@mail.com>
To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Cc: Keith Owens <kaos@ocs.com.au>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0111120921110.16450-100000@chaos.tp1.ruhr-uni-bochum.de>
In-Reply-To: <Pine.LNX.4.33.0111120921110.16450-100000@chaos.tp1.ruhr-uni-bochum.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.99.0 (Preview Release)
Date: 13 Nov 2001 16:41:46 -0500
Message-Id: <1005687707.21561.14.camel@thanatos>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2001-11-12 at 03:30, Kai Germaschewski wrote:
> On Mon, 12 Nov 2001, Keith Owens wrote:
> > Does this combination make sense?  If you are building a pnpbios driver
> > into the kernel then the configuration should force pnpbios support to
> > be built in as well.  We don't allow this combination for things like
> > scsi or ide, they require the common support to be built in if any
> > drivers are built in.  IMHO this problem should be fixed in .config,
> > not in driver source.
> 
> The affected drivers usually support different interfaces to the hardware, 
> like ISA, ISAPnP, PCI, so it makes sense to build them w/o ISAPnP support.

True.

> For instance, people may want to have built-in serial support (w/o ISAPnP 
> support is fine, because they've only got a standard SuperI/O chip), but 
> also modular isapnp and sound driver support, so they can demand load 
> sound support if necessary.

Fine.

> Making ISAPnP mandatory only because you build a driver which supports
> ISAPnP hardware is not an option IMO. This would force people to build
> ISAPnP support who don't even have an ISA bus (only because the driver for
> their PCI card also supports an ISAPnP variant).

You misunderstand.  Obviously we don't want to force anyone
to build in isa-pnp or pnpbios support.  What Keith is saying
is that IF isa-pnp code is enabled in a driver then the isa-pnp
driver should also be built.  Furthermore if isa-pnp code is
enabled in an _integral_ (i.e., non-modular) driver, then the
isa-pnp driver should also be built integrally.  The combination
of integral-driver-with-isa-pnp-support-enabled and modular
isa-pnp driver should be disallowed by the configurator.

Thomas

