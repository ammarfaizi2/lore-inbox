Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262851AbTJYVCU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Oct 2003 17:02:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262862AbTJYVCU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Oct 2003 17:02:20 -0400
Received: from web14913.mail.yahoo.com ([216.136.225.240]:50437 "HELO
	web14913.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262851AbTJYVCQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Oct 2003 17:02:16 -0400
Message-ID: <20031025210204.30378.qmail@web14913.mail.yahoo.com>
Date: Sat, 25 Oct 2003 14:02:04 -0700 (PDT)
From: Jon Smirl <jonsmirl@yahoo.com>
Subject: Re: [Dri-devel] Re: [Linux-fbdev-devel] DRM and pci_driver conversion
To: Linus Torvalds <torvalds@osdl.org>
Cc: Jon Smirl <jonsmirl@yahoo.com>, Eric Anholt <eta@lclark.edu>,
       kronos@kronoz.cjb.net,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-fbdev-devel@lists.sourceforge.net,
       dri-devel <dri-devel@lists.sourceforge.net>,
       Jeff Garzik <jgarzik@pobox.com>, Egbert Eich <eich@xfree86.org>
In-Reply-To: <Pine.LNX.4.44.0310251116140.4083-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- Linus Torvalds <torvalds@osdl.org> wrote:
> Quite frankly, I'd much rather see a low-level graphics driver that does
> _two_ things, and those things only:
> 
>  - basic hardware enumeration and setup (and no, "basic setup" does not
>    mean "mode switching": it literally means things like doing the 
>    pci_enable_device() stuff.
> 
>  - serialization and arbitrary command queuing from a _trusted_ party (ie
>    it could take command lists from the X server, but not from untrusted
>    clients). This part basically boils down to "DMA and interrupts". This 
>    is the part that allows others to wait for command completion, "enough 
>    space in the ring buffers" etc. But it does _not_ know or care what the 
>    commands are.
> 
> Then, fbcon and DRI and X could all three use these basics - and they'd be
> _so_ basic that the hardware layer could be really stable (unlike the DRI
> code that tends to have to upgrade for each new type of command that DRI
> adds - since it has to take care of untrusted clients. So DRI would
> basically use the low-level driver as a separate module, the way it
> already uses AGP).
> 

Linus, why don't you refuse updates from these projects until this is sorted
out? Your proposal is exactly what it needed. For a year now I have been poking
at these issues and making very little progress. I do know that all of the
pieces needed already exist; but without some incentive there is very little
reason to rearchitect the existing code. 

Personally I'm working on a standalone version of Mesa (OpenGL). This would
allow us to write a 3D hardware based windowing system in response to the ones
on the Mac and MS Longhorn. But instead of working on a windowing system I've
spent all of my time trying to help sort out the video device drivers.


=====
Jon Smirl
jonsmirl@yahoo.com

__________________________________
Do you Yahoo!?
Exclusive Video Premiere - Britney Spears
http://launch.yahoo.com/promos/britneyspears/
