Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932507AbVJaR2B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932507AbVJaR2B (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 12:28:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932512AbVJaR2B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 12:28:01 -0500
Received: from sb0-cf9a48a7.dsl.impulse.net ([207.154.72.167]:17159 "EHLO
	madrabbit.org") by vger.kernel.org with ESMTP id S932507AbVJaR2A
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 12:28:00 -0500
Subject: Re: [BUG 2579] linux 2.6.* sound problems
From: Ray Lee <ray-lk@madrabbit.org>
To: patrizio.bassi@gmail.com
Cc: "Kernel," <linux-kernel@vger.kernel.org>,
       Mike Fowler <linux-kernel@mlfowler.com>
In-Reply-To: <43664E9C.2030808@gmail.com>
References: <53JVy-4yi-19@gated-at.bofh.it> <53Kyw-5Bt-53@gated-at.bofh.it>
	 <43664E9C.2030808@gmail.com>
Content-Type: text/plain
Organization: http://madrabbit.org/
Date: Mon, 31 Oct 2005 09:27:59 -0800
Message-Id: <1130779679.27339.30.camel@orca.madrabbit.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-10-31 at 18:04 +0100, Patrizio Bassi wrote:
> > On 10/31/05, Patrizio Bassi <patrizio.bassi@gmail.com> wrote:
> >>starting from 2.6.0 (2 years ago) i have the following bug.
> >>link: http://bugzilla.kernel.org/show_bug.cgi?id=2579

> >>fast summary:
> >>when playing audio and using a bit the harddisk (i.e. md5sum of a 200mb
> >>file) i hear noises, related to disk activity. more hd is used, more chicks
> >>and ZZZZ noises happen.
> > 
> > Does hdparm -i (or -I) show differences between the 2.4 kernels and
> > 2.6? 2.6 has new IDE drivers, and so perhaps your system isn't using
> > the best driver any more.
> > 
> > You may also want to compare lspci -vv of your IDE controller and
> > sound card between 2.4 and 2.6, and see if there are any differences.
> > 
> > No guarantees, but this is where you'd start.
> > 
> > 
> >>Ready to test any patch/solution.
> > 
> > 
> > Try that. If nothing obvious appears in the examination, you may want
> > to try the 2.6.14-rt1 patchset from Ingo Molnar. It's designed to
> > reduce latency in the kernel, but also has a latency tracer that may
> > be particularly useful for your problem. (Assuming it's a latency
> > issue, and not a hardware misconfiguration due to 2.6 doing something
> > wrong.)
> > 
> > Ray
> 
> actually i don't have any more 2.4 kernels due to some problems with
> other devices.

I'd suggest installing one and at minimum booting it to single user mode
to run some tests. If 2.4 works great, then it's worthwhile to find out
what it's getting right that 2.6 is getting wrong. The only way to find
that out is to compare the two.

> however i remember i checked that and it was pretty the same

Well, I barely trust my own memory in general, so I'd suggest that we
check. Humor me. This is the standard way to find out where a problem
is. Check the good, check the bad, compare the two.

> kernel is perfectly tuned.

<?> How do you know?

> i notice that with dma disabled it works much better.
> problem happens with hda/hdc, so both ide channels.

> hdparm -i /dev/hda

It'd be more useful to see hdparm 2.4 versus 2.6, so we can see if
there's any difference. If we don't see the 2.4 version, then we can't
tell if this is something worthwhile to tweak. Does that make sense? If
they are set the same between both 2.4 and 2.6, then we know we can rule
the hard drive settings out as the source of the problem.

>  BuffType=DualPortCache, BuffSize=1916kB, MaxMultSect=16, MultSect=off
>  BuffType=DualPortCache, BuffSize=1821kB, MaxMultSect=16, MultSect=off

MultiSect is off on both, can you turn that on and see if that makes a
difference? Without multisect set on (and set to 16), your hard drives
are transferring one sector per interrupt, instead of a max of 16. This
makes for a lot more interrupts on the system, and might be the source
of the problem.

If that doesn't change anything, you may also try what Mike Fowler
hinted at, and recompile your kernel with Hz set to 100 instead of the
default 250. As well as trying the RT patchset and seeing if that shows
any sources of problems.

Ray

