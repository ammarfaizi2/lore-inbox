Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263802AbUGADiN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263802AbUGADiN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 23:38:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263804AbUGADiN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 23:38:13 -0400
Received: from mail.shareable.org ([81.29.64.88]:45229 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S263802AbUGADgd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 23:36:33 -0400
Date: Thu, 1 Jul 2004 04:36:20 +0100
From: Jamie Lokier <jamie@shareable.org>
To: linux-kernel@vger.kernel.org
Cc: William Lee Irwin III <wli@holomorphy.com>,
       Michael Kerrisk <michael.kerrisk@gmx.net>
Subject: Table of mmap PROT_* implementations by architecture
Message-ID: <20040701033620.GB1564@mail.shareable.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From a study of Linux 2.6.5 source code, and some patches.
This is based on studying the source, not running tests, so there
may be errors.

This table shows expected page protections, for different values of
PROT_READ, PROT_WRITE and PROT_EXEC passed to mmap() and mprotect().

(As noted in a recent mail from me, real behaviour isn't quite this
simple.  Reading from a write-only page will *sometimes* raise a
signal, and sometimes not, possibly dependent on background paging
decisions.  Therefore some of these entries should say "!w!" instead
of "rwx", and "!w-" instead of "rw-".  Perhaps there are other
combinations too, depending on architecture-specific fault handlers).


======================+========================================================
Requested PROT flags  | ---    R--    -W-    RW-    --X    R-X    -WX    RWX
======================+========================================================
alpha                 | ---    r--    rw-    rw-    --x    r-x    rwx    rwx
----------------------+--------------------------------------------------------
arm                   | ---    r-x    rwx    rwx    r-x    r-x    rwx    rwx
----------------------+--------------------------------------------------------
cris                  | ---    r-x    rwx    rwx    r-x    r-x    rwx    rwx
----------------------+--------------------------------------------------------
h8300                 | No MMU
----------------------+--------------------------------------------------------
i386 (plain)          | ---    r-x    rwx    rwx    r-x    r-x    rwx    rwx
i386 (PaX)            | ---    r--    rw-    rw-    r-x    r-x    rw-(2) rw-(2)
i386 (exec-shield)    | ---    r--(3) rw-(3) rw-(3) r-x    r-x    rwx    rwx
i386 (NX)             | ---    r--    rw-    rw-    r-x    r-x    rwx    rwx
----------------------+--------------------------------------------------------
ia64                  | ---    r--    rw-    rw-    --x(1) r-x    rwx    rwx
----------------------+--------------------------------------------------------
m68k (motorola)       | ---    r-x    rwx    rwx    r-x    r-x    rwx    rwx
m68k (sun3)           | r-x    r-x    rwx    rwx    r-x    r-x    rwx    rwx
m68k (no mmu)         | No MMU
----------------------+--------------------------------------------------------
mips                  | ---    r-x    rwx    rwx    r-x    r-x    rwx    rwx
mips64                | ---    r-x    rwx    rwx    r-x    r-x    rwx    rwx
mips (PaX) (4)        | ---    r-x    rwx    rwx    r-x    r-x    rwx    rwx
mips64 (PaX) (4)      | ---    r-x    rwx    rwx    r-x    r-x    rwx    rwx
----------------------+--------------------------------------------------------
parisc                | ---    r--    -w-    rw-    r-x    r-x    rwx    rwx
parisc (PaX)          | ---    r--    -w-    rw-    r-x    r-x    rw-(2) rw-(2)
----------------------+--------------------------------------------------------
ppc                   | ---(1) r-x    rwx(5) rwx    r-x(5) r-x    rwx(5) rwx
ppc64                 | ---(1) r-x    rwx(5) rwx    r-x(5) r-x    rwx(5) rwx
ppc (PaX)	      | ---(1) r--    rw-    rw-    r-x    r-x    rw-(2) rw-(2)
ppc64 (PaX for 2.6)   | ---(1) r--    rw-    rw-    r-x    r-x    rw-(2) rw-(2)
----------------------+--------------------------------------------------------
s390                  | ---    r-x    rwx    rwx    r-x    r-x    rwx    rwx
----------------------+--------------------------------------------------------
sh                    | ---    r-x    rwx    rwx    r-x    r-x    rwx    rwx
sh (no mmu)           | No MMU
----------------------+--------------------------------------------------------
sparc (sun4)          | ---    r-x    rwx    rwx    r-x    r-x    rwx    rwx
sparc (sun4c)         | ---    r-x    rwx    rwx    r-x    r-x    rwx    rwx
sparc (SRMMU)         | ---(1) r-x(6) rwx(6) rwx(6) r-x    r-x    rwx    rwx
sparc64               | ---    r-x    rwx    rwx    r-x    r-x    rwx    rwx
sparc (Pax+SRMMU)     | ---(1) r--    rw-    rw-    r-x    r-x    rw-(2) rw-(2)
sparc64 (Pax)         | ---    r--    rw-    rw-    r-x    r-x    rw-(2) rw-(2)
----------------------+--------------------------------------------------------
um (user mode)        | ---(7) r-x    rwx    rwx    r-x    r-x    rwx    rwx
----------------------+--------------------------------------------------------
v850                  | No MMU
----------------------+--------------------------------------------------------
x86_64 (AMD NX)       | ---    r--    rw-    rw-    r-x    r-x    rwx    rwx
x86_64 (Intel no-NX)  | ---    r-x    rwx    rwx    r-x    r-x    rwx    rwx
x86_64 (Intel NX)     | ---    r--    rw-    rw-    r-x    r-x    rwx    rwx
x86_64 (PaX NX)       | ---    r--    rw-    rw-    r-x    r-x    rw-(2) rw-(2)
x86_64 (PaX no-NX) (4)| ---    r-x    rwx    rwx    r-x    r-x    rwx    rwx
----------------------+--------------------------------------------------------

(1) - In kernel, maybe these pages are readable using "write()"?
      In each case that is labelled, I'm not sure from reading the code.
      (Pages are always readable using ptrace(), that's ok, but write()
      and other kernel reads shouldn't be able to read PROT_NONE pages).

(2) - The PaX security patch simulates fine-grained exec permission.
      PaX also disallows ALL writable+executable pages as a matter of
      policy: PROT_WRITE|PROT_EXEC does not make the mapping executable
      and mprotect() cannot change this.  This feature can be switched
      off for marked executables, or globally.

(3) - The Exec-Shield patch, when the CPU doesn't support the NX capability
      or when it's not a recent enough patch, uses segmentation to
      *approximate* fine-grained exec permission.  If this is so, code
      which detects that one PROT_EXEC page isn't executable cannot
      assume that all non-PROT_EXEC pages aren't executable.

(4) - PaX is available for MIPS, but doesn't really disable execute
      permissions.  On x86-64, PaX assumes the AMD64 architecture with NX
      capability (quite rightly) and so fails to disable execute permissions
      on Intel IA32e chips without NX.

(5) - The PPC code looks like it "ought to" not allow exec in these cases,
      but other comments indicate that the _PAGE_EXEC flag is ignored anyway.

(6) - The code says SRMMU can implement no-exec, but it's not implemented.

(7) - On User Mode Linux, PROT_NONE may depend on underlying architecture.
      Otherwise, read and exec are always synonymous and write implies read,
      regardless of the underlying architecture.


Enjoy,
-- Jamie
