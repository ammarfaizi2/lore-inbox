Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752466AbWJ0VTE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752466AbWJ0VTE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Oct 2006 17:19:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752467AbWJ0VTD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Oct 2006 17:19:03 -0400
Received: from ns.suse.de ([195.135.220.2]:2737 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1752466AbWJ0VTB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Oct 2006 17:19:01 -0400
From: Andi Kleen <ak@suse.de>
To: virtualization@lists.osdl.org
Subject: Re: [PATCH 1/5] Skip timer works.patch
Date: Fri, 27 Oct 2006 14:16:12 -0700
User-Agent: KMail/1.9.1
Cc: Zachary Amsden <zach@vmware.com>, Andi Kleen <ak@muc.de>,
       Andrew Morton <akpm@osdl.org>, Chris Wright <chrisw@sous-sol.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200610200009.k9K09MrS027558@zach-dev.vmware.com> <20061027145650.GA37582@muc.de> <45425976.3090508@vmware.com>
In-Reply-To: <45425976.3090508@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610271416.12548.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 27 October 2006 12:09, Zachary Amsden wrote:
> Andi Kleen wrote:
> > On Thu, Oct 19, 2006 at 05:09:22PM -0700, Zachary Amsden wrote:
> >> Add a way to disable the timer IRQ routing check via a boot option.  The
> >> VMI timer code uses this to avoid triggering the pester Mingo code,
> >> which probes for some very unusual and broken motherboard routings.  It
> >> fires 100% of the time when using a paravirtual delay mechanism instead
> >> of using a realtime delay, since there is no elapsed real time, and the
> >> 4 timer IRQs have not yet been delivered.
> >
> > You mean paravirtualized udelay will not actually wait?
>
> Yes, but even putting that problem aside, the timing element here is
> tricky to get right in a VM.
>
> > This implies that you can't ever use any real timer in that kind of
> > guest, right?
>
> No.  You can use a real timer just fine.  But there is no reason ever to
> use udelay to busy wait for "hardware" in a virtual machine.  Drivers
> which are used for real hardware may turn udelay back on selectively;
> but this is another patch.
>
> >> In addition, it is entirely possible, though improbable, that this bug
> >> could surface on real hardware which picks a particularly bad time to
> >> enter SMM mode, causing a long latency during one of the timer IRQs.
> >
> > We already have a no timer check option. But:
>
> Really?  I didn't see one that disabled the broken motherboard detection
> / workaround code, which is what we are trying to avoid here.

no_timer_check. But it's only there on x86-64 in mainline - although there
were some patches to add it to i386 too.

> That is what this patch is building towards, but the boot option is
> "free", so why not?  In the meantime, it helps non-paravirt kernels
> booted in a VM.

Hmm, you meant they paniced before?  If they just fail a few tests
that is not particularly worrying (real hardware does that often too)

-Andi
