Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965179AbWEYXR1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965179AbWEYXR1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 19:17:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965178AbWEYXR1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 19:17:27 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:40888 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S965170AbWEYXR0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 19:17:26 -0400
Message-ID: <44763AF9.6050104@garzik.org>
Date: Thu, 25 May 2006 19:17:13 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Dave Airlie <airlied@gmail.com>
CC: Jon Smirl <jonsmirl@gmail.com>, "D. Hazelton" <dhazelton@enter.net>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Kyle Moffett <mrmacman_g4@mac.com>,
       Manu Abraham <abraham.manu@gmail.com>, linux cbon <linuxcbon@yahoo.fr>,
       Helge Hafting <helge.hafting@aitel.hist.no>, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org
Subject: Re: OpenGL-based framebuffer concepts
References: <20060519224056.37429.qmail@web26611.mail.ukl.yahoo.com>	 <9e4733910605241656r6a88b5d3hda8c8a4e72edc193@mail.gmail.com>	 <4475007F.7020403@garzik.org> <200605250237.20644.dhazelton@enter.net>	 <44756E70.9020207@garzik.org>	 <9e4733910605250704m68235d88lcd8eaedfda5e63cf@mail.gmail.com>	 <4475C845.5000801@garzik.org>	 <9e4733910605250837u59ad3881s75a0ed366fa2eefb@mail.gmail.com> <21d7e9970605251604l409feddfycf004113def96574@mail.gmail.com>
In-Reply-To: <21d7e9970605251604l409feddfycf004113def96574@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.2 (----)
X-Spam-Report: SpamAssassin version 3.1.1 on srv5.dvmed.net summary:
	Content analysis details:   (-4.2 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Airlie wrote:
> So far we have no memory management, and most of the plans I've seen
> involved using a userspace system to do it, really we just want the
> fbdev driver to be able to ask the DRM, so where the hell is the
> frontbuffer, if the DRM is loaded and if it isn't just say I'm using
> here.

The kernel will need to do some amount of arbitration, some amount of 
scheduling between competing processes.  Doing a lot of that in 
userspace seems a bit questionable.


> And won't as long as you fight against it, we don't have to force X to
> use it, we have to make it an option in X that distros turn on... we
> have to let the X people keep doing their drivers the way they do
> drivers... I'm still not convinced putting modesetting in kernel is at
> all necessary, I think a simple MMIO parser to stop bad commands from
> getting to the hardware is all we should need, modesetting normally
> consists of a small number of operations.
> 
> Write register,
> Read register,
> Wait for something to happen (vblank, bit set in a register X times..)

Kernel needs to do suspend/resume, interrupt handling, DMA mapping, ...

Further, whatever the Linux kernel chooses to do, the X server will follow.

History has proven that it is COMPLETELY BROKEN to allow X to dictate 
these basic architectural decisions.  X11's ancient and broken PCI bus 
handling is a testament to this.  Tons of polling everywhere, rather 
than cleanly handling events in interrupts, is a further testament.

If we do it right, X will follow.  As will FreeBSD and other OS's.

	Jeff


