Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751604AbWDCIzy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751604AbWDCIzy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Apr 2006 04:55:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751576AbWDCIzy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Apr 2006 04:55:54 -0400
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:7084 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1751501AbWDCIzx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Apr 2006 04:55:53 -0400
Date: Mon, 3 Apr 2006 17:56:03 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: rmk+lkml@arm.linux.org.uk
Cc: pavel@ucw.cz, rpurdie@rpsys.net, lenz@cs.wisc.edu,
       linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: include/asm-arm/memory.h changes break zaurus sl-5500 boot
Message-Id: <20060403175603.7a3dd64f.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <20060403164434.fdb5020c.kamezawa.hiroyu@jp.fujitsu.com>
References: <20060402210003.GA11979@elf.ucw.cz>
	<20060402220807.GD13901@flint.arm.linux.org.uk>
	<20060402222314.GC12166@elf.ucw.cz>
	<20060403091504.ecd341a3.kamezawa.hiroyu@jp.fujitsu.com>
	<20060403073653.GA13275@flint.arm.linux.org.uk>
	<20060403164434.fdb5020c.kamezawa.hiroyu@jp.fujitsu.com>
Organization: Fujitsu
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Apr 2006 16:44:34 +0900
KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com> wrote:

> On Mon, 3 Apr 2006 08:36:53 +0100
> Russell King <rmk+lkml@arm.linux.org.uk> wrote:
> Hmm..from include/asm-arm/arch-clps711x/memory.h
> 
> ==
> /*
>  * Given a kaddr, LOCAL_MAR_NR finds the owning node of the memory
>  * and returns the index corresponding to the appropriate page in the
>  * node's mem_map.
>  */
> #define LOCAL_MAP_NR(addr) \
>         (((unsigned long)(addr) & (NODE_MAX_MEM_SIZE - 1)) >> PAGE_SHIFT)
> ==
> 
> Is this comment wrong ???
> 
Russell-san

All of sub-arch's comment says "Given a kaddr" but all of them just uses "offset".
So, paddr can be given as arg. 
__va()(or pfn_to_kaddr()) adds unnecessary calcs, so paddr should be used instead of kaddr.
Right ?

-Kame

