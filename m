Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965053AbWI2ARc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965053AbWI2ARc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 20:17:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965055AbWI2ARc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 20:17:32 -0400
Received: from smtp.osdl.org ([65.172.181.4]:50843 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965053AbWI2ARb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 20:17:31 -0400
Date: Thu, 28 Sep 2006 17:17:06 -0700
From: Andrew Morton <akpm@osdl.org>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Dave Jones <davej@redhat.com>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: oom kill oddness.
Message-Id: <20060928171706.bee0c50b.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0609290035060.6762@scrub.home>
References: <20060927205435.GF1319@redhat.com>
	<Pine.LNX.4.64.0609290035060.6762@scrub.home>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Sep 2006 01:03:16 +0200 (CEST)
Roman Zippel <zippel@linux-m68k.org> wrote:

> Hi,
> 
> On Wed, 27 Sep 2006, Dave Jones wrote:
> 
> > So I have two boxes that are very similar.
> > Both have 2GB of RAM & 1GB of swap space.
> > One has a 2.8GHz CPU, the other a 2.93GHz CPU, both dualcore.
> > 
> > The slower box survives a 'make -j bzImage' of a 2.6.18 kernel tree
> > without incident. (Although it takes ~4 minutes longer than a -j2)
> > 
> > The faster box goes absolutely nuts, oomkilling everything in sight,
> > until eventually after about 10 minutes, the box locks up dead,
> > and won't even respond to pings.
> > 
> > Oh, the only other difference - the slower box has 1 disk, whereas the
> > faster box has two in RAID0.   I'm not surprised that stuff is getting
> > oom-killed given the pathological scenario, but the fact that the
> > box never recovered at all is a little odd.  Does md lack some means
> > of dealing with low memory scenarios ?
> 
> I think I see the same thing on the other end on slow machines, here it 
> only takes a single compile job, which doesn't quite fit into memory and 
> another task (like top) which occasionally wakes up and tries to allocate 
> memory and then kills the compile job - that's very annoying.
> 
> AFAICT the basic problem is that "did_some_progress" in __alloc_pages() is 
> rather local information, other processes can still make progress and keep 
> this process from making progress, which gets grumpy and starts killing. 
> What's happing here is that most memory is either mapped or in the swap 
> cache, so we have a race between processes trying to free memory from the 
> cache and processes mapping memory back into their address space.

Kernel versions please, guys.  There have been a lot of oom-killer changes
post-2.6.18.

> If someone wants to play with the problem, the example program below 
> triggers the problem relatively easily (booting with only little ram 
> helps), it starts a number of readers, which should touch a bit more 
> memory than is available and a few writers, which occasionally allocate 
> memory.
> 

How much ram, how much swap?

