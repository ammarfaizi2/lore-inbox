Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265514AbUBFPyY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Feb 2004 10:54:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265525AbUBFPyY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Feb 2004 10:54:24 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:10969
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S265514AbUBFPyW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Feb 2004 10:54:22 -0500
Date: Fri, 6 Feb 2004 16:54:20 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Ulrich Drepper <drepper@redhat.com>
Cc: john stultz <johnstul@us.ibm.com>, lkml <linux-kernel@vger.kernel.org>,
       Jamie Lokier <jamie@shareable.org>, Chris McDermott <lcm@us.ibm.com>,
       Wim Coekaerts <wim.coekaerts@oracle.com>,
       Joel Becker <Joel.Becker@oracle.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>
Subject: Re: [RFC][PATCH] linux-2.6.2_vsyscall-gtod_B2.patch
Message-ID: <20040206155420.GT31926@dualathlon.random>
References: <1076037045.757.21.camel@cog.beaverton.ibm.com> <20040206040123.GN31926@dualathlon.random> <40235E24.2060500@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40235E24.2060500@redhat.com>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 06, 2004 at 01:28:04AM -0800, Ulrich Drepper wrote:
> Andrea Arcangeli wrote:
> 
> > with regards to Ulrich's security related comments, this won't make any
> > difference compared to the fixed address version either, since the
> > vsyscall page is still at a fixed address in the fixmap area,
> 
> Gee, you don't want to understand it.
> 
> Even if the official kernel's handling of the vdso puts it at the same
> address all the time this does not mean this can be engraved in stone.

i386 in 2.6.2 has the very same security issues. Fixed address for all
binary kernel shipped for the sysenter or int 0x80 instructions.  go
complain who wrote the i386 code.

> It must be possible to move the page.  And I expect this will be the
> case in our kernels.

what are "yours" kernels? You mean mainline or what? I'm saying it's
perfectly fine to relocate the vsyscall page on demand with an
additional syscall but this will have an overhead, like relocating the
.text executable as well will have an overhead, and before you can care
about relocating the vsyscall address, you should relocate the .text of
the executable as Andi noted.

> It is completely unacceptable to use fixed addresses or require the libc
> to be recompiled for a new address.  At the highest security level the
> vdso address should vary from program run to program run which means
> there is no way to change the libc.

This is fine, the new syscall I'm advocating will simply relocate the
vsyscall page with a new pte and a tlb flush during every context
switch, write it for i386 now since 2.6.2 has those int 0x80 and syscall
instructions at fixed address too.
