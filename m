Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932275AbWEXD2A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932275AbWEXD2A (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 May 2006 23:28:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932546AbWEXD2A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 May 2006 23:28:00 -0400
Received: from smtp.enter.net ([216.193.128.24]:13060 "EHLO smtp.enter.net")
	by vger.kernel.org with ESMTP id S932275AbWEXD17 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 May 2006 23:27:59 -0400
From: "D. Hazelton" <dhazelton@enter.net>
To: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: OpenGL-based framebuffer concepts
Date: Tue, 23 May 2006 23:27:49 +0000
User-Agent: KMail/1.8.1
Cc: Jon Smirl <jonsmirl@gmail.com>, Manu Abraham <abraham.manu@gmail.com>,
       linux cbon <linuxcbon@yahoo.fr>,
       Helge Hafting <helge.hafting@aitel.hist.no>, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org
References: <20060519224056.37429.qmail@web26611.mail.ukl.yahoo.com> <9e4733910605231017g146e16dfnd61eb22a72bd3f5f@mail.gmail.com> <6896241F-3389-4B20-9E42-3CCDDBFDD312@mac.com>
In-Reply-To: <6896241F-3389-4B20-9E42-3CCDDBFDD312@mac.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605232327.50468.dhazelton@enter.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 24 May 2006 00:10, Kyle Moffett wrote:
> On May 23, 2006, at 13:17:18, Jon Smirl wrote:
> >> By implementing a framework where userspace doesn't have to know -
> >> or care - about the hardware, which, IMNSHO, is the way things
> >> should be, then userspace applications can take advantage of such
> >> a system and be even more stable.
> >
> > A true monolithic design doesn't really work for video hardware. In
> > the monolithic model all devices in a class present a uniform API.
> > The better design for GPUs is the exo-kernel model. DRM already
> > uses the exo-kernel model. With exokernels each driver presents a
> > unique API and userspace libraries are used to provide a uniform API.
>
> The one really significant potential problem with the exo-kernel
> model for graphics is that the kernel *must* have a stable way to
> display kernel panics regardless of current video mode, framebuffer
> settings, 3D rendering, etc.  The kernel driver should be able to
> provide some fundamental operations for compositing text on top of
> the framebuffer at the primary viewport regardless of whatever
> changes userspace makes to the GPU configuration.  We don't have this
> now, but I see it as an absolute requirement for any replacement
> graphics system.  This means that the kernel driver should be able to
> understand and modify the entire GPU state to the extent necessary
> for such a text console.

For this it's not trivial, but seems to be, on the surface, rather easy to 
accomplish.

Since the driver is controlling all aspects of the system - memory and the 
like - and doing DMA to/from that memory for userspace accesses why not use 
one of the built-in framebuffer fonts and draw the panic directly to the 
video memory of the current screen?

Of course there are some times when this might not be possible - most notably 
during a display mode switch.  In that case I have no solutions, because when 
a Panic happens you have no guarantees about the state of the system.

Perhaps have the video-hardware re-initialized on a kexec after the panic and 
provide some way for the new kernel to display the panic information?

DRH
