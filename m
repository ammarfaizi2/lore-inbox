Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267405AbUHTEyE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267405AbUHTEyE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 00:54:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267429AbUHTEyD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 00:54:03 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:56960 "EHLO midnight.ucw.cz")
	by vger.kernel.org with ESMTP id S267405AbUHTEx7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 00:53:59 -0400
Date: Fri, 20 Aug 2004 06:53:57 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Jon Smirl <jonsmirl@yahoo.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Jesse Barnes <jbarnes@engr.sgi.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Torrey Hoffman <thoffman@arnor.net>,
       lkml <linux-kernel@vger.kernel.org>,
       Alex Romosan <romosan@sycorax.lbl.gov>, Dave Airlie <airlied@linux.ie>
Subject: Re: legacy VGA device requirements (was: Exposing ROM's though sysfs)
Message-ID: <20040820045356.GA594@ucw.cz>
References: <1092497235.27144.10.camel@localhost.localdomain> <20040820044635.42969.qmail@web14925.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040820044635.42969.qmail@web14925.mail.yahoo.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 19, 2004 at 09:46:35PM -0700, Jon Smirl wrote:
> Attached is a real world reason why we need a VGA control device.
> VesaFB loads and marks the VGA screen region as reserved. The driver
> does not attach to any device.
> 
> My new radeon DRM driver load and says no one is using the radeon card,
> so it can drive it. Radeon loads and fails. It can attach the PCI
> device but it can't reserve the memory block.
> 
> The short term fix for this is to make VesaFB aware of the PCI ROM
> patch. The PCI ROM patch makes it possible to identify the boot video
> device. Once VesaFB can identify the boot video device it can properly
> attach itself to both the device and memory. Then DRM radeon loads
> after vesafb it will find the PCI device already has a driver attached
> and revert back into stealth compatibility mode.

Well, the stealth compatibility mode is even uglier than VesaFB not
claiming the PCI device, so I don't think it's really worth it for this
reason.

You can just as well enable the stealth mode if you can't get the
resources.

> Long term we need the vga control device and a unified DRM/fbdev.

We really need that. And we need it to be able to kick VESAfb out using
sysfs when it loads. For that you'll need to make VESAfb grab the VGA
PCI device.

> The immediate work around is to use the radeonfb driver instead of
> vesafb. The radeonfb driver marks the PCI device in use and triggers
> stealth mode in radeon.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
