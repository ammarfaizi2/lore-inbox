Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262318AbVAUIlS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262318AbVAUIlS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 03:41:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262319AbVAUIlS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 03:41:18 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:15207
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S262318AbVAUIlL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 03:41:11 -0500
Date: Fri, 21 Jan 2005 09:41:11 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Jens Axboe <axboe@suse.de>
Cc: Andries Brouwer <aebr@win.tue.nl>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: oom killer gone nuts
Message-ID: <20050121084111.GB7703@dualathlon.random>
References: <20050120123402.GA4782@suse.de> <20050120131556.GC10457@pclin040.win.tue.nl> <20050120171544.GN12647@dualathlon.random> <20050121074203.GH2755@suse.de> <20050121080520.GA7703@dualathlon.random> <20050121080940.GA2763@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050121080940.GA2763@suse.de>
X-AA-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-AA-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
X-Cpushare-GPG-Key: 1024D/4D11C21C 5F99 3C8B 5142 EB62 26C3  2325 8989 B72A 4D11 C21C
X-Cpushare-SSL-SHA1-Cert: 3812 CD76 E482 94AF 020C  0FFA E1FF 559D 9B4F A59B
X-Cpushare-SSL-MD5-Cert: EDA5 F2DA 1D32 7560  5E07 6C91 BFFC B885
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 21, 2005 at 09:09:41AM +0100, Jens Axboe wrote:
> Jan 20 13:22:15 wiggum kernel: oom-killer: gfp_mask=0xd1

This was a GFP_KERNEL|GFP_DMA allocation triggering this. However it
didn't look so much out of DMA zone, there's 4M of ram free. Could be
the ram was relased by another CPU in the meantime if this was SMP (or
even by an interrupt in UP too).

Could very well be you'll get things fixed by the lowmem_reserve patch,
that will reserve part of the dma zone, so with it you're sure it
couldn't have gone below 4M due slab allocs like skb.

I recommend trying again with the patches applied, the oom stuff is so
buggy right now that it's better you apply the fixes and try again, and
if it still happens we know it's a regression.

Thanks!
