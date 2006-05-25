Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965192AbWEYXbU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965192AbWEYXbU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 19:31:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965193AbWEYXbU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 19:31:20 -0400
Received: from wx-out-0102.google.com ([66.249.82.200]:10405 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S965192AbWEYXbU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 19:31:20 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=J0kvYLXXqF6BQjR142x/ioEYiDukDxs48/Cji8BnRhKj6JDuj+oSmzponZfaPxhcpWyrDr9IAAYIT+YgQc7rclUGYHg0EgciMIKuZzcDmNv29fRHggM/zvSWZfq3AHtuVkFVytUt52Op0sGtQ72+KOKFdOV0UQAY5Ldy7bPJ+7U=
Message-ID: <21d7e9970605251631v79b7990ag90d14a87a8089ee1@mail.gmail.com>
Date: Fri, 26 May 2006 09:31:19 +1000
From: "Dave Airlie" <airlied@gmail.com>
To: "Jeff Garzik" <jeff@garzik.org>
Subject: Re: OpenGL-based framebuffer concepts
Cc: "Jon Smirl" <jonsmirl@gmail.com>, "D. Hazelton" <dhazelton@enter.net>,
       "Alan Cox" <alan@lxorguk.ukuu.org.uk>,
       "Kyle Moffett" <mrmacman_g4@mac.com>,
       "Manu Abraham" <abraham.manu@gmail.com>,
       "linux cbon" <linuxcbon@yahoo.fr>,
       "Helge Hafting" <helge.hafting@aitel.hist.no>, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org
In-Reply-To: <44763AF9.6050104@garzik.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060519224056.37429.qmail@web26611.mail.ukl.yahoo.com>
	 <9e4733910605241656r6a88b5d3hda8c8a4e72edc193@mail.gmail.com>
	 <4475007F.7020403@garzik.org> <200605250237.20644.dhazelton@enter.net>
	 <44756E70.9020207@garzik.org>
	 <9e4733910605250704m68235d88lcd8eaedfda5e63cf@mail.gmail.com>
	 <4475C845.5000801@garzik.org>
	 <9e4733910605250837u59ad3881s75a0ed366fa2eefb@mail.gmail.com>
	 <21d7e9970605251604l409feddfycf004113def96574@mail.gmail.com>
	 <44763AF9.6050104@garzik.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > So far we have no memory management, and most of the plans I've seen
> > involved using a userspace system to do it, really we just want the
> > fbdev driver to be able to ask the DRM, so where the hell is the
> > frontbuffer, if the DRM is loaded and if it isn't just say I'm using
> > here.
>
> The kernel will need to do some amount of arbitration, some amount of
> scheduling between competing processes.  Doing a lot of that in
> userspace seems a bit questionable.

Oh it won't all be in userspace, but at the moment the setup component
is, so things like setting the memory pools up is, however the TG work
won't solve all the problems in the world, so we need to wait for the
big code drop and then decide what needs to be done.

>
> > And won't as long as you fight against it, we don't have to force X to
> > use it, we have to make it an option in X that distros turn on... we
> > have to let the X people keep doing their drivers the way they do
> > drivers... I'm still not convinced putting modesetting in kernel is at
> > all necessary, I think a simple MMIO parser to stop bad commands from
> > getting to the hardware is all we should need, modesetting normally
> > consists of a small number of operations.
> >
> > Write register,
> > Read register,
> > Wait for something to happen (vblank, bit set in a register X times..)
>
> Kernel needs to do suspend/resume, interrupt handling, DMA mapping, ...

Sorry I meant on top of those things, it was the modesetting I'm
suspect on, if we can "secure" modesetting I think we can leave it in
userspace.

>
> Further, whatever the Linux kernel chooses to do, the X server will follow.
>
> History has proven that it is COMPLETELY BROKEN to allow X to dictate
> these basic architectural decisions.  X11's ancient and broken PCI bus
> handling is a testament to this.  Tons of polling everywhere, rather
> than cleanly handling events in interrupts, is a further testament.
>
> If we do it right, X will follow.  As will FreeBSD and other OS's.

Exactly, Jon's problem is he tried to force X and X developers to bend
to his world view, he never realised that you don't need the X
developers to bend to your view of the world, you just present your
world view as being better and then more importantly you fix all the X
code to work with your code as well and still work in the abscence of
your code.

Dave.
