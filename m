Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267540AbUJRUSa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267540AbUJRUSa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Oct 2004 16:18:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267709AbUJRUS3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Oct 2004 16:18:29 -0400
Received: from hermine.aitel.hist.no ([158.38.50.15]:30993 "HELO
	hermine.aitel.hist.no") by vger.kernel.org with SMTP
	id S267540AbUJRUQE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Oct 2004 16:16:04 -0400
Date: Mon, 18 Oct 2004 22:21:47 +0200
To: Gerd Knorr <kraxel@bytesex.org>
Cc: linux-fbdev-devel@lists.sourceforge.net,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       penguinppc-team@lists.penguinppc.org
Subject: Re: [Linux-fbdev-devel] Generic VESA framebuffer driver and Video card BOOT?
Message-ID: <20041018202147.GA28720@hh.idb.hist.no>
References: <416E6ADC.3007.294DF20D@localhost> <87d5zkqj8h.fsf@bytesex.org> <Pine.GSO.4.61.0410151437050.10040@waterleaf.sonytel.be> <87y8i8p1jq.fsf@bytesex.org> <20041017120728.GC10532@admingilde.org> <20041018083632.GE3065@bytesex> <20041018113929.GB3618@admingilde.org> <20041018121033.GB5106@bytesex>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041018121033.GB5106@bytesex>
User-Agent: Mutt/1.5.6+20040722i
From: Helge Hafting <helgehaf@aitel.hist.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 18, 2004 at 02:10:33PM +0200, Gerd Knorr wrote:
> On Mon, Oct 18, 2004 at 01:39:29PM +0200, Martin Waitz wrote:
> > hi :)
> > 
> > > Whenever writing to the gfx memory before finishing the initialization
> > > is harmless or not probably depends on the hardware, I'd better not
> > > count on it ...
> > 
> > when the application tries to access the framebuffer memory then
> > the driver is asked to map the corresponding page.
> 
> On first access only, and even that only if the driver doesn't map the
> pages at mmap() time already.  Not a single fb driver seems to map the
> pages lazy today, grepping in drivers/video for nopage handles shows
> nothing.  I'm not sure you can actually do that for iomem mappings.
> 
Isn't it possible for the driver to unmap the mapping when
suspending?  Then you're guaranteed to get that first access.

This can be simplified to a all-or-nothing approach, it is not
necessary to fault the pages in individually.

Helge Hafting
