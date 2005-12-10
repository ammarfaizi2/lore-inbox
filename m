Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964919AbVLJFKl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964919AbVLJFKl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Dec 2005 00:10:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964920AbVLJFKl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Dec 2005 00:10:41 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:8323 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S964919AbVLJFKl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Dec 2005 00:10:41 -0500
Subject: Re: i386 -> x86_64 cross compile failure (binutils bug?)
From: Lee Revell <rlrevell@joe-job.com>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <p73oe3ppbxj.fsf@verdi.suse.de>
References: <1134154208.14363.8.camel@mindpipe> <439A0746.80208@mnsu.edu>
	 <1134173138.18432.41.camel@mindpipe> <439A201D.7030103@mnsu.edu>
	 <1134179410.18432.66.camel@mindpipe>  <p73oe3ppbxj.fsf@verdi.suse.de>
Content-Type: text/plain
Date: Sat, 10 Dec 2005 00:12:03 -0500
Message-Id: <1134191524.18432.82.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-12-10 at 01:56 -0700, Andi Kleen wrote:
> Lee Revell <rlrevell@joe-job.com> writes:
> >  - disable CONFIG_IA32_EMULATION
> 
> I just tried it here. Adding -m64 to CFLAGS/AFLAGS on a native
> 64bit biarch toolchain and it compiled without problems. It ends
> up with -m64 -m32 for the 32bit vsyscall files, but that seems
> to DTRT at least in gcc 4.

Nope, passing -m64 -m32 does not seem to DTRT on native 32bit biarch
toolchain:

make -f scripts/Makefile.build obj=arch/x86_64/ia32
  gcc -Wp,-MD,arch/x86_64/ia32/.vsyscall-sysenter.o.d  -nostdinc
-isystem /usr/lib/gcc/i486-linux-gnu/4.0.2/include -D__KERNEL__
-Iinclude  -D__ASSEMBLY__ -m64  -m32  -c -o
arch/x86_64/ia32/vsyscall-sysenter.o
arch/x86_64/ia32/vsyscall-sysenter.S
arch/x86_64/ia32/vsyscall-sysenter.S: Assembler messages:
arch/x86_64/ia32/vsyscall-sysenter.S:14: Error: suffix or operands
invalid for `push'

etc

That command succeeds if I run it by hand only passing -m32.

Lee

