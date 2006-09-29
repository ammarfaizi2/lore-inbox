Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932107AbWI2XcX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932107AbWI2XcX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 19:32:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932288AbWI2XcX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 19:32:23 -0400
Received: from ns2.suse.de ([195.135.220.15]:38362 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932107AbWI2XcW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 19:32:22 -0400
Date: Fri, 29 Sep 2006 16:32:09 -0700
From: Greg KH <greg@kroah.com>
To: Olaf Hering <olaf@aepfle.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 44/47] PCI: enable driver multi-threaded probe
Message-ID: <20060929233209.GC27431@kroah.com>
References: <1159249200793-git-send-email-greg@kroah.com> <11592492023883-git-send-email-greg@kroah.com> <11592492061208-git-send-email-greg@kroah.com> <1159249209773-git-send-email-greg@kroah.com> <11592492123695-git-send-email-greg@kroah.com> <11592492153066-git-send-email-greg@kroah.com> <11592492193773-git-send-email-greg@kroah.com> <11592492221573-git-send-email-greg@kroah.com> <1159249226922-git-send-email-greg@kroah.com> <20060927185124.GA9552@aepfle.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060927185124.GA9552@aepfle.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 27, 2006 at 08:51:24PM +0200, Olaf Hering wrote:
> On Mon, Sep 25, Greg KH wrote:
> 
> > Use at your own risk!!!
> 
> I havent debugged it, but it seems to reorder the driver probing, offb
> vs. nvidiafb (-bad, +good):
> 
> -Using unsupported 1024x768 NVDA,Display-A at 90020000, depth=8, pitch=1024
> -PCI: Unable to reserve mem region #2:10000000@90000000 for device 0000:0a:00.0
> -nvidiafb: cannot request PCI regions
> +nvidiafb: Device ID: 10de0141 
> +nvidiafb: CRTC0 analog found
> +nvidiafb: CRTC1 analog found
> +nvidiafb: Found OF EDID for head 1
> +nvidiafb: EDID found from BUS1
> +nvidiafb: EDID found from BUS2
> +nvidiafb: CRTC 0 appears to have a CRT attached
> +nvidiafb: Using CRT on CRTC 0
>  Console: switching to colour frame buffer device 128x48
> -fb0: Open Firmware frame buffer device on /pci@0,f0000000/NVDA,Parent@0/NVDA,Display-A@0
> +nvidiafb: PCI nVidia NV14 framebuffer (64MB @ 0x90000000)

Hm, is things just getting registered out of order, so the wrong video
device is used by the kernel?  Or by userspace?

thanks,

greg k-h
