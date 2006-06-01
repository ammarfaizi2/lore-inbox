Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030262AbWFAUEI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030262AbWFAUEI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 16:04:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030260AbWFAUEI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 16:04:08 -0400
Received: from smtp.enter.net ([216.193.128.24]:11269 "EHLO smtp.enter.net")
	by vger.kernel.org with ESMTP id S1030262AbWFAUEG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 16:04:06 -0400
From: "D. Hazelton" <dhazelton@enter.net>
To: David Lang <dlang@digitalinsight.com>
Subject: Re: OpenGL-based framebuffer concepts
Date: Thu, 1 Jun 2006 16:03:56 +0000
User-Agent: KMail/1.8.1
Cc: Jon Smirl <jonsmirl@gmail.com>, Ondrej Zajicek <santiago@mail.cz>,
       Dave Airlie <airlied@gmail.com>, Pavel Machek <pavel@ucw.cz>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Kyle Moffett <mrmacman_g4@mac.com>,
       Manu Abraham <abraham.manu@gmail.com>, linux cbon <linuxcbon@yahoo.fr>,
       Helge Hafting <helge.hafting@aitel.hist.no>, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org, adaplas@gmail.com
References: <20060519224056.37429.qmail@web26611.mail.ukl.yahoo.com> <9e4733910606010959o4f11d7cfp2d280c6f2019cccf@mail.gmail.com> <Pine.LNX.4.63.0606010758380.3827@qynat.qvtvafvgr.pbz>
In-Reply-To: <Pine.LNX.4.63.0606010758380.3827@qynat.qvtvafvgr.pbz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606011603.57421.dhazelton@enter.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 01 June 2006 14:59, David Lang wrote:
> On Thu, 1 Jun 2006, Jon Smirl wrote:
> > 1) The kernel subsystem should be agnostic of the display server. The
> > solution should not be X specific. Any display system should be able
> > to use it, SDL, Y Windows, Fresco, etc...

Stated goal of mine already.

> > 2) State inside the hardware is maintained by a single driver. No
> > hooks for state swapping (ie, save your state, now I'll load mine,
> > ...).

Thanks to Tony's input this has become a reachable goal. DRM will be the only 
system, save in those cases (like PPC) where fbdev is needed to provide a 
boot console. In those cases the fb driver will be removed when the DRM 
driver is ready to take over.

> > 3) A non-root user can control their graphics device.

Stated goal

> > 4) Multiple independent users should work

Stated goal

> > 5) The system needs to be robust. Daemons can be killed by the OOM
> > mechanism, you don't want to lose your console in the middle of trying
> > to fix a problem. This also means that you have to be able to display
> > printk's from inside interrupt handles.

Point of disagreement. Tons of userspace helpers isn't a good choice.

I don't know about doing a printk from inside interrupt context - the current 
architecture doesn't, IIRC, support printk from inside interrupt context for 
certain drivers for various reasons.

> > 6) Things like panics should be visible no matter what is running. No
> > more silent deaths.

Stated goal

> > 7) Obviously part of this is going to exist in user space since some
> > cards can only be controlled by VBIOS calls. Has anyone explored using
> > the in-kernel protected mode VESA hooks for this?

I'll look into this, though I suspect Tony will have the solution first.

> > 8) The user space fbdev API has to be maintained for legacy apps. DRM
> > can be changed if needed since there is only a single user of it, but
> > there is no obvious need to change it.

I was planning on having drmcon maintain a complete "compatability" API for 
the fb* device nodes. 

> > 9) there needs to be a way to control the mode on each head, merged fb
> > should also work. Monitor hotplug should work. Video card hot plug
> > should work. These should all work for console and the display
> > servers.

With drmcon this should be possible. I haven't finished working out the 
problems with the drmcon implementation yet (in other words: I'm still trying 
to figure out a decent method of giving the kernel the minimal DRI stuff 
it'll need to make drmcon a reality)

> > 10) Console support for complex scripts should get consideration.

If drmcon works then using FreeType or the X Font server for providing console 
fonts shouldn't be too hard.

> > 11) VGA is x86 specific. Solutions have to work on all architectures.
> > That implies that the code needed to get a basic console up needs to
> > fit on initramfs. Use PPC machines as an example.

After a lot of discussion with Dave and Tony about this we've decided that 
fbcon (for those systems that need it) will be the default boot display and 
DRM will take over and unload it when it's capable of taking over.

> > 12) If a driver system is loaded is has to inform the kernel of what
> > resources it is using.

This is one of my goals.

> 13) for hardware that supports it a text mode should be supported

This is a given :)

DRH
