Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293236AbSCOUl5>; Fri, 15 Mar 2002 15:41:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293237AbSCOUls>; Fri, 15 Mar 2002 15:41:48 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:49413 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S293236AbSCOUlf>; Fri, 15 Mar 2002 15:41:35 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] Cleanup port 0x80 use (was: Re: IO delay ...)
Date: 15 Mar 2002 12:41:09 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <a6tm95$c55$1@cesium.transmeta.com>
In-Reply-To: <Pine.LNX.4.33.0203151736460.1477-100000@biker.pdb.fsc.net> <E16lw5V-0004ES-00@the-village.bc.nu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <E16lw5V-0004ES-00@the-village.bc.nu>
By author:    Alan Cox <alan@lxorguk.ukuu.org.uk>
In newsgroup: linux.dev.kernel
>
> > I am still wondering, though, why this method of getting a delay
> > is used so often. IMO in most places one could use udelay(1) instead,
> > with much less risk of doing wrong.
> 
> udelay(1) I don't believe is enough. Unfortunately I can't find my
> documentation on the ISA bus which covers the timeout for acknowledging an
> address cycle. Otherwise for tsc capable boxes I agree entirely.
> 

The ISA bus doesn't time out; a cycle on the ISA bus just happens, and
the fact that noone is there to listen doesn't seem to matter.

The delay is something like 8 cycles @ 8.3 MHz or around 1 ms.
However, an important thing to note is that this delay applies *at the
southbridge*.  An OUT is a fully synchronizing operation, so it
doesn't just give a 1 ms delay due to the ISA bus cycle, but it also
makes sure everything else in the system is completed before the
timing counter even starts to tick.

Of course, if all you're doing is IOIO (on an x86!) it doesn't matter
-- IOIO is fully synchronizing anyway.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
