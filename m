Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262146AbVAUGwo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262146AbVAUGwo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 01:52:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262093AbVAUGwo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 01:52:44 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:39513
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S262146AbVAUGwg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 01:52:36 -0500
Date: Fri, 21 Jan 2005 07:52:35 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: OOM fixes 2/5
Message-ID: <20050121065235.GD17050@dualathlon.random>
References: <20050121054840.GA12647@dualathlon.random> <20050121054916.GB12647@dualathlon.random> <20050120222056.61b8b1c3.akpm@osdl.org> <1106289375.5171.7.camel@npiggin-nld.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1106289375.5171.7.camel@npiggin-nld.site>
X-AA-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-AA-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
X-Cpushare-GPG-Key: 1024D/4D11C21C 5F99 3C8B 5142 EB62 26C3  2325 8989 B72A 4D11 C21C
X-Cpushare-SSL-SHA1-Cert: 3812 CD76 E482 94AF 020C  0FFA E1FF 559D 9B4F A59B
X-Cpushare-SSL-MD5-Cert: EDA5 F2DA 1D32 7560  5E07 6C91 BFFC B885
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 21, 2005 at 05:36:14PM +1100, Nick Piggin wrote:
> I think it should be turned on by default. I can't recall what

I think it too, since the number of people that can be bitten by this is
certainly higher than the number of people who knows the VM internals
and for what kind of workloads they need to enable this by hand to avoid
risking lockups (notably with boxes without swap or with heavy pagetable
allocations all the time which is not uncommon with db usage).

This is needed on x86-64 too to avoid pagetables to lockup the dma zone.
Or anyways it's needed also on x86 for the dma zone on <1G boxes too.

Anyway if you leave it off by default I don't mind, with my new code
forward ported stright from 2.4 mainline, it's possible for the first
time to set it from userspace without having to embed knowledge on the
kernel min_kbytes settings at boot time. So if you want it down by
default it simply means we'll guarantee it on our distro with userland.
Setting a sysctl at boot time is no big deal for us (of course leaving
it enabled by default in kernel space is older distro where userland
isn't yet aware about it). So it's pretty much up to you, as long as we
can easily fixup in userland is fine with me and I already tried a dozen
times to push mainline in what I believe to be the right direction (like
I already did in 2.4 mainline since that same code is enabled by default
in 2.4).

The sysctl name had to change to lowmem_reserve_ratio because its
semantics are completely different now.
