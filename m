Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262699AbTCJC7D>; Sun, 9 Mar 2003 21:59:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262700AbTCJC7D>; Sun, 9 Mar 2003 21:59:03 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:17938 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S262699AbTCJC7C>; Sun, 9 Mar 2003 21:59:02 -0500
Date: Sun, 9 Mar 2003 19:07:36 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Jamie Lokier <jamie@shareable.org>
cc: linux-kernel@vger.kernel.org, <ak@muc.de>
Subject: Re: [Bug 350] New: i386 context switch very slow compared to 2.4
 due to wrmsr (performance)
In-Reply-To: <20030212101206.GA10422@bjl1.jlokier.co.uk>
Message-ID: <Pine.LNX.4.44.0303091858530.1420-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ok Jamie,
 since you've been interested in the past, I thought I'd ask you to test
the current context switch stuff. Andi cleaned up some FPU reload stuff
(and I fixed a bug in it, tssk tssk Andi - you'd obviously not actually
timed your cleanups), and I just committed and pushed out my "cache the
value of SYSENTER_CS in the TSS" patch.

It won't bring context switching back to where it _could_ be, but it
should be noticeably better. My pipe bandwidth is up from under 600MB/s
to about ~700MB/s according to lmbench.

Your SYSENTER_ESP hack would probably get back the rest, but I haven't
seen any patches for it, hint hint.

In the meantime, we're almost back to where we were _and_ we support 
sysenter (ie my system calls are down by almost a factor of four). So 
we're doing pretty well.

			Linus

