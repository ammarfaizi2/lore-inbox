Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269445AbUIYXsl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269445AbUIYXsl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Sep 2004 19:48:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269448AbUIYXsk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Sep 2004 19:48:40 -0400
Received: from ltgp.iram.es ([150.214.224.138]:27523 "EHLO ltgp.iram.es")
	by vger.kernel.org with ESMTP id S269445AbUIYXrw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Sep 2004 19:47:52 -0400
From: Gabriel Paubert <paubert@iram.es>
Date: Sun, 26 Sep 2004 01:42:14 +0200
To: Stas Sergeev <stsp@aknet.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ESP corruption bug - what CPUs are affected?
Message-ID: <20040925234214.GA10603@iram.es>
References: <4151C949.1080807@aknet.ru> <20040922200228.GB11017@vana.vc.cvut.cz> <41530326.2050900@aknet.ru> <20040923180607.GA20678@vana.vc.cvut.cz> <4154853F.6070105@aknet.ru> <20040924214330.GD8151@vana.vc.cvut.cz> <20040925080426.GB12901@iram.es> <415563C7.8000701@aknet.ru> <20040925191808.GA5901@iram.es> <4155D7D2.8000705@aknet.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4155D7D2.8000705@aknet.ru>
User-Agent: Mutt/1.5.6+20040818i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi,

> It does not restore it in any case for the 16bit
> stack (no matter whether the code is 16 or 32 in PM).
> Petr says V86 is not affected, but I have not tested
> that case because why to care? The problem is only for
> the 32bit code. For 16bit code (PM or V86) it just
> doesn't really matter I think (I don't think using
> prefixes for ESP is sane).

Well, thrashing a register at any time under the user
just because an interrupt happened is even less sane ;-)

> 
> >I'm absolutely amazed by the fact that this bug has been there
> >since the beginning and only seems to hit users right now.
> No, right now it just hits me:)
> It used to hit the dosemu users always, but people just
> blamed dosemu itself and that was it. Noone wanted
> to spend weeks traceing the DOS programs under dosemu,
> then traceing dosemu itself, then traceing kernel,
> then looking through the docs to track the problem down
> to something known, then writing to Intel's techsup for
> clarifications, and then writing to LKML:) And if not
> for the great help I got here, this will end up nowhere
> again. So that's how it used to stay "unnoticed" for
> years.

I see. And finally we know that the problem with the
processor and that Intel changed the spec to conform
to what the hardware does but is rather coy about it.

> As for the other instances of that problem, here are some:
> 
> http://www.tenberry.com/dos4g/watcom/rn4gw.html
> ---
> B ** Fixed the mouse32 handler to ignore a Microsoft Windows DOS box bug
>     which mangles the high word of ESP.

But if the bug is also affects Windows DOS box, it means that
V86 is affected too, no? 

I'd like to know what OS/2 did. The DOS boxes and 16 bit mode
DPMI applications ran very well and it was very stable, despite
the fact that the kernel spent its time switching between 16
and 32 bit modes (for example, almost all device drivers were 
16 bit code, but the drivers for DOS emulation were 32 bit).
But I removed it from all my machines several years ago.


> http://clio.rice.edu/djgpp/r5bug04.txt
> ---
> On VCPI servers which mode switch using ESP upper bits, CWSDPMI does not
> clear those bits when swapping to it's own stack.
> ---
> 
> Searching google reveals quite a few implicit
> instances of that problem.
> 
> >Anyway, I've just read again Intel's doc about mixing 16 and 32 bit 
> >code and I have found the understament of the day:
> >"For most efficient and trouble-free operation of the processor,
> >                        ^^^^^^^^^^^^
> What is to expect? They knew there are troubles,
> yet decided to make it a part of the specs...

Of which specs? It is never clearly stated in the whole
4 volume doc of the architecture. Only in an obscure
specification change...

	Gabriel

