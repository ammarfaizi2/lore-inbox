Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161196AbWI2AW3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161196AbWI2AW3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 20:22:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161198AbWI2AW3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 20:22:29 -0400
Received: from mx1.redhat.com ([66.187.233.31]:62701 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1161196AbWI2AW2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 20:22:28 -0400
Date: Thu, 28 Sep 2006 20:22:12 -0400
From: Dave Jones <davej@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Roman Zippel <zippel@linux-m68k.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: oom kill oddness.
Message-ID: <20060929002212.GB19176@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Andrew Morton <akpm@osdl.org>, Roman Zippel <zippel@linux-m68k.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <20060927205435.GF1319@redhat.com> <Pine.LNX.4.64.0609290035060.6762@scrub.home> <20060928171706.bee0c50b.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060928171706.bee0c50b.akpm@osdl.org>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 28, 2006 at 05:17:06PM -0700, Andrew Morton wrote:
 > On Fri, 29 Sep 2006 01:03:16 +0200 (CEST)
 > Roman Zippel <zippel@linux-m68k.org> wrote:
 > 
 > > Hi,
 > > 
 > > On Wed, 27 Sep 2006, Dave Jones wrote:
 > > 
 > > > So I have two boxes that are very similar.
 > > > Both have 2GB of RAM & 1GB of swap space.
 > > > One has a 2.8GHz CPU, the other a 2.93GHz CPU, both dualcore.
 > > > 
 > > > The slower box survives a 'make -j bzImage' of a 2.6.18 kernel tree
 > > > without incident. (Although it takes ~4 minutes longer than a -j2)
 > > > 
 > > > The faster box goes absolutely nuts, oomkilling everything in sight,
 > > > until eventually after about 10 minutes, the box locks up dead,
 > > > and won't even respond to pings.
 > > > 
 > > > Oh, the only other difference - the slower box has 1 disk, whereas the
 > > > faster box has two in RAID0.   I'm not surprised that stuff is getting
 > > > oom-killed given the pathological scenario, but the fact that the
 > > > box never recovered at all is a little odd.  Does md lack some means
 > > > of dealing with low memory scenarios ?
 > > 
 > > I think I see the same thing on the other end on slow machines, here it 
 > > only takes a single compile job, which doesn't quite fit into memory and 
 > > another task (like top) which occasionally wakes up and tries to allocate 
 > > memory and then kills the compile job - that's very annoying.
 > > 
 > > AFAICT the basic problem is that "did_some_progress" in __alloc_pages() is 
 > > rather local information, other processes can still make progress and keep 
 > > this process from making progress, which gets grumpy and starts killing. 
 > > What's happing here is that most memory is either mapped or in the swap 
 > > cache, so we have a race between processes trying to free memory from the 
 > > cache and processes mapping memory back into their address space.
 > 
 > Kernel versions please, guys.  There have been a lot of oom-killer changes
 > post-2.6.18.

Sorry, I've been stuck on 2.6.18 as that's what we're shipping in FC6 soon.

	Dave
