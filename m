Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264989AbSJaA2m>; Wed, 30 Oct 2002 19:28:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264990AbSJaA2m>; Wed, 30 Oct 2002 19:28:42 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:19730 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S264989AbSJaA2l>; Wed, 30 Oct 2002 19:28:41 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: New nanosecond stat patch for 2.5.44
Date: 30 Oct 2002 16:34:42 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <apptr2$i8q$1@cesium.transmeta.com>
References: <20021030004457.GC22170@bjl1.asuk.net> <Pine.LNX.3.96.1021030155404.14229A-100000@gatekeeper.tmr.com> <20021030221724.GA25231@bjl1.asuk.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20021030221724.GA25231@bjl1.asuk.net>
By author:    Jamie Lokier <lk@tantalophile.demon.co.uk>
In newsgroup: linux.dev.kernel
> 
> That's some of the overhead.  The other overhead is reading the clock,
> which is quite high on x86 when TSC is not available.  On a Pentium
> with no reliable TSC, I think that the time for a read() system call
> is comparable to the time to read the clock.
> 

Typically the way you deal with not having a usably cheap
nanosecond-resolution clock is that you use the best available clock
(say if HZ=1000 you'll increment by 1000000 each timer tick), and then
simply use an atomic counter for the smaller divisions.  This makes
the relation "is A newer than B" correct, while avoiding the overhead
of producing exact timestamps below the available resolution.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
