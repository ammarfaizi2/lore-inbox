Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262139AbTLNRRX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Dec 2003 12:17:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262181AbTLNRRX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Dec 2003 12:17:23 -0500
Received: from mail.jlokier.co.uk ([81.29.64.88]:21636 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S262139AbTLNRRW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Dec 2003 12:17:22 -0500
Date: Sun, 14 Dec 2003 17:16:37 +0000
From: Jamie Lokier <jamie@shareable.org>
To: Peter Horton <pdh@colonel-panic.org>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-mips@linux-mips.org,
       linux-kernel@vger.kernel.org
Subject: Re: Possible shared mapping bug in 2.4.23 (at least MIPS/Sparc)
Message-ID: <20031214171637.GA28923@mail.shareable.org>
References: <20031213114134.GA9896@skeleton-jack> <20031213222626.GA20153@mail.shareable.org> <Pine.LNX.4.58.0312131740120.14336@home.osdl.org> <20031214103803.GA916@skeleton-jack>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031214103803.GA916@skeleton-jack>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Horton wrote:
> I've seen code written for X86 use MAP_FIXED to create self wrapping
> ring buffers. Surely it's better to fail the mmap() on other archs
> rather than for the code to fail in unexpected ways?

Such code should test the buffers or just not create ring buffers on
architectures it doesn't know about.  (You can usually simulate them
by copying data).  On some architectures there is _no_ alignment which
works, and even on x86 aligning aliases to 32k results in faster
memory accesses on some chips (AMD ones).

Also, sometimes a self wrapping ring buffer can work even when the
separation isn't coherent, provided the code using it forces cache
line flushes at the appropriate points.

-- Jamie
