Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932114AbWE3C5j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932114AbWE3C5j (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 22:57:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932131AbWE3C5j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 22:57:39 -0400
Received: from smtp.enter.net ([216.193.128.24]:52242 "EHLO smtp.enter.net")
	by vger.kernel.org with ESMTP id S932114AbWE3C5j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 22:57:39 -0400
From: "D. Hazelton" <dhazelton@enter.net>
To: Jeff Garzik <jeff@garzik.org>
Subject: Re: OpenGL-based framebuffer concepts
Date: Mon, 29 May 2006 22:57:28 +0000
User-Agent: KMail/1.8.1
Cc: Pavel Machek <pavel@ucw.cz>, Dave Airlie <airlied@gmail.com>,
       Jon Smirl <jonsmirl@gmail.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Kyle Moffett <mrmacman_g4@mac.com>,
       Manu Abraham <abraham.manu@gmail.com>, linux cbon <linuxcbon@yahoo.fr>,
       Helge Hafting <helge.hafting@aitel.hist.no>, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org
References: <20060519224056.37429.qmail@web26611.mail.ukl.yahoo.com> <20060529124840.GD746@elf.ucw.cz> <447B666F.5080109@garzik.org>
In-Reply-To: <447B666F.5080109@garzik.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605292257.29462.dhazelton@enter.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 29 May 2006 21:23, Jeff Garzik wrote:
> Pavel Machek wrote:
> > These are very reasonable rules... but still, I think we need to move
> > away from vgacon/vesafb. We need proper hardware drivers for our
> > hardware.
>
> I agree we need proper drivers, but moving away from vesafb will be
> tough... moving away from vgacon is likely impossible for many many
> years yet.

After my rant last night I spent some time thinking... Thanks to a private 
message from Dave Arlie today the conclusion I came to proved correct.

The model I was working towards, where there is a low-level mediation layer 
for the video-hardware is what is needed. The argument was over where to 
start, and I started at the wrong end.

> Once proper hardware drivers exist, you will still need to support
> booting into a situation where you probably need video before a driver
> can be loaded -- e.g. distro installers.  Server owners will likely
> prefer vgacon over a huge video driver they will never use for anything
> but text mode console.

vgacon will likely never be removed from the kernel. If the direction Dave has 
told me things should go in works, vgacon will be needed for distro 
installers, servers and early boot. The fbdev system itself will survive for 
those servers where people want it and for the embedded people that depend on 
it. WHat is likely to change is the common user...

I'm making an assumption here based on several statements Dave made in a 
private e-mail to me, but the direction things would likely go for "normal" 
users is that the DRM system will be used for everything. If this is the 
case, then the likely best solution for all kernel errors would be 
transferring control of the primary display and input devices to vgacon and 
switching to it's preferred mode. Done properly the driver state (at an oops) 
could be stored and then restored after the user acknowledges the error 
(unless the user has configured the system not to wait on a recoveable 
error).

Before I can restart my work at trying to move the kernel graphics system 
forward, I would like to apologize to people for my behaviour.

DRH
