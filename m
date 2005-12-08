Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030469AbVLHGMW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030469AbVLHGMW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 01:12:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030470AbVLHGMW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 01:12:22 -0500
Received: from cantor.suse.de ([195.135.220.2]:20653 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1030469AbVLHGMV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 01:12:21 -0500
Date: Thu, 8 Dec 2005 07:12:12 +0100
From: Andi Kleen <ak@suse.de>
To: "David S. Miller" <davem@davemloft.net>
Cc: davej@redhat.com, ak@suse.de, linux-kernel@vger.kernel.org
Subject: Re: for_each_online_cpu broken ?
Message-ID: <20051208061211.GG11190@wotan.suse.de>
References: <20051208050738.GE24356@redhat.com> <20051208052632.GF11190@wotan.suse.de> <20051208053302.GA28201@redhat.com> <20051207.213825.27890558.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051207.213825.27890558.davem@davemloft.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 07, 2005 at 09:38:25PM -0800, David S. Miller wrote:
> From: Dave Jones <davej@redhat.com>
> Date: Thu, 8 Dec 2005 00:33:02 -0500
> 
> > On Thu, Dec 08, 2005 at 06:26:32AM +0100, Andi Kleen wrote:
> > 
> >  > The possible map is fixed kind of BTW in 2.6.15rc*. It was a side effect
> >  > of CPU hotplug, which now uses a better algorithm to guess the 
> >  > number of possible CPUs. In 2.6.15 you will just get half the number
> >  > of available CPUs in addition by default
> > 
> > Yep, I noticed it offers a maximum of 6 cpus on my way.
> > As a sidenote, seems kinda funny (and wasteful maybe?), doing this
> > on a lot of hardware that isn't hotplug capable. (Whilst I could
> > disable cpu hotplug in my local build, this isn't an answer for
> > a generic distro kernel).

If you can figure out a way to detect this please share.
The ACPI designers unfortunately didn't think that far
(they did it right for memory hotplug, but not for CPU) 

I invented an ACPI extensin for it, but it's non standard
so the half of CPUs is used as a default unless overwritten
(additional_cpus=NUM) 

Anyways I changed it earlier to 1 additional CPU by default.

> 
> This can be dangerous btw, as some subsystem such as netfilter
> allocate enormous datastructures based upon the largest possible
> cpu number in the system.

It is a big improvement in fact. Previously with NR_CPUS==128 
(default on some distros) and CPU_HOTPLUG enabled it would
always allocate several hundred KB of just standard 
per cpu data unnecessarily.

-Andi

