Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965295AbWFAUry@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965295AbWFAUry (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 16:47:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965296AbWFAUry
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 16:47:54 -0400
Received: from smtp.enter.net ([216.193.128.24]:14597 "EHLO smtp.enter.net")
	by vger.kernel.org with ESMTP id S965295AbWFAUrx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 16:47:53 -0400
From: "D. Hazelton" <dhazelton@enter.net>
To: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: OpenGL-based framebuffer concepts
Date: Thu, 1 Jun 2006 16:47:42 +0000
User-Agent: KMail/1.8.1
Cc: "David Lang" <dlang@digitalinsight.com>,
       "Ondrej Zajicek" <santiago@mail.cz>, "Dave Airlie" <airlied@gmail.com>,
       "Pavel Machek" <pavel@ucw.cz>, "Alan Cox" <alan@lxorguk.ukuu.org.uk>,
       "Kyle Moffett" <mrmacman_g4@mac.com>,
       "Manu Abraham" <abraham.manu@gmail.com>,
       "linux cbon" <linuxcbon@yahoo.fr>,
       "Helge Hafting" <helge.hafting@aitel.hist.no>, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org, adaplas@gmail.com
References: <20060519224056.37429.qmail@web26611.mail.ukl.yahoo.com> <200606011603.57421.dhazelton@enter.net> <9e4733910606011335q5791997drc02d23f398a2acf5@mail.gmail.com>
In-Reply-To: <9e4733910606011335q5791997drc02d23f398a2acf5@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606011647.43427.dhazelton@enter.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 01 June 2006 20:35, Jon Smirl wrote:
> On 6/1/06, D. Hazelton <dhazelton@enter.net> wrote:
> > > > 5) The system needs to be robust. Daemons can be killed by the OOM
> > > > mechanism, you don't want to lose your console in the middle of
> > > > trying to fix a problem. This also means that you have to be able to
> > > > display printk's from inside interrupt handles.
> >
> > Point of disagreement. Tons of userspace helpers isn't a good choice.
>
> Where do you get 'tons'? There will probably be one for initial reset,
> one for VESA based mode setting and a few more if there is device
> specific code needed for a specific card.
>
> Making console rely on a permanent daemon that is subject to getting
> killed by the OOM mechanism is not a workable solution.
>
> You also need to think about how cursors are handled. A non-root app
> needs to be able to move the cursor. Actually moving the cursor
> requires root. The in-kernel console system needs a cursor. It would
> be much better if cursor control was implemented in the device
> drivers.

Yes, the basic console will only require a few helpers. I get "tons" because 
that's what it would take to provide all the acceleration features to 
userspace. The daemon is *only* there to provide those acceleration features. 
The kernel itself has it's own minimal interface to drmcon that lets it work 
without userspace. The userspace side is for userspace. (Though the kernel 
will only work in a specific set mode without the userspace helpers for 
setting the mode)

Cursor control will be entirely within the driver :)

> > I don't know about doing a printk from inside interrupt context - the
> > current architecture doesn't, IIRC, support printk from inside interrupt
> > context for certain drivers for various reasons.
>
> Printk works from inside interrupt handlers currently. This is an
> absolute requirement for kernel debugging that can't be removed.
> Because of this requirement there has to be a way for all drivers to
> draw the console entirely inside the kernel. You can not make calls to
> user space from inside interrupt handlers.

Hrm... I was thinking that it didn't work for sending to net and serial 
consoles because doing such might generate an interrupt.

> > > > 6) Things like panics should be visible no matter what is running. No
> > > > more silent deaths.
>
> Panics can occur inside interrupt handlers. You can't queue up printks
> in this context and they display them later, the kernel just died,
> there is no later.

Of course. It is one of my goals to keep those silent deaths from occuring. 
AAMOF, that was one of my reasons for this project.

DRH
