Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268203AbUIPWOQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268203AbUIPWOQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 18:14:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268005AbUIPWMl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 18:12:41 -0400
Received: from sccrmhc13.comcast.net ([204.127.202.64]:5356 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S268004AbUIPWKu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 18:10:50 -0400
Date: Thu, 16 Sep 2004 15:10:39 -0700
From: Deepak Saxena <dsaxena@plexity.net>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: Being more anal about iospace accesses..
Message-ID: <20040916221039.GA12406@plexity.net>
Reply-To: dsaxena@plexity.net
References: <Pine.LNX.4.58.0409081543320.5912@ppc970.osdl.org> <Pine.LNX.4.58.0409150737260.2333@ppc970.osdl.org> <Pine.LNX.4.58.0409150859100.2333@ppc970.osdl.org> <20040915222157.GA17284@plexity.net> <Pine.LNX.4.58.0409151540260.2333@ppc970.osdl.org> <20040915230904.GA19450@plexity.net> <Pine.GSO.4.58.0409161410080.23693@waterleaf.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.58.0409161410080.23693@waterleaf.sonytel.be>
Organization: Plexity Networks
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sep 16 2004, at 14:51, Geert Uytterhoeven was caught saying:
> While 16550 serial is a bad example since it does byte accesses only (and thus
> doesn't suffer from endianness), I have no problem to imagine there exist
> platforms where you have multiple instances of a `standard' (cfr. 16550 serial)

No longer true. We now have UPIO_IOMEM32 for some of the fscked up HW 
that large silicon manufacturer has released with 32-bit wide registers
that must be accessed as full 32-bits.

> device block, while each of them must be accessed differently:
>   - one of them is in PCI I/O space (little endian)
>   - one of them is in PCI MMIO space (little endian)
>   - one of them is on-chip MMIO (big endian)
>   - one of them is somewhere else, but sparsely addressed (some bytes of
>     padding between each register)
> and we can for sure come up with a few more examples of weird addressing.
> 
> How to solve this, without cluttering each ioread*() with many if clauses?

If clauses will still be needed, the only difference is that instead
of basing them on hardcoded addresses we now base them on
the devices coming in. 

~Deepak

-- 
Deepak Saxena - dsaxena at plexity dot net - http://www.plexity.net/

"Unlike me, many of you have accepted the situation of your imprisonment
and will die here like rotten cabbages." - Number 6
