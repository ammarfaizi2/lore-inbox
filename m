Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261812AbTIPOCR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Sep 2003 10:02:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261877AbTIPOCQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Sep 2003 10:02:16 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:38417 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S261812AbTIPOCM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Sep 2003 10:02:12 -0400
Date: Tue, 16 Sep 2003 09:52:56 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Dave Jones <davej@redhat.com>
cc: Jamie Lokier <jamie@shareable.org>, richard.brunner@amd.com,
       alan@lxorguk.ukuu.org.uk, zwane@linuxpower.ca,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6 workaround for Athlon/Opteron prefetch errata
In-Reply-To: <20030916133019.GA1039@redhat.com>
Message-ID: <Pine.LNX.3.96.1030916094748.26515B-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Sep 2003, Dave Jones wrote:

> On Tue, Sep 16, 2003 at 12:46:36PM +0100, Jamie Lokier wrote:
> 
>  > > The user space problem worries me more, because the expectation
>  > > is that if CPUID says the program can use perfetch, it could
>  > > and should regardless of what the kernel decided to do here.
>  > 
>  > If the workaround isn't compiled in, "prefetch" should be removed from
>  > /proc/cpuinfo on the buggy chips.
> 
> prefetch isn't a cpuid feature flag. The only way you could do
> what you suggest is by removing '3dnow' or 'sse', which cripples
> things more than necessary.

Good point, and even if it were a separate feature, any code which was
clever enough to use prefetch is likely to check the CPU bits rather
than the /proc anyway. That's a guess, I suspect most programs do
whatever gcc/glibc choose.

If the fixup were not in place, would it be useful to emit a warning
like "you have booted a non-Athlon kernel on an Athlon process, user
programs may get unexpected page faults." That's in init code, hopefully
there is no critical size issue there, I assume, other than how large a
kernel can be booted by the boot loader.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

