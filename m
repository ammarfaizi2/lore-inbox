Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262574AbTCRTMA>; Tue, 18 Mar 2003 14:12:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262576AbTCRTMA>; Tue, 18 Mar 2003 14:12:00 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:17157 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S262574AbTCRTL7>; Tue, 18 Mar 2003 14:11:59 -0500
Date: Tue, 18 Mar 2003 11:21:24 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Brian Gerst <bgerst@didntduck.org>
cc: Kevin Pedretti <ktpedre@sandia.gov>, <linux-kernel@vger.kernel.org>
Subject: Re: [Bug 350] New: i386 context switch very slow compared to 2.4
 due to wrmsr (performance)
In-Reply-To: <3E7765DE.10609@didntduck.org>
Message-ID: <Pine.LNX.4.44.0303181113590.13708-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 18 Mar 2003, Brian Gerst wrote:
> 
> Here's a few more data points:

Ok, this shows the behaviour I was trying to explain:

> vendor_id       : AuthenticAMD
> cpu family      : 5
> model           : 8
> model name      : AMD-K6(tm) 3D processor
> stepping        : 12
> cpu MHz         : 451.037
> empty overhead=105 cycles
> load overhead=-2 cycles
> I$ load overhead=30 cycles
> I$ load overhead=90 cycles
> I$ store overhead=95 cycles

ie loading from the same cacheline shows bad behaviour, most likely due to 
cache line exclusion. Does anybody have an original Pentium to see if I 
remember that one right?

> vendor_id       : AuthenticAMD
> cpu family      : 6
> model           : 6
> model name      : AMD Athlon(tm) Processor
> stepping        : 2
> cpu MHz         : 1409.946
> empty overhead=11 cycles
> load overhead=5 cycles
> I$ load overhead=5 cycles
> I$ load overhead=5 cycles
> I$ store overhead=826 cycles
> 
> The Athlon XP shows really bad behavior when you store to the text area.

Wow. There aren't many things that AMD tends to show the P4-like "big
latency in rare cases" behaviour.

But quite honestly, I think they made the right call, and I _expect_ that
of modern CPU's. The fact is, modern CPU's tend to need to pre-decode the
instruction stream some way, and storing to it while running from it is
just a really really bad idea. And since it's so easy to avoid it, you
really just shouldn't do it.

			Linus

