Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315119AbSEYRPQ>; Sat, 25 May 2002 13:15:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315120AbSEYRPP>; Sat, 25 May 2002 13:15:15 -0400
Received: from mta5.snfc21.pbi.net ([206.13.28.241]:45042 "EHLO
	mta5.snfc21.pbi.net") by vger.kernel.org with ESMTP
	id <S315119AbSEYRPP>; Sat, 25 May 2002 13:15:15 -0400
Date: Sat, 25 May 2002 10:15:15 -0700
From: David Brownell <david-b@pacbell.net>
Subject: Re: ehci-hcd on CARDBUS hangs when stopping card service
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Message-id: <3CEFC6A3.6080002@pacbell.net>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en, fr
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020513
In-Reply-To: <20020523171326.GA11562@kroah.com> <3CED6E0B.8020501@pacbell.net>
 <200205241849.g4OInTe02393@penguin.transmeta.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>Is there a clean way to detect the "card ejected before anything calls 
>>pci_dev->remove()" case?  I don't really like the idea of wrapping code
>>around every PCI register access to detect such cases. 
> 
> You don't have much choice with CardBus, I'm afraid
> ...
> On most (practically all?) machines, a device that no longer exists will
> return a nice floating 0xff for device reads, so it's usually reasonably
> simple to detect (0xff is often not a legal status register value for
> most devices for example). 

Seems to me it'd be worth mentioning this issue somewhere in the
documentation or source.  One could get the impression that the
main issue for a CardBus-enabled PCI driver is to make sure that
the "new style" driver APIs -- with a DEVICE_TABLE etc -- are used.
(Maybe just a brief comment in <asm/io.h> ...)


> Also, it's generally a good idea to "just say no" to endless loops in
> drivers. 

I'm hardly averse to changing that loop (which normally does have an end :)
and I expected to need to at some point.  It's interesting to me just how
long that has been there without causing problems.  In this case the root
cause is that Cardbus "improper shutdown sequence" problem, so "no end"
is just a particularly nasty secondary failure mode.

- Dave


