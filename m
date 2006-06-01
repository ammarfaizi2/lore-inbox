Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751000AbWFBCWQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751000AbWFBCWQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 22:22:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751138AbWFBCWQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 22:22:16 -0400
Received: from smtp.enter.net ([216.193.128.24]:24583 "EHLO smtp.enter.net")
	by vger.kernel.org with ESMTP id S1751000AbWFBCWP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 22:22:15 -0400
From: "D. Hazelton" <dhazelton@enter.net>
To: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: OpenGL-based framebuffer concepts
Date: Thu, 1 Jun 2006 22:22:05 +0000
User-Agent: KMail/1.8.1
Cc: "David Lang" <dlang@digitalinsight.com>,
       "Ondrej Zajicek" <santiago@mail.cz>, "Dave Airlie" <airlied@gmail.com>,
       "Pavel Machek" <pavel@ucw.cz>, "Alan Cox" <alan@lxorguk.ukuu.org.uk>,
       "Kyle Moffett" <mrmacman_g4@mac.com>,
       "Manu Abraham" <abraham.manu@gmail.com>,
       "linux cbon" <linuxcbon@yahoo.fr>,
       "Helge Hafting" <helge.hafting@aitel.hist.no>, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org, adaplas@gmail.com
References: <20060519224056.37429.qmail@web26611.mail.ukl.yahoo.com> <200606011647.43427.dhazelton@enter.net> <9e4733910606011421o4334642bh11dd568b3399fcc2@mail.gmail.com>
In-Reply-To: <9e4733910606011421o4334642bh11dd568b3399fcc2@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606012222.06540.dhazelton@enter.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> One solution to this split is to build the system management console
> in-kernel using the existing fbdev code. A hot key can be used to
> access it or it will appear automatically on a panic. The system
> management console does not need acceleration, but it always has to
> work and work in any context (like interrupt context). Working in any
> context forces an implementation that is entirely contained in the
> kernel.

And what happens if that console data has been damaged by a wild pointer write 
in kernel?

This does have a practicle use, and the console data for the "System Console" 
is unlikely to get screwed with. I am just pointing out that there are 
problems even with your suggestions. I had already planned on something 
similar to this when I began working on a method to have the video drivers 
able to be added and removed at runtime. What I was planning on was using 
vgacon (for those systems that support it) as the system console and having 
tthe system default back to that should *anything* go wrong in the kernel. 
For the systems that don't support vgacon there is going to be a very minimal 
fbcon that will serve the same purpose.

Userspace helpers for modesetting and other simple tasks is no problem. When 
it comes to handling the acceleration, the DRI part  of the DRM 
infrastructure (the Userspace side of it, in other words) needs to be running 
and available. This is why X has to load the module. Providing that to 
userspace then become a concern, and the easiest way to do this is to have 
the DRI portion loaded and running inside a userspace daemon, either pinned 
into memory so that the OOM killer can't touch it, or running as a special 
process under init that will *always* get restarted if it dies.

Using a mass of userspace helpers, or requiring the applications to provide 
and load their own userspace drivers for the DRM/DRI system is, IMHO, not an 
option.

DRH
