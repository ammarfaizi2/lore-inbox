Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262635AbTIAGmr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Sep 2003 02:42:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262652AbTIAGmr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Sep 2003 02:42:47 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:39049 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S262635AbTIAGmq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Sep 2003 02:42:46 -0400
Date: Mon, 1 Sep 2003 07:42:31 +0100
From: Jamie Lokier <jamie@shareable.org>
To: "David S. Miller" <davem@redhat.com>
Cc: mfedyk@matchmail.com, lm@bitmover.com, linux-kernel@vger.kernel.org
Subject: Re: x86, ARM, PARISC, PPC, MIPS and Sparc folks please run this
Message-ID: <20030901064231.GJ748@mail.jlokier.co.uk>
References: <20030829053510.GA12663@mail.jlokier.co.uk> <20030829154101.GB16319@work.bitmover.com> <20030829230521.GD3846@matchmail.com> <20030830221032.1edf71d0.davem@redhat.com> <20030831224937.GA29239@mail.jlokier.co.uk> <20030831223102.3affcb34.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030831223102.3affcb34.davem@redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:
> On Sun, 31 Aug 2003 23:49:37 +0100
> Jamie Lokier <jamie@shareable.org> wrote:
> 
> > It uses POSIX shared memory and (necessarily) MAP_SHARED, which
> > doesn't constrain the mapping alignment.
> 
> That's wrong.  If a platform needs to, it should properly
> align the mapping when MAP_SHARED is used on a file.
> 
> If you look in arch/sparc64/kernel/sys_sparc.c, you'll see
> that when we're mmap()'ing a file and MAP_SHARED is specified,
> we align things to SHMLBA.

Then you have a bug in the Sparc code.  It looks like it should return
-EINVAL when a misaligned mapping is used with MAP_FIXED|MAP_SHARED,
but the test program is clearly getting mappings that aren't aligned
to SHMLBA.

> If userspace purposefully violates this alignment attempt,
> then it's at it's own peril to keep the mappings coherent,
> there is simply nothing the kernel should be doing to help
> out that case.

I understand that userspace needs to keep it coherent, or map to a
multiple of SHMLBA.  I don't mind whether the kernel constrains the
mapping address or not, with a slight preference for userspace
flexibility.

Thus I have three Sparc-specific questions:

	1. How does userspace find out the value of SHMLBA?
	   On Sparc, it is not a compile-time constant.

	2. Is flushing part of the data cache something I can do from
	   userspace?  (I'll figure out the exact machine instructions
	   myself if I need to do this, but it'd be nice to know if
	   it's possible before I have a go).

	3. Is there a kernel bug on Sparc, because the test program
	   is either getting mappings that aren't aligned to run time
	   SHMLBA, or the kernel's run time SHMLBA value is not correct.

Thanks,
-- Jamie
