Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267194AbUHDCRu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267194AbUHDCRu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Aug 2004 22:17:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264917AbUHDCRu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Aug 2004 22:17:50 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:35757 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S267194AbUHDCRs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Aug 2004 22:17:48 -0400
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Exposing ROM's though sysfs
Date: Tue, 3 Aug 2004 19:16:01 -0700
User-Agent: KMail/1.6.2
Cc: Jon Smirl <jonsmirl@yahoo.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Vojtech Pavlik <vojtech@suse.cz>, Torrey Hoffman <thoffman@arnor.net>,
       lkml <linux-kernel@vger.kernel.org>
References: <20040804013745.7323.qmail@web14927.mail.yahoo.com> <1091584635.1922.72.camel@gaston>
In-Reply-To: <1091584635.1922.72.camel@gaston>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200408031916.01593.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, August 3, 2004 6:57 pm, Benjamin Herrenschmidt wrote:
> Jesse did a pretty good summary of what features need to be provided
> though. Note also that this "arbitration" layer may also need an in-kernel
> API for things like vgacon or whatever may want to "grab" access to the
> VGA device.

Good point, I forgot about that.  Theoretically, as long as a device has been 
POSTed, vgacon should work just fine with some small tweaks on platforms that 
allow mapping of the VGA framebuffer.

> I suggest that at this point, we don't try to bother with simultaneous
> access to devices on separate PCI domains, but just use an in-kernel
> semaphore to arbitrate the single user at a given point in time who "owns"
> the VGA access, whatever bus it is on. So we need 2 things, both in-kernel
> and for userland:

Sounds good.  Cards usually POST pretty quickly, so that won't be a problem 
until someone puts 32 cards in a system (oh wait, that's not too far off :).

>  - A way to identify a VGA device on a given bus. Could this be a PCI
> ID (or in kernel a pci_dev ?). That would mean no support for non-PCI
> stuffs, how bad would that be ?

I personally don't care about anything but PCI, AGP and PCI-Express, but you 
make a good point about embedded stuff.

>  - Userland should use read/write for IOs imho, either to a /dev device
> (with maybe an ioctl to switch between PIO and VGA mem, though mmap is
> better for the later) or to some sysfs entry (in which case, can we add
> mmap call to a sysfs attribute ? last time I looked, it wasn't simple).

Yeah, that sounds reasonable.  I'd vote for a real device as opposed to sysfs 
files, for now at least.

Jesse
