Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751558AbWFCGJp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751558AbWFCGJp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jun 2006 02:09:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751559AbWFCGJp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jun 2006 02:09:45 -0400
Received: from smtp.enter.net ([216.193.128.24]:25608 "EHLO smtp.enter.net")
	by vger.kernel.org with ESMTP id S1751556AbWFCGJo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jun 2006 02:09:44 -0400
From: "D. Hazelton" <dhazelton@enter.net>
To: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: OpenGL-based framebuffer concepts
Date: Sat, 3 Jun 2006 02:09:33 +0000
User-Agent: KMail/1.8.1
Cc: "Kyle Moffett" <mrmacman_g4@mac.com>, "Dave Airlie" <airlied@gmail.com>,
       "Ondrej Zajicek" <santiago@mail.cz>, "Pavel Machek" <pavel@ucw.cz>,
       "Alan Cox" <alan@lxorguk.ukuu.org.uk>,
       "Manu Abraham" <abraham.manu@gmail.com>,
       "linux cbon" <linuxcbon@yahoo.fr>,
       "Helge Hafting" <helge.hafting@aitel.hist.no>, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org, adaplas@gmail.com
References: <20060519224056.37429.qmail@web26611.mail.ukl.yahoo.com> <200606030125.20907.dhazelton@enter.net> <9e4733910606022255r7fa7346bw661fb35f81668788@mail.gmail.com>
In-Reply-To: <9e4733910606022255r7fa7346bw661fb35f81668788@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606030209.34928.dhazelton@enter.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 03 June 2006 05:55, Jon Smirl wrote:
> On 6/2/06, D. Hazelton <dhazelton@enter.net> wrote:
> > The reason Jon is so hot on having direct access like that is he feels
> > that modesetting and a few other simple tasks should be handled by
> > helpers and acceleration itself should be handled by userspace libraries,
> > without the drm daemon at all.
>
> Jon thinks all of the HW level acceleration should be handled in the
> DRM device drivers where it already exists. The acceleration code in
> fbdev and XAA/EXA needs to die. DRM is the only choice since it is
> possible to eliminate the other two and it is not possible to
> eliminate DRM. Dave is in agreement with this design.
>
> I think you are mixing up my comments about DRI vs DRM. DRI is the
> user space acceleration code but it doesn't actually touch the
> hardware. DRM actually touches it. I have never wanted user space
> acceleration code for the low level hardware access.
>
> Dave and I are only in disagreement on how to handle mode setting. In
> his model there is a mode setting daemon that has a socket interface.
> The libraries implementing xlib/OpenGL then talk to both this socket
> and to the DRM device.
>
> My desire is to have a single point of interface, DRM. Since mode
> setting is not done very often I would use call_userhelper from the
> DRM device driver to invoke it when necessary. To set a mode you IOCTL
> DRM, which then bounces to a transient user space app.
>
> Neither model forces mode setting exclusively into user space or the
> kernel, each driver can chose to put it where ever is more efficient.
> By initially reusing the existing X drivers it will probably all end
> up in user space but people may rewrite that over time.
>
> Two other things that probably have to go into user space are initial
> reset and attached device (monitors) discovery.

Actually, Jon, Dave is thinking like I am in that the DRI drivers needs to be 
loaded for use. Rather than forcing applications to include all that code the 
userspace daemon can be configured to load the DRI driver and provides the 
userspace interface to the system. Using a daemon for a simple task, like 
modesetting, is idiotic - but using the daemon to provide userspace with full 
access to acceleration (the Kernel drivers only provide the backend for the 
acceleration. The userspace side actually provides the code that manages it 
all) without needing to have to worry about loading and initializing the dri 
drivers provides a method for anything from a scripting language to a full 
compiled application easy access to the acceleration.

DRH
