Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312962AbSEHKlq>; Wed, 8 May 2002 06:41:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312973AbSEHKlp>; Wed, 8 May 2002 06:41:45 -0400
Received: from krynn.axis.se ([193.13.178.10]:31200 "EHLO krynn.axis.se")
	by vger.kernel.org with ESMTP id <S312962AbSEHKlo>;
	Wed, 8 May 2002 06:41:44 -0400
Date: Wed, 8 May 2002 12:37:10 +0200 (CEST)
From: Bjorn Wesen <bjorn.wesen@axis.com>
To: Martin Dalecki <dalecki@evision-ventures.com>
cc: Paul Mackerras <paulus@samba.org>, Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] IDE 58
In-Reply-To: <3CD8E78E.40302@evision-ventures.com>
Message-ID: <Pine.LNX.4.33.0205081227100.30573-100000@godzilla.axis.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 May 2002, Martin Dalecki wrote:
> BTW> I would really love it if the cris architecture people could
> "lend me" some small developement system for they interresting CPU.

We'll consider it :) However,

> This unfortunately is the somehow most wired ATA interface
> around. Which is due to the fact that the interface cell is directly mapped to
> some CPU registers. As a CPU design I think it's a fine approach. Don't
> take me wrong. You save yourself the whole silicon which is needed
> for BM access arbitration and general handling and so on... Very nice tought
> out. But on the software side this is a bit wired, since you can't use
> the generic I/O primitives of the arch in question.

I don't see why all IDE-interfaces in the world have to be I/O-mapped just 
because the first PC implementations used that. Sure it was an extended 
ISA-bus but the ISA bus is long gone and we don't all run PC's anymore 
either.

So the simple abstraction we need to hit IDE-bus registers is a macro or 
inline, instead of a call of an I/O-primitive. It was too much work to 
abstract this when I inserted the CRIS-arch IDE-driver in the first place 
so I found a workaround but now seems like a better time..

Similarily, there is no reason at all why the CPU has to do _polling_ just 
because the IDE _bus_ is using a PIO-mode. It probably does that on legacy 
PC's but HW designed, hrm, more optimally can use DMA. Hence the hooks for 
the ide_func_t.

So I'd figure the software side really would be _easier_ to implement with 
those assumptions about how an IDE-interface is supposed to work gone.

> This makes my  cleanup of the portability layer a bit hard
> to finish on the software side.

I understand that, so lets keep the discussion going and I'll check over 
your current cleanup.

/Bjorn


