Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266283AbUBGDiL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Feb 2004 22:38:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266621AbUBGDiL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Feb 2004 22:38:11 -0500
Received: from nevyn.them.org ([66.93.172.17]:37538 "EHLO nevyn.them.org")
	by vger.kernel.org with ESMTP id S266283AbUBGDiH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Feb 2004 22:38:07 -0500
Date: Fri, 6 Feb 2004 22:37:59 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Ulrich Drepper <drepper@redhat.com>, Rik van Riel <riel@redhat.com>,
       Jamie Lokier <jamie@shareable.org>, Andi Kleen <ak@suse.de>,
       johnstul@us.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] linux-2.6.2-rc2_vsyscall-gtod_B1.patch
Message-ID: <20040207033759.GA8384@nevyn.them.org>
Mail-Followup-To: Andrea Arcangeli <andrea@suse.de>,
	Ulrich Drepper <drepper@redhat.com>, Rik van Riel <riel@redhat.com>,
	Jamie Lokier <jamie@shareable.org>, Andi Kleen <ak@suse.de>,
	johnstul@us.ibm.com, linux-kernel@vger.kernel.org
References: <20040205214348.GK31926@dualathlon.random> <Pine.LNX.4.44.0402052314360.5933-100000@chimarrao.boston.redhat.com> <20040206042815.GO31926@dualathlon.random> <40235D0B.5090008@redhat.com> <20040206154906.GS31926@dualathlon.random> <4024333B.6020805@redhat.com> <20040207021954.GD31926@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040207021954.GD31926@dualathlon.random>
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 07, 2004 at 03:19:55AM +0100, Andrea Arcangeli wrote:
> > The official kernel might have the vdso at a fixed address part no part
> > of the ABI requires this address and so anybody with some security
> > conscience can change the kernel to randomize the vdso address.  It's
> > not my or Ingo's fault that Linus doesn't like the exec-shield code
> > which would introduce the randomization.  The important aspect is that
> > we can add vdso randomization and nothing else needs changing.  The same
> > libc will run6 on a stock kernel and the one with the randomized vdso.
> > This is not the case on x86-64 where the absolute address for the
> > gettimeofday is used.
> 
> I don't know exactly what your "randomization exec-shield" code is doing
> either. the way I understand what you wrote is that you want to relocate
> the vsyscall trasparently without glibc knowledge, so in short you're
> saying that you don't care to randomize everything in the userspace
> executable address space, you only care to relocate the vgettimeofday
> bytecode, not the rest of the vsyscall pieces. So with your solution
> you'll still have "fixed" addresses in the address space that will allow
> an attacker to execute vgettimeofday, just like glibc can execute it
> without noticing the actual function was relocated. As far as glibc
> won't notice that vgettimeofday has been relocated by your
> "exec-shield", it means the attacker as well can execute it just fine.

You might want to stop and take a look at the way this works on i386
before you argue with Ulrich any more about it.

Specifically, the vsyscall DSO is constructed as a normal ELF image,
and its base address is passed to glibc as an AT_SYSINFO tag in the
application's auxv vector.  Glibc source code has absolutely no
knowledge of the base address, which in fact has changed at least three
times since it was created.

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
