Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265828AbUFXWRx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265828AbUFXWRx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 18:17:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265768AbUFXWQb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 18:16:31 -0400
Received: from fw.osdl.org ([65.172.181.6]:9347 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265837AbUFXWJB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 18:09:01 -0400
Date: Thu, 24 Jun 2004 15:11:30 -0700
From: Andrew Morton <akpm@osdl.org>
To: wli@holomorphy.com, andrea@suse.de, nickpiggin@yahoo.com.au, tiwai@suse.de,
       ak@suse.de, ak@muc.de, tripperda@nvidia.com, discuss@x86-64.org,
       linux-kernel@vger.kernel.org
Subject: Re: [discuss] Re: 32-bit dma allocations on 64-bit platforms
Message-Id: <20040624151130.4a444973.akpm@osdl.org>
In-Reply-To: <20040624145441.181425c8.akpm@osdl.org>
References: <20040623213643.GB32456@hygelac>
	<20040623234644.GC38425@colin2.muc.de>
	<s5hhdt1i4yc.wl@alsa2.suse.de>
	<20040624112900.GE16727@wotan.suse.de>
	<s5h4qp1hvk0.wl@alsa2.suse.de>
	<20040624164258.1a1beea3.ak@suse.de>
	<s5hy8mdgfzj.wl@alsa2.suse.de>
	<20040624152946.GK30687@dualathlon.random>
	<40DAF7DF.9020501@yahoo.com.au>
	<20040624165200.GM30687@dualathlon.random>
	<20040624165629.GG21066@holomorphy.com>
	<20040624145441.181425c8.akpm@osdl.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> wrote:
>
> Note that this code was sigificantly changed between 2.6.5 and 2.6.7.


Here's the default setup on a 1G ia32 box:

DMA free:4172kB min:16kB low:32kB high:48kB active:0kB inactive:0kB present:16384kB
protections[]: 8 476 540
Normal free:54632kB min:936kB low:1872kB high:2808kB active:278764kB inactive:253668kB present:901120kB
protections[]: 0 468 532
HighMem free:308kB min:128kB low:256kB high:384kB active:87972kB inactive:40300kB present:130516kB
protections[]: 0 0 64

ie:

- protect 8 pages from ZONE_DMA from a GFP_DMA allocation attempt

- protect 476 pages from ZONE_DMA from a GFP_KERNEL allocation attempt

- protect 540 pages from ZONE_DMA from a GFP_HIGHMEM allocation attempt.

etcetera.

After setting lower_zone_protection to 10:

Active:111515 inactive:65009 dirty:116 writeback:0 unstable:0 free:3290 slab:75489 mapped:52247 pagetables:446
DMA free:4172kB min:16kB low:32kB high:48kB active:0kB inactive:0kB present:16384kB
protections[]: 8 5156 5860
Normal free:8736kB min:936kB low:1872kB high:2808kB active:352780kB inactive:224972kB present:901120kB
protections[]: 0 468 1172
HighMem free:252kB min:128kB low:256kB high:384kB active:93280kB inactive:35064kB present:130516kB
protections[]: 0 0 64

It's a bit complex, and perhaps the relative levels of the various
thresholds could be tightened up.
