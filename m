Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262955AbTEVRRW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 May 2003 13:17:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262963AbTEVRRW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 May 2003 13:17:22 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:265 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S262955AbTEVRRU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 May 2003 13:17:20 -0400
Date: Thu, 22 May 2003 13:24:26 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Dave Hansen <haveblue@us.ibm.com>, "David S. Miller" <davem@redhat.com>,
       Andrew Theurer <habanero@us.ibm.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: userspace irq balancer
In-Reply-To: <60830000.1053575867@[10.10.2.4]>
Message-ID: <Pine.LNX.3.96.1030522130544.19863B-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 19 May 2003, Dave Hansen wrote:

> On Mon, 2003-05-19 at 15:11, Arjan van de Ven wrote:
	[...snip...]
> But, do you see the need for ripping out the current code?  For those of
> us that are still running a slightly more primitive distro, it would be
> nice to have some pretty effective default behavior, like what is in the
> kernel now.

Ripping out the current code and having useful default behaviour are
hopefully not mutually exclusive.

On 19 May 2003, David S. Miller wrote:


> You have to install new modutils to even use modules with the 2.5.x
> kernel, given that why are we even talking about the "inconvenience"
> of installing the usermode IRQ balancer as being a blocker for
> ripping out the in-kernel stuff?

But you don't have to use modules at all, while running without
interrupts isn't an option.

> The in-kernel stuff MUST go.  It went in because "some benchmark went
> faster", but with no "why" describing why it might have improved
> performance.  We KNOW it absolutely sucks for routing and firewall
> applications.  The in-kernel bits were all a shamans dance, with zero
> technical "here is why this makes things go faster" description
> attached.  If I remember properly, the changelog message when the
> in-kernel irq balancing went in was of the form "this makes some
> specweb run go faster".

Perhaps I misread Linus' recent post about not breaking things to the
user, and I know he was talking about executables in particular, but if
this new code is so great, why can't it start with some default values
which will be no worse than what we have? Because there will be people
who haven't installed the latest userspace int-diddler.

Deliberately making the initial tuning useless to promote use of the
user space software seems counter productive. There will be many users
who will find a way to make a tuned kernel worse than any default, so if
the default is usable it will avoid people shooting themselves in the
foot. Can you imagine someone leaving an interrupt unserviced at all? If
there's a way someone will :-(

I'm not defending the existing code, just speaking for the idea of
leaving something useful in its place.


On Tue, 20 May 2003, Andrew Theurer wrote:

	[...snip...]
> If kirq gets ripped out, at least have some default policy that is somewhat 
> harmless, like destination cpu = int_number % nr_cpus.   I think Suse8 had 
> this, and it performed reasonably well.

As long as it's something sane, it doesn't have to be optimal. If SuSE
used it, it's likely to be good enough.


On Wed, 21 May 2003, Martin J. Bligh wrote:

	[...snip...]
> I'd be happy with that - sounds to me like you're arguing for the same 
> thing. Sane default in kernel, can override from userspace if you like. 
> However, I've yet to see an implementation of the TPR usage that got
> good performance numbers ... I'd love to see that happen.

I may be misreading the intent in David's messages, as long as the
default is useful it certainly doesn't have to be what is in place now.
Of couse it would be useful to actually see some numbers, just because
existing code is somewhat ugly, confusing, and ill-justified and the new
is a pretty algorithm with great flexibility, does not mean that the
actual benchmarks will reflect better performance.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

