Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262691AbTCJCZV>; Sun, 9 Mar 2003 21:25:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262692AbTCJCZU>; Sun, 9 Mar 2003 21:25:20 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:28431 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S262691AbTCJCZU>; Sun, 9 Mar 2003 21:25:20 -0500
Date: Sun, 9 Mar 2003 18:33:47 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Robert Love <rml@tech9.net>
cc: Zwane Mwaikambo <zwane@linuxpower.ca>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] small fixes in brlock.h
In-Reply-To: <1047255325.680.22.camel@phantasy.awol.org>
Message-ID: <Pine.LNX.4.44.0303091831560.2129-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 9 Mar 2003, Robert Love wrote:
> 
> I guess nothing uses these irq variants.  In fact, grepping the
> source... wow, not much uses brlocks at all.  Only registered lock is
> BR_NETPROTO_LOCK.  A read lock on it is called only 7 times and a write
> lock is used 31 times.
> 
> Everything must of moved over to using RCU or something.  It makes me
> question the future of these things.

No, I don't think there are even "moved to RCU" users. It's just never 
been used very much, since the writes are _so_ expensive (in fact, there 
have been various live-locks on the writer side, the whole brlock thing is 
really questionable).

It's entirely possible that the current user could be replaced by RCU 
and/or seqlocks, and we could get rid of brlocks entirely.

		Linus

