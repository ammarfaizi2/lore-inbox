Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262721AbTIQKnI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Sep 2003 06:43:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262723AbTIQKnI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Sep 2003 06:43:08 -0400
Received: from users.linvision.com ([62.58.92.114]:12428 "EHLO
	abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
	id S262721AbTIQKnD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Sep 2003 06:43:03 -0400
Date: Wed, 17 Sep 2003 12:42:30 +0200
From: Rogier Wolff <R.E.Wolff@BitWizard.nl>
To: Jens Axboe <axboe@suse.de>
Cc: Rogier Wolff <R.E.Wolff@BitWizard.nl>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Stephan von Krawczynski <skraw@ithnet.com>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>,
       neilb@cse.unsw.edu.au,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: experiences beyond 4 GB RAM with 2.4.22
Message-ID: <20030917124230.A24506@bitwizard.nl>
References: <20030916102113.0f00d7e9.skraw@ithnet.com> <Pine.LNX.4.44.0309161009460.1636-100000@logos.cnet> <20030916153658.3081af6c.skraw@ithnet.com> <1063722973.10037.65.camel@dhcp23.swansea.linux.org.uk> <20030917084102.A19276@bitwizard.nl> <20030917102629.GL906@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030917102629.GL906@suse.de>
User-Agent: Mutt/1.3.22.1i
Organization: BitWizard.nl
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 17, 2003 at 12:26:29PM +0200, Jens Axboe wrote:
> On Wed, Sep 17 2003, Rogier Wolff wrote:
> > On Tue, Sep 16, 2003 at 03:36:14PM +0100, Alan Cox wrote:
> > > I/O is a real pain. Also in some cases it might be interesting to try
> > > using the extra RAM above the 4G boundary as a giant ram disk and using
> > > it as first swap device.
> > 
> > 4G? Above 4G? The limit should be configurable a lot earlier. 
> > 
> > I'd want to configure that on the machines I'm installing tomorrow. 
> > 4G RAM, but I'd rather not use the highmem stuff. I think the workload
> > that this machine is likely to get will work very well with this setup. 
> > 
> > Why does this have the opportunity to work better than just using the 
> > 2 or 4G of RAM? Because after you've used the bottom 1G, that might 
> > just remain there, requiring lots of IO to go through bounce buffers
> > and memory remappings. By considering the top part of RAM as swap,
        ^^^^^^^^^^^^^^^^^
> > you'll force the important stuff into the more easily accessable
> > RAM (Compare to fastram as it was called on the Amiga!). 
> 
> You are misunderstanding the problem. You don't use bounce buffers just
> because the page happens to reside in high memory, it is only used if
> the hardware cannot DMA to it. And that is exactly the problem here with
> the 3ware adapter, it cannot dma to > 4GB. So in a 6GB setup (with
> potentially 5G of highmem), only the last 2G requires bouncing.

As I understand things (But this is from following discussions on
linux-kernel from afar, not from personal poking at the code!) there
is also a performance penalty for the kernel not having direct
physically mapped access to RAM. We map up to 3G of virtual memory of
userspace, and up to 1Gb of physical RAM into the kernel memory map
for performance reasons. So if I have 2G RAM and want to keep 3G
userspace, I have to use some "highmem" stuff right? 

This will not directly require the use of bounce buffers, but it will
require the kernel to remap regions when it needs to access them.

If this doesn't have a performance impact, why do I have the option of
directly mapping 1G, 2G, or 3G?

			Roger. 

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2600998 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
**** "Linux is like a wigwam -  no windows, no gates, apache inside!" ****
