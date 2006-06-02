Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751345AbWFBJGh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751345AbWFBJGh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 05:06:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751346AbWFBJGh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 05:06:37 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:6558 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751345AbWFBJGg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 05:06:36 -0400
Date: Fri, 2 Jun 2006 11:05:40 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Dave Airlie <airlied@gmail.com>, "D. Hazelton" <dhazelton@enter.net>,
       David Lang <dlang@digitalinsight.com>,
       Ondrej Zajicek <santiago@mail.cz>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Kyle Moffett <mrmacman_g4@mac.com>,
       Manu Abraham <abraham.manu@gmail.com>, linux cbon <linuxcbon@yahoo.fr>,
       Helge Hafting <helge.hafting@aitel.hist.no>, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org, adaplas@gmail.com
Subject: Re: OpenGL-based framebuffer concepts
Message-ID: <20060602090540.GD25806@elf.ucw.cz>
References: <20060519224056.37429.qmail@web26611.mail.ukl.yahoo.com> <9e4733910606010959o4f11d7cfp2d280c6f2019cccf@mail.gmail.com> <Pine.LNX.4.63.0606010758380.3827@qynat.qvtvafvgr.pbz> <200606011603.57421.dhazelton@enter.net> <9e4733910606011335q5791997drc02d23f398a2acf5@mail.gmail.com> <21d7e9970606011614x5b4d3a3t9608971a714f8c77@mail.gmail.com> <9e4733910606011638s587fff33lbfe46f6a2817245b@mail.gmail.com> <21d7e9970606011647l11a780d3h816fee2cc01e72a9@mail.gmail.com> <9e4733910606011745n7277ca57vf8d32dfed9da2c4e@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9e4733910606011745n7277ca57vf8d32dfed9da2c4e@mail.gmail.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Čt 01-06-06 20:45:20, Jon Smirl wrote:
> On 6/1/06, Dave Airlie <airlied@gmail.com> wrote:
> >We can stop the OOM killer from killing the daemon if necessary.
> >running device drivers in userspace would sort of require this, we can
> >run the daemon from init and if it dies, have it respawn, it could put
> >persistent info in a shared memory segment provided by the DRM, just
> >because you can't think of any way around things, doesn't mean the
> >rest of us can't..
> >
> >a /dev/ with permissions is no more or less useful than a
> >/tmp/.grphs_socket1 and 2
> >with permissions,
> 
> /dev/devices have a standard system design in the kernel with h files
> and ioctls. Why create a new communication protocol when a standard
> one exists? How is a printk generated in the kernel going to find this
> socket and get the printk message into it?
> 
> You have a panic in an interrupt handler. User space is messed up
> because of wild pointer writes in the kernel. Your display process has
> been swapped out. How are you going to display the panic message?

Well, daemon vs. standalone binaries make no difference here.

> How does a process protected from the OOM killer that is also pinned
> into memory differ from just being part of the kernel? Is creating a
> process like this and building a communication system worth it just to
> get address space separation?

Yes, certainly it is worth it. And remember you'd have to protect your
small helpers, too, OOM can happen there.

Daemon is the way to go, sorry.
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
