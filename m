Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281079AbRKGXXm>; Wed, 7 Nov 2001 18:23:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281084AbRKGXXd>; Wed, 7 Nov 2001 18:23:33 -0500
Received: from cayuga.grammatech.com ([209.4.89.66]:31236 "EHLO grammatech.com")
	by vger.kernel.org with ESMTP id <S281079AbRKGXXY>;
	Wed, 7 Nov 2001 18:23:24 -0500
Message-ID: <3BE9C261.D7422143@grammatech.com>
Date: Wed, 07 Nov 2001 18:23:13 -0500
From: David Chandler <chandler@grammatech.com>
Organization: GrammaTech, Inc.
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.2-2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Bug Report: Dereferencing a bad pointer
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bug Report

Summary:
Dereferencing a bad pointer in user space hangs rather than causing a
segmentation fault in 2.4.x kernels.

Keywords:
memory protection address dereference segmentation fault SIGSEGV


Full Description:

The following one-line C program, when compiled by gcc 2.96 without
optimization, should produce a SIGSEGV segmentation fault (on a machine
with 3 or less gigabytes of virtual memory, at least):

        int main() { int k  = *(int *)0xc0000000; }

However, it does not do so under 2.4.x -- it does cause a seg fault
under
2.2.x kernels.

Specifically, no seg fault occurs under kernels 2.4.2-2 (Red Hat build),

2.4.13, 2.4.13UML, 2.4.9UML, or 2.4.8UML.  This one-liner does cause a
seg fault on 2.2.5-15 (Red Hat build) and 2.2.14-5.0 (Red Hat build).
 All these were run on Pentium II, Pentium III, and Pentium 4 chips.
The "UML" kernels are Linus's official releases patched with the
user-mode linux patches and run on a Red Hat 7.1 2.4.2-2 Pentium 4 host;

Tom's rtbt was the UML file system.

Note that UML uses arch/um rather than arch/i386; this seems to remove
some suspicion from 'arch/i386/mm/fault.c', which has changed
considerably from 2.2.x to 2.4.x.

Rather than seg faulting, the 2.4.x kernels just sit at the offensive
dereference until you interrupt the process.  Interruption works
flawlessly; you can use 'kill -INT', 'kill -SEGV' or 'kill -BUS' to
interrupt the process.

Please Cc: me on any responses -- the linux-kernel traffic is too much
for me.


David Chandler

--

_____
David L. Chandler.                              GrammaTech, Inc.
mailto:chandler@grammatech.com         http://www.grammatech.com



