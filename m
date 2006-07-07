Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932288AbWGGVfZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932288AbWGGVfZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 17:35:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751258AbWGGVfZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 17:35:25 -0400
Received: from smtp.osdl.org ([65.172.181.4]:65171 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751253AbWGGVfY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 17:35:24 -0400
Date: Fri, 7 Jul 2006 14:38:54 -0700
From: Andrew Morton <akpm@osdl.org>
To: Reuben Farrelly <reuben-lkml@reub.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-mm6
Message-Id: <20060707143854.4a8fd106.akpm@osdl.org>
In-Reply-To: <44AECEDD.201@reub.net>
References: <20060703030355.420c7155.akpm@osdl.org>
	<44AE268F.7080409@reub.net>
	<20060707023518.f621bcf2.akpm@osdl.org>
	<44AECEDD.201@reub.net>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Reuben Farrelly <reuben-lkml@reub.net> wrote:
>
> 
> > 
> > The core slab data structures were wrecked.  For kmalloc(), no less. 
> > Something secretly destroyed your kernel, and it could be anything.  Nice.
> 
> Having now turned on slab debugging, is it possibly related to this message 
> which appeared in my log when I booting up earlier?
> 
> Jul  8 02:49:39 tornado kernel: EXT3-fs: mounted filesystem with ordered data mode.
> Jul  8 02:49:39 tornado kernel: Adding 497972k swap on /dev/sdc9.  Priority:-1 
> extents:1 across:497972k
> Jul  8 02:49:40 tornado kernel: ip_tables: (C) 2000-2006 Netfilter Core Team
> Jul  8 02:49:40 tornado kernel: Netfilter messages via NETLINK v0.30.
> Jul  8 02:49:40 tornado kernel: ip_conntrack version 2.4 (4060 buckets, 32480 
> max) - 288 bytes per conntrack
> Jul  8 02:49:40 tornado kernel: Slab corruption: start=ffff81003efd7000, len=4096
> Jul  8 02:49:40 tornado kernel: 170: ff ff ff ff 00 00 00 00 6b 6b 6b 6b 6b 6b 6b 6b
> Jul  8 02:49:40 tornado kernel: e1000: eth0: e1000_watchdog: NIC Link is Up 1000 
> Mbps Full Duplex
> Jul  8 02:49:40 tornado kernel: GRE over IPv4 tunneling driver
> 

Yikes!  Until we fix that there's no point in looking at anything else.

CONFIG_DEBUG_PAGEALLOC would nail this bug in a flash, but x86_64 doesn't
implement the damn thing :(

So if this is repeatable it would be of some value if you can work out what
causes it - start by disabling netfilter.

But to fix it for real we'll probably need to twiddle thumbs until an x86
person can hit it.

