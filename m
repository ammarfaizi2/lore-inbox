Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262772AbUGFCwP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262772AbUGFCwP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jul 2004 22:52:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262768AbUGFCwP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jul 2004 22:52:15 -0400
Received: from c3-1d224.neo.lrun.com ([24.93.233.224]:11139 "EHLO neo.rr.com")
	by vger.kernel.org with ESMTP id S262772AbUGFCwL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jul 2004 22:52:11 -0400
Date: Mon, 5 Jul 2004 22:47:04 +0000
From: Adam Belay <ambx1@neo.rr.com>
To: Dominik Brodowski <linux@dominikbrodowski.de>,
       linux-kernel@vger.kernel.org, rmk@arm.linux.org.uk, akpm@osdl.org,
       rml@ximian.com, greg@kroah.com
Subject: Re: [RFC][PATCH] driver model and sysfs support for PCMCIA (1/3)
Message-ID: <20040705224704.GA4090@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>,
	Dominik Brodowski <linux@dominikbrodowski.de>,
	linux-kernel@vger.kernel.org, rmk@arm.linux.org.uk, akpm@osdl.org,
	rml@ximian.com, greg@kroah.com
References: <20040628200224.GE5175@neo.rr.com> <20040629190948.GA8659@dominikbrodowski.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040629190948.GA8659@dominikbrodowski.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 29, 2004 at 09:09:48PM +0200, Dominik Brodowski wrote:
> Hi Adam,
>
> First of all I'd like to say that I'm glad you're taking interest in
> the PCMCIA core, and that your experience and patch-writing skills will
> surely be a valuable addition in the joint effort of transforming the
> PCMCIA subsystem to "kernel standards", e.g. hotplug, driver model and
> sysfs.
>
> Second, you might not know about the linux-pcmcia list
> http://lists.infradead.org/mailman/listinfo/linux-pcmcia
> yet -- it's where most PCMCIA-core-in-2.{6,7} stuff is discussed, and it is quite
> low-traffic. Please CC this list on PCMCIA-core-in-2.{6,7} matters in
> future.

Sure, no problem.

>
> Third, about your patches:
> - I like many ideas in your patches -- large parts of them, though, are
>   "double work" as similar things have already been submitted (by me)
>   to Russell on the linux-pcmcia mailing list. What's missing in my current
>   patches [proof-of-concepts do exist and had been announced both on lkml
>   and on said linux-pcmcia list, though] is the exporting of product and
>   manufactor ID and "vers_1" strings, because that needs better resource
>   handling.
> - the resource_ready handling is "racy", at least. Resources can disappear
>   again.

Could you provide an example of how resources will disappear again?  My patch
was designed so that even if they weren't available, nothing bad would happen.
Furthermore, it rescans for devices when userspace attempts to bind a driver.
Resources would almost certainly be available during that time, and if they
weren't, the entire pcmcia stack would be broken, not just sysfs.  In other
words, it seems that resource handling is a problem for all of pcmcia.

> - what I don't like in your patches is that they add an aditional "layer"
>   and thus additional complexity on top of PCMCIA. It already has a multitude of
>   structs with different lifetime rules. Your additions don't make it easier
>   to simplify this complexity. That's why my patchsets [*] try to reduce the
>   complexity first, add struct pcmcia_device next, and reduce complexity by
>   merging other stuff into struct pcmcia_device in the third step. I'd need
>   to re-check whether the step (1) you're leaving out does _not_ cause
>   lifetime headaches and races in strange circumstances [and I don't mean
>   PCMCIA net drivers here, as they're in a comparably good shape.]

My patch adds new code to ds.c but I don't necessarily see it as a new layer.
Because it has very little interaction with pcmcia and its drivers, I think it
reduces the risk of introducing new bugs.  My goal was not to create a perfect
infrastructure for pcmcia and the driver model.  It was to add minimal support for
a much needed feature while introducing as few potential bugs as possible to a
stable kernel series.  I see 2.7 as the time for rewrites.  With that in mind, I
consider your patches to be a great solution, but I'm worried about changing
internal ds functionality during 2.6.

>
> 	Dominik

It was not my intention to create "double work".  I was aware of your effort
in 2.5 but was unable to find any recent patches. (brodo.de was actually down
when I was looking into the issue)  I would really like to work out a common
solution, perhaps with aspects from both of our efforts.  I think that it is
important, however, that we focus on getting working driver model support into
the kernel quickly.  Once that has been achieved, further cleanups could follow.
I appreciate your comments and look forward to any additional suggestions or
alternate viewpoints.

Thanks,
Adam
