Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270130AbTGSOdj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jul 2003 10:33:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270205AbTGSOdi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jul 2003 10:33:38 -0400
Received: from d40.sstar.com ([209.205.179.40]:7420 "EHLO scud.asjohnson.com")
	by vger.kernel.org with ESMTP id S270130AbTGSOdh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jul 2003 10:33:37 -0400
From: "Andrew S. Johnson" <andy@asjohnson.com>
To: Rahul Karnik <rahul@genebrew.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: DRM, radeon, and X 4.3
Date: Sat, 19 Jul 2003 09:48:27 -0500
User-Agent: KMail/1.5.1
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200307170539.25702.andy@asjohnson.com> <1058532934.19558.31.camel@dhcp22.swansea.linux.org.uk> <3F17FF5B.2040409@genebrew.com>
In-Reply-To: <3F17FF5B.2040409@genebrew.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200307190948.27132.andy@asjohnson.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 18 July 2003 09:08 am, Rahul Karnik wrote:
> Alan Cox wrote:
> > On Iau, 2003-07-17 at 18:26, Dave Jones wrote:
> > 
> >> > Linux agpgart interface v0.100 (c) Dave Jones
> >> > [drm] Initialized radeon 1.9.0 20020828 on minor 0
> >> > [drm:radeon_cp_init] *ERROR* radeon_cp_init called without lock held
> >> > [drm:radeon_unlock] *ERROR* Process 1929 using kernel context 0
> >> > 
> >> > There is something X doesn't like.  How do I fix this?
> >>
> >>Looks like there isn't an agp chipset module also loaded
> >>(via-agp.o, intel-agp.o etc...)
> > 
> > 
> > Still shouldnt do that - also the radeon doesn't require AGP

The radeon module shouldn't require agpgart, as it is supposed
to work with pcigart for PCI versions, but for DRI to work some sort of
hardware module(s) need to be loaded.

> FWIW, I can reproduce the "problem" here. Perhaps a less cryptic error 
> message could be printked.
> 
> Thanks,
> Rahul

I added the modprobe for via-agp to this line in modprobe.conf:

install radeon { /sbin/modprobe agpgart; /sbin/modprobe/via-agp; }; /sbin/modprobe --ignore-install radeon

which works well enough.  However, this line only removes the
radeon module:

remove radeon /sbin/modprobe -r --ignore-remove radeon && { /sbin/modprobe -r via-agp; /sbin/modprobe -r agpgart; /bin/true; }

Even after the radeon module is unloaded, the via-agp module
won't unload because it claims to be in use.  I have to force
unload it.  What could it be hanging on?

Thanks,

Andy Johnson


