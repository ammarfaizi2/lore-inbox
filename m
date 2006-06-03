Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932316AbWFCGio@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932316AbWFCGio (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jun 2006 02:38:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932573AbWFCGio
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jun 2006 02:38:44 -0400
Received: from smtp.enter.net ([216.193.128.24]:15114 "EHLO smtp.enter.net")
	by vger.kernel.org with ESMTP id S932316AbWFCGin (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jun 2006 02:38:43 -0400
From: "D. Hazelton" <dhazelton@enter.net>
To: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: OpenGL-based framebuffer concepts
Date: Sat, 3 Jun 2006 02:38:30 +0000
User-Agent: KMail/1.8.1
Cc: "Kyle Moffett" <mrmacman_g4@mac.com>, "Dave Airlie" <airlied@gmail.com>,
       "Ondrej Zajicek" <santiago@mail.cz>, "Pavel Machek" <pavel@ucw.cz>,
       "Alan Cox" <alan@lxorguk.ukuu.org.uk>,
       "Manu Abraham" <abraham.manu@gmail.com>,
       "linux cbon" <linuxcbon@yahoo.fr>,
       "Helge Hafting" <helge.hafting@aitel.hist.no>, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org, adaplas@gmail.com
References: <20060519224056.37429.qmail@web26611.mail.ukl.yahoo.com> <200606030209.34928.dhazelton@enter.net> <9e4733910606022331u40f1fd5dq6428e37f30ccf702@mail.gmail.com>
In-Reply-To: <9e4733910606022331u40f1fd5dq6428e37f30ccf702@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606030238.32720.dhazelton@enter.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 03 June 2006 06:31, Jon Smirl wrote:
> On 6/2/06, D. Hazelton <dhazelton@enter.net> wrote:
> > Actually, Jon, Dave is thinking like I am in that the DRI drivers needs
> > to be loaded for use. Rather than forcing applications to include all
> > that code the userspace daemon can be configured to load the DRI driver
> > and provides the userspace interface to the system. Using a daemon for a
> > simple task, like modesetting, is idiotic - but using the daemon to
> > provide userspace with full access to acceleration (the Kernel drivers
> > only provide the backend for the acceleration. The userspace side
> > actually provides the code that manages it all) without needing to have
> > to worry about loading and initializing the dri drivers provides a method
> > for anything from a scripting language to a full compiled application
> > easy access to the acceleration.
>
> You are confused about this. Nobody wants to change the way DRI and
> DRM work, it would take years of effort to change it. These are shared
> libraries, it doesn't matter how many people have them open, there is
> only one copy in memory.

Exactly.

> Applications don't 'include' all of the DRI/DRM code they dynamically
> link to the OpenGL shared object library which in turns loads the
> correct DRI shared library. The correct DRM module should be loaded by
> the kernel at boot. You can write a 10 line OpenGL program that will
> make use of all of this, it is not hard to do. User space has always
> had access to hardware acceleration from these libraries.

Yes, but there are userspace *drivers* that have to be loaded for that code to 
work properly. By providing the daemon no program needs to worry about 
loading those drivers.

> We have not been discussing DIrect Rendering vs indirect (AIGLX). It
> will be up to the windowing system to chose which (or both) of those
> model to use. The lower layers are designed not to force that choice
> one way ot the other.
>
> Dave wants to load the existing X drivers into the daemon, not the DRI
> libraries. Other than using them for mode setting there isn't much use
> for them. I have asked him where he wants things like blanking, cmap,
> cursor and he hasn't said yet. Those functions are tiny, ~100 lines of
> code.

Stuff like that would probably be best left to small userspace helpers, or 
potentially 1 userspace helper that figures out what to do based on what the 
name is that's given to the link.

DRH
