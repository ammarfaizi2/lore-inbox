Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750995AbWI3GHP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750995AbWI3GHP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Sep 2006 02:07:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751057AbWI3GHO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Sep 2006 02:07:14 -0400
Received: from natblert.rzone.de ([81.169.145.181]:62688 "EHLO
	natblert.rzone.de") by vger.kernel.org with ESMTP id S1750995AbWI3GHN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Sep 2006 02:07:13 -0400
Date: Sat, 30 Sep 2006 08:07:08 +0200
From: Olaf Hering <olaf@aepfle.de>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 44/47] PCI: enable driver multi-threaded probe
Message-ID: <20060930060708.GA6352@aepfle.de>
References: <11592492023883-git-send-email-greg@kroah.com> <11592492061208-git-send-email-greg@kroah.com> <1159249209773-git-send-email-greg@kroah.com> <11592492123695-git-send-email-greg@kroah.com> <11592492153066-git-send-email-greg@kroah.com> <11592492193773-git-send-email-greg@kroah.com> <11592492221573-git-send-email-greg@kroah.com> <1159249226922-git-send-email-greg@kroah.com> <20060927185124.GA9552@aepfle.de> <20060929233209.GC27431@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20060929233209.GC27431@kroah.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 29, Greg KH wrote:

> On Wed, Sep 27, 2006 at 08:51:24PM +0200, Olaf Hering wrote:
> > On Mon, Sep 25, Greg KH wrote:
> > 
> > > Use at your own risk!!!
> > 
> > I havent debugged it, but it seems to reorder the driver probing, offb
> > vs. nvidiafb (-bad, +good):
> > 
> > -Using unsupported 1024x768 NVDA,Display-A at 90020000, depth=8, pitch=1024
> > -PCI: Unable to reserve mem region #2:10000000@90000000 for device 0000:0a:00.0
> > -nvidiafb: cannot request PCI regions
> > +nvidiafb: Device ID: 10de0141 
> > +nvidiafb: CRTC0 analog found
> > +nvidiafb: CRTC1 analog found
> > +nvidiafb: Found OF EDID for head 1
> > +nvidiafb: EDID found from BUS1
> > +nvidiafb: EDID found from BUS2
> > +nvidiafb: CRTC 0 appears to have a CRT attached
> > +nvidiafb: Using CRT on CRTC 0
> >  Console: switching to colour frame buffer device 128x48
> > -fb0: Open Firmware frame buffer device on /pci@0,f0000000/NVDA,Parent@0/NVDA,Display-A@0
> > +nvidiafb: PCI nVidia NV14 framebuffer (64MB @ 0x90000000)
> 
> Hm, is things just getting registered out of order, so the wrong video
> device is used by the kernel?  Or by userspace?

noidea, offb seems to get initialized before nvidiafb.
