Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264290AbTLYNDu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Dec 2003 08:03:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264303AbTLYNDu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Dec 2003 08:03:50 -0500
Received: from p508B7C62.dip.t-dialin.net ([80.139.124.98]:38284 "EHLO
	mail.linux-mips.net") by vger.kernel.org with ESMTP id S264290AbTLYNDt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Dec 2003 08:03:49 -0500
Date: Thu, 25 Dec 2003 14:03:16 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Jamie Lokier <jamie@shareable.org>
Cc: Peter Horton <pdh@colonel-panic.org>, Linus Torvalds <torvalds@osdl.org>,
       linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: Possible shared mapping bug in 2.4.23 (at least MIPS/Sparc)
Message-ID: <20031225130316.GB8341@linux-mips.org>
References: <20031213114134.GA9896@skeleton-jack> <20031213222626.GA20153@mail.shareable.org> <Pine.LNX.4.58.0312131740120.14336@home.osdl.org> <20031214103803.GA916@skeleton-jack> <20031214171637.GA28923@mail.shareable.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031214171637.GA28923@mail.shareable.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 14, 2003 at 05:16:37PM +0000, Jamie Lokier wrote:

> Peter Horton wrote:
> > I've seen code written for X86 use MAP_FIXED to create self wrapping
> > ring buffers. Surely it's better to fail the mmap() on other archs
> > rather than for the code to fail in unexpected ways?
> 
> Such code should test the buffers or just not create ring buffers on
> architectures it doesn't know about.  (You can usually simulate them
> by copying data).  On some architectures there is _no_ alignment which
> works, and even on x86 aligning aliases to 32k results in faster
> memory accesses on some chips (AMD ones).
> 
> Also, sometimes a self wrapping ring buffer can work even when the
> separation isn't coherent, provided the code using it forces cache
> line flushes at the appropriate points.

Still I don't see why we shouldn't simply return EINVAL if a user is
trying to something obviously stupid - assuming full coherency in
application is a somewhat common thing and there's better things to waste
time on.  And yes while we could support coherency for arbitrary mappings
I agree it's a bad idea - but there's a huge difference between just
checking arguments and adding the large extra complexity of supporting
arbitrary combinations of addresses for mappings.

  Ralf
