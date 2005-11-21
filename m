Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751180AbVKUWYd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751180AbVKUWYd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 17:24:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751179AbVKUWYd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 17:24:33 -0500
Received: from mail.suse.de ([195.135.220.2]:26777 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751120AbVKUWYc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 17:24:32 -0500
Date: Mon, 21 Nov 2005 23:24:29 +0100
From: Andi Kleen <ak@suse.de>
To: yhlu <yhlu.kernel@gmail.com>
Cc: Andi Kleen <ak@suse.de>, discuss@x86-64.org, linux-kernel@vger.kernel.org,
       linuxbios@openbios.org
Subject: Re: x86_64: apic id lift patch
Message-ID: <20051121222429.GE20775@brahms.suse.de>
References: <86802c440511211349t6a0a9d30i60e15fa23b86c49d@mail.gmail.com> <20051121220605.GD20775@brahms.suse.de> <86802c440511211417h737474fbt57946f4f2396b701@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86802c440511211417h737474fbt57946f4f2396b701@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 21, 2005 at 02:17:35PM -0800, yhlu wrote:
> > Can you please explain clearly:
> >
> > - What are you changing.
> 1.  use core_vir instead of x86_max_cores, for E0 later single core,
> core_vir could be 2, and x86_max_cores still is 1. So it makes node
> calculation right.

max_cores should be 2 here.

> > - What was the problem with the old behaviour
> 1. for E0 single core, node 2, initial apicid is 4, and old cold will
> get node=4 instead of 2.
> 2. if the lifted apicid is not continous, it will assign strange node
> id to the cpu.

Is there a good reason in the BIOS to not make it contiguous?

> > - Why that particular change
> 1. We can get exact node id and core id from initial apicid for E0 later.
> > - Why can't that APIC number setup not be done by the BIOS itself
> 1. That patch the code more generic. and don't assume the lifted
> apicid is continous.

It's only the last resort fallback anyways. I would prefer to not
make it more complicated. The recommend way is you supplying
a SRAT table, then you're independent of any such fallback heuristics
and just tell the kernel the right mapping.

-Andi
