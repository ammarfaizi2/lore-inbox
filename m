Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751245AbVLEO2a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751245AbVLEO2a (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 09:28:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751369AbVLEO2a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 09:28:30 -0500
Received: from hornet.berlios.de ([195.37.77.140]:40292 "EHLO
	hornet.berlios.de") by vger.kernel.org with ESMTP id S1751245AbVLEO2a
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 09:28:30 -0500
From: Michael Frank <mhf@users.berlios.de>
Reply-To: mhf@users.berlios.de
To: Arjan van de Ven <arjan@infradead.org>, Adrian Bunk <bunk@stusta.de>
Subject: Re: RFC: Starting a stable kernel series off the 2.6 kernel
Date: Mon, 5 Dec 2005 10:47:24 +0100
Cc: linux-kernel@vger.kernel.org
References: <20051203135608.GJ31395@stusta.de> <20051203152339.GK31395@stusta.de> <1133624383.22170.23.camel@laptopd505.fenrus.org>
In-Reply-To: <1133624383.22170.23.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-6"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <20051205142941.DBBE92AF7@hornet.berlios.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 03 December 2005 16:39, Arjan van de Ven wrote:
> > > this is a contradiction. You can't eat a cake and
> > > have it; either you're really low churn (like
> > > existing -stable) or you start adding new features
> > > like hardware support. the problem with hardware
> > > support is that it's not just a tiny driver update.
> > > If involves midlayer updates as well usually, and
> > > especially if those midlayers diverge between your
> > > stable and mainline, the "backports" are getting
> > > increasingly unsafe and hard.
> >
> > In the beginning, backporting hardware support is
> > relatively easy, and therefore cherry-picking from
> > mainline 2.6 should be relatively safe.
>
> and then there's reality. At least in my experience as
> distro kernel maintainer... you can do this for a few
> months, but it gets exponentially more expensive after 4
> to 5 months. And "safe" is just not true. API, midlayer
> and locking changes in the newer kernels just void that
> concept entirely. And then there's the testing dillema;
> the people who'd run such a branch are EXACTLY the ones
> who wouldn't test prereleases of such branch (and yes 2.4
> suffers from this as well).
>
> I doubt many distros would go for it as well for longer
> than a few months, simply because the hardware support
> and other features are going to be needed for them.
>
> > Things will change as time passes by, but then there's
> > the possibility to open the next branch and bring the
> > older branch into a security-fixes only mode.
>
> if you end up with 5 such branches it's no longer fun,
> trust me on that. Especially if the security fix is in a
> tricky area or a high flux area, then it's just not a
> matter of a simple backport anymore, even knowing if
> you're vulnerable or not is going to be a pain. And then
> there are the holes that happened to have gone away by
> later changes... what are you going to do then... put
> those changes in? that won't work longer term.
>
> > > If the current model doesn't work as you claim it
> > > doesn't, then maybe the model needs finetuning. Right
> > > now the biggest pain is the userland ABI changes that
> > > need new packages; sometimes (often) for no real hard
> > > reason. Maybe we should just stop doing those bits,
> > > they're not in any fundamental way blocking general
> > > progress (sure there's some code bloat due to it, but
> > > I guess we'll just have to live with that).
> >
> > IOW, we should e.g. ensure that today's udev will still
> > work flawlessly with kernel 2.6.30 (sic)?
>
> I'd say yes. It doesn't need to support all new
> functionality, but at least what it does today it should
> be able to do then. If that really isn't possible maybe
> udev should be part of the kernel build and per kernel
> version.

Most problems are avoided when packages closely linked to 
the kernel like udev and  pcmcia will be updated by the 
distro together with the kernel by way of package version 
dependencies matching for example 2.6.14 to udev 065-069
and kernel 2.6.15 to udev 070. udev 070 and later could 
block kernels <=2.6.14.

udev bit me recently when a scanner stopped working after 
updating to udev 070. In that way I had a chance to figure 
out how udev  works and how to make some rules. Neat! ;)

Perhaps extra care should be taken by the distro to not 
break the 50-udev.rules configuration file.  

>
> > This could work, but it should be officially announced
> > that e.g. a userspace running kernel 2.6.15 must work
> > flawlessly with _any_ future 2.6 kernel.
>
> I would argue that this in theory already is the current
> policy. Now "any" is pretty wide, but still. Maybe any
> such changes need to be scheduled to specific kernel
> releases only. Eg only do it every 4th or 5th kernel
> release.

My 2 cents:

Test drive some rc's (2.6.15-rc)
Use current -stable kernel as much as possible (2.6.14.3)
Critical apps use -stable -1 or -2 (2.6.13.x or 2.6.12.x)

Using -stable to -stable -2 one is about 3 months behind the 
latest and greatest instability ;).

As to security, most vulnerabilities are hard to exploit 
remotely and practical security can be much more improved 
by hiding detailed software versions from clients.  Apache 
2 on linux 2.6 will do instead of providing full vendor 
specific package versions!

As to drivers, in case 3 month driver delay matters, HW 
vendor can improve situation substantially  by not waiting 
6+ months before (if at all) releasing drivers/docs for 
linux! 

	Michael
