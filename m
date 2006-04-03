Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932276AbWDCHoE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932276AbWDCHoE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Apr 2006 03:44:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932325AbWDCHoD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Apr 2006 03:44:03 -0400
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:23020 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S932276AbWDCHoB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Apr 2006 03:44:01 -0400
Date: Mon, 3 Apr 2006 16:44:34 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: pavel@ucw.cz, rpurdie@rpsys.net, lenz@cs.wisc.edu,
       linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: include/asm-arm/memory.h changes break zaurus sl-5500 boot
Message-Id: <20060403164434.fdb5020c.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <20060403073653.GA13275@flint.arm.linux.org.uk>
References: <20060402210003.GA11979@elf.ucw.cz>
	<20060402220807.GD13901@flint.arm.linux.org.uk>
	<20060402222314.GC12166@elf.ucw.cz>
	<20060403091504.ecd341a3.kamezawa.hiroyu@jp.fujitsu.com>
	<20060403073653.GA13275@flint.arm.linux.org.uk>
Organization: Fujitsu
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Apr 2006 08:36:53 +0100
Russell King <rmk+lkml@arm.linux.org.uk> wrote:

> On Mon, Apr 03, 2006 at 09:15:04AM +0900, KAMEZAWA Hiroyuki wrote:
> > On Mon, 3 Apr 2006 00:23:14 +0200
> > Pavel Machek <pavel@ucw.cz> wrote:
> > > > Not surprising given this gem:
> > > > 
> > > > > -#define arch_local_page_offset(pfn, nid) (LOCAL_MAP_NR((pfn) << PAGE_OFFSET))
> > > > 
> > > > PAGE_OFFSET being 3GB - that's one hell of a shift value!
> > > 
> > > Unfortunately this is mainline now. Is there some better fix than
> > > simply reverting the offending patches?
> > 
> > Maybe this one will fix (against 2.6.16-mm2)
> > 
> > LOCAL_MAP_NR(kaddr) returns page offset in a node.
> 
> LOCAL_MAP_NR does not take a kernel virtual address.  If you look at how
> it's defined (Eg):
> 
> #define LOCAL_MAP_NR(addr) \
>         (((unsigned long)(addr) & 0x07ffffff) >> PAGE_SHIFT)
> 

Hmm..from include/asm-arm/arch-clps711x/memory.h

==
/*
 * Given a kaddr, LOCAL_MAR_NR finds the owning node of the memory
 * and returns the index corresponding to the appropriate page in the
 * node's mem_map.
 */
#define LOCAL_MAP_NR(addr) \
        (((unsigned long)(addr) & (NODE_MAX_MEM_SIZE - 1)) >> PAGE_SHIFT)
==

Is this comment wrong ???

I already posted patch against 2.6.17-rc1. so, please NACK for it.
sorry for annoying.

Thanks,
-- Kame



