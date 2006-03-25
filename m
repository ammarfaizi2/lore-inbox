Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751186AbWCYMyF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751186AbWCYMyF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Mar 2006 07:54:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751378AbWCYMyF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Mar 2006 07:54:05 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:27404 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751186AbWCYMyE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Mar 2006 07:54:04 -0500
Date: Sat, 25 Mar 2006 12:53:49 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Andrew Morton <akpm@osdl.org>
Cc: davem@davemloft.net, linux-kernel@vger.kernel.org
Subject: Re: SMP busted on non-cpu-hotplug systems
Message-ID: <20060325125349.GB6100@flint.arm.linux.org.uk>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>, davem@davemloft.net,
	linux-kernel@vger.kernel.org
References: <20060325.024226.53296559.davem@davemloft.net> <20060325034744.35b70f43.akpm@osdl.org> <20060325120546.GA6100@flint.arm.linux.org.uk> <20060325041559.63011426.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060325041559.63011426.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 25, 2006 at 04:15:59AM -0800, Andrew Morton wrote:
> Russell King <rmk+lkml@arm.linux.org.uk> wrote:
> > With your proposed change,
> 
> Which proposed change?  I proposed two.

The latter change.

> > if a SMP system with has 4 possible CPUs
> > was passed maxcpus=1, cpu_possible_map may well have 4 CPUs, and
> > cpu_present_map will only contain the one.  However, due to the
> > fixup_cpu_present_map(), it will say "oh only one CPU, we need to
> > populate the others" and so you'd actually try to boot all 4.
> 
> The change we appear to be going with is to remove fixup_cpu_present_map()
> which appears to address this.
> 
> > So no, this doesn't work.
> 
> What doesn't work?

The situation I described and you've quoted in the bulk of the above
quote.

> >  Isn't it about time the pre-CPU hotplug SMP
> > stuff was updated, rather than trying to messily support two different
> > SMP initialisation methodologies in generic code with band aid plasters
> > all over?
> 
> What two methodologies?  arch-doing-it and fixup_cpu_present_map() doing it?

What I'm referring to is the pre-CPU hotplug SMP initialisation
methodology and the post-CPU hotplug SMP initialisation methodology,
which I think is covered by "two different SMP initialisation
methodologies".

The two methodologies had entirely different ways of bringing up the
non-boot CPUs to the extent of using the cpu_*_map variables in different
ways.  However, now that I come to look again at x86, the situation does
appear to have improved somewhat over the last year or so since I last
looked (which was when I sorted out the ARM SMP support.)

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
