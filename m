Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161450AbWJKVVY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161450AbWJKVVY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 17:21:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161423AbWJKVHy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 17:07:54 -0400
Received: from mail.kroah.org ([69.55.234.183]:10145 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1161421AbWJKVHR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 17:07:17 -0400
Date: Wed, 11 Oct 2006 14:06:44 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, Arnd Bergmann <arnd.bergmann@de.ibm.com>,
       David Woodhouse <dwmw2@infradead.org>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 37/67] powerpc: fix building gdb against asm/ptrace.h
Message-ID: <20061011210644.GL16627@kroah.com>
References: <20061011204756.642936754@quad.kroah.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="0015-powerpc-fix-building-gdb-against-asm-ptrace.h.patch"
In-Reply-To: <20061011210310.GA16627@kroah.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


-stable review patch.  If anyone has any objections, please let us know.

------------------
From: Arnd Bergmann <arnd.bergmann@de.ibm.com>

Ulrich Weigand found a bug with the current version of the
asm-powerpc/ptrace.h that prevents building at least the
SPU target version of gdb, since some ptrace opcodes are
not defined.

The problem seems to have originated in the merging of 32 and
64 bit versions of that file, the problem is that some opcodes
are only valid on 64 bit kernels, but are also used by 32 bit
programs, so they can't depends on the __powerpc64__ symbol.

Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>
Signed-off-by: David Woodhouse <dwmw2@infradead.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 include/asm-powerpc/ptrace.h |    4 ----
 1 file changed, 4 deletions(-)

--- linux-2.6.18.orig/include/asm-powerpc/ptrace.h
+++ linux-2.6.18/include/asm-powerpc/ptrace.h
@@ -215,12 +215,10 @@ do {									      \
 #define PTRACE_GETVRREGS	18
 #define PTRACE_SETVRREGS	19
 
-#ifndef __powerpc64__
 /* Get/set all the upper 32-bits of the SPE registers, accumulator, and
  * spefscr, in one go */
 #define PTRACE_GETEVRREGS	20
 #define PTRACE_SETEVRREGS	21
-#endif /* __powerpc64__ */
 
 /*
  * Get or set a debug register. The first 16 are DABR registers and the
@@ -235,7 +233,6 @@ do {									      \
 #define PPC_PTRACE_GETFPREGS	0x97	/* Get FPRs 0 - 31 */
 #define PPC_PTRACE_SETFPREGS	0x96	/* Set FPRs 0 - 31 */
 
-#ifdef __powerpc64__
 /* Calls to trace a 64bit program from a 32bit program */
 #define PPC_PTRACE_PEEKTEXT_3264 0x95
 #define PPC_PTRACE_PEEKDATA_3264 0x94
@@ -243,6 +240,5 @@ do {									      \
 #define PPC_PTRACE_POKEDATA_3264 0x92
 #define PPC_PTRACE_PEEKUSR_3264  0x91
 #define PPC_PTRACE_POKEUSR_3264  0x90
-#endif /* __powerpc64__ */
 
 #endif /* _ASM_POWERPC_PTRACE_H */

--
