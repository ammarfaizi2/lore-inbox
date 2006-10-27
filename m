Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750991AbWJ0O4x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750991AbWJ0O4x (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Oct 2006 10:56:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752201AbWJ0O4x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Oct 2006 10:56:53 -0400
Received: from colin.muc.de ([193.149.48.1]:2322 "EHLO mail.muc.de")
	by vger.kernel.org with ESMTP id S1750991AbWJ0O4w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Oct 2006 10:56:52 -0400
Date: 27 Oct 2006 16:56:50 +0200
Date: Fri, 27 Oct 2006 16:56:50 +0200
From: Andi Kleen <ak@muc.de>
To: Zachary Amsden <zach@vmware.com>
Cc: Andrew Morton <akpm@osdl.org>, Rusty Russell <rusty@rustcorp.com.au>,
       Jeremy Fitzhardinge <jeremy@goop.org>,
       Chris Wright <chrisw@sous-sol.org>,
       Virtualization Mailing List <virtualization@lists.osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/5] Skip timer works.patch
Message-ID: <20061027145650.GA37582@muc.de>
References: <200610200009.k9K09MrS027558@zach-dev.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200610200009.k9K09MrS027558@zach-dev.vmware.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 19, 2006 at 05:09:22PM -0700, Zachary Amsden wrote:
> Add a way to disable the timer IRQ routing check via a boot option.  The
> VMI timer code uses this to avoid triggering the pester Mingo code, which
> probes for some very unusual and broken motherboard routings.  It fires
> 100% of the time when using a paravirtual delay mechanism instead of
> using a realtime delay, since there is no elapsed real time, and the 4 timer
> IRQs have not yet been delivered.

You mean paravirtualized udelay will not actually wait? 

This implies that you can't ever use any real timer in that kind of guest,
right?

> 
> In addition, it is entirely possible, though improbable, that this bug
> could surface on real hardware which picks a particularly bad time to enter
> SMM mode, causing a long latency during one of the timer IRQs.

We already have a no timer check option. But:

> 
> While here, make check_timer be __init.

So how is this supposed to work? The hypervisor would always pass that 
option?  If yes that would seem rather hackish to me. We should probably
instead probe in some way if we have the required timer hardware.
The paravirt kernel should know anyways it is paravirt and that it doesn't
need to probe for flakey hardware.

-Andi
