Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281357AbRKEV2X>; Mon, 5 Nov 2001 16:28:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281358AbRKEV2D>; Mon, 5 Nov 2001 16:28:03 -0500
Received: from burdell.cc.gatech.edu ([130.207.3.207]:11027 "EHLO
	burdell.cc.gatech.edu") by vger.kernel.org with ESMTP
	id <S281357AbRKEV2C>; Mon, 5 Nov 2001 16:28:02 -0500
Date: Mon, 5 Nov 2001 16:27:53 -0500
From: Josh Fryman <fryman@cc.gatech.edu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: pavel@suse.cz, linux-kernel@vger.kernel.org
Subject: Re: 2.4.14-pre6
Message-Id: <20011105162753.626cbdb6.fryman@cc.gatech.edu>
In-Reply-To: <Pine.LNX.4.33.0111051241410.3682-100000@penguin.transmeta.com>
In-Reply-To: <20011102120108.A47@toy.ucw.cz>
	<Pine.LNX.4.33.0111051241410.3682-100000@penguin.transmeta.com>
X-Mailer: Sylpheed version 0.6.4 (GTK+ 1.2.10; sparc-sun-solaris2.7)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Basically, you get two virtual CPU's per die, and each CPU can run two
> threads at the same time. It slows some stuff down, because it makes for
> much more cache pressure, but Intel claims up to 30% improvement on some
> loads that scale well.
> 
> The 30% is probably a marketing number (ie it might be more like 10% on
> more normal loads), but you have to give them points for interesting
> technology <)

Specifically, the 30% comes in two places.  Using Intel proprietary
benchmarks (unreleased, according to the footnotes) they find that a
typical IA32 instruction mix uses some 35% of system resources in an
advanced device like the P4 with NetBurst.  the rest is idle.

by using the SMT model with two virtual systems - each with complete
register sets and independent APICs, sharing only the backend exec 
units - they claim you get a 30% improvement in wall-clock time.  This 
is supposed to be on their benchmarks *without* recompiling anything.  To 
get "additional" improvement, using code to take advantage of the dual 
virtual CPUs nature of the chip and recompiling should give some 
unquantified gain.

-josh

to help your searching if you want more details, Intel has called this:
  Jackson Technology aka Project Foster aka Hyper-Threading Technology 
  and is known in the rest of the world as SMT.

Intel has a whitepaper or two available for download.  If you can't find
them at developer.intel.com or via Google, let me know and I've got some
copies laying around.  Amusingly, they seem to be ultra scared of
releasing any real information about it. Alpha was working on a 4-way 
design that seemed a bit more clever for the 21464, which appears to be
destined for the bit bucket now :(
