Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312523AbSCYTpk>; Mon, 25 Mar 2002 14:45:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312521AbSCYTpc>; Mon, 25 Mar 2002 14:45:32 -0500
Received: from rwcrmhc53.attbi.com ([204.127.198.39]:62180 "EHLO
	rwcrmhc53.attbi.com") by vger.kernel.org with ESMTP
	id <S312522AbSCYTpS>; Mon, 25 Mar 2002 14:45:18 -0500
Date: Mon, 25 Mar 2002 11:45:11 -0800
From: "H . J . Lu" <hjl@lucon.org>
To: Peter Hartley <PDHartley@sonicblue.com>
Cc: linux kernel <linux-kernel@vger.kernel.org>,
        GNU C Library <libc-alpha@sources.redhat.com>
Subject: PATCH: Support __NR_ugetrlimit for 2.2 kernel (Re: Does e2fsprogs-1.26 work on mips?)
Message-ID: <20020325114511.A16225@lucon.org>
In-Reply-To: <37D1208A1C9BD511855B00D0B772242C011C7F15@corpmail1.sc.sonicblue.com> <20020325111117.A15661@lucon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 25, 2002 at 11:11:17AM -0800, H . J . Lu wrote:
> On Mon, Mar 25, 2002 at 11:00:05AM -0800, Peter Hartley wrote:
> > H J Lu wrote:
> > > What are you talking about? It doesn't matter which kernel header
> > > is used. glibc doesn't even use /usr/include/asm/resource.h nor
> > > should any user space applications.
> > 
> > It's not about /usr/include/asm/resource.h, it's about
> > /usr/include/asm/unistd.h, where the syscall numbers are defined.
> > 
> > This is presumably what the "#ifdef __NR_ugetrlimit" in
> > sysdeps/unix/sysv/linux/i386/getrlimit.c is meant to be testing against --
> > nothing in the glibc-2.2.5 distribution itself defines that symbol. Surely a
> > Linux glibc doesn't compile without the target system's linux/* and asm/*
> > headers?
> > 
> > 2.4's /usr/include/asm/unistd.h defines __NR_ugetrlimit but 2.2's doesn't.
> > 
> 
> I see. I think glibc should either require 2.4 header files under
> <asm/*.h> and <linux/*.h>, or define __NR_ugetrlimit if it is not
> defined.
> 
> 

How about this patch?


H.J.
----
2002-03-25  H.J. Lu  <hjl@gnu.org>

	* sysdeps/unix/sysv/linux/arm/kernel-features.h: New. Define
	__NR_ugetrlimit if not defined.
	* sysdeps/unix/sysv/linux/cris/kernel-features.h: Likewise.
	* sysdeps/unix/sysv/linux/i386/kernel-features.h: Likewise.
	* sysdeps/unix/sysv/linux/m68k/kernel-features.h: Likewise.
	* sysdeps/unix/sysv/linux/powerpc/kernel-features.h: Likewise.
	* sysdeps/unix/sysv/linux/s390/s390-32/kernel-features.h: Likewise.
	* sysdeps/unix/sysv/linux/sh/kernel-features.h: Likewise.

--- sysdeps/unix/sysv/linux/arm/kernel-features.h.rlimit	Mon Mar 25 11:32:07 2002
+++ sysdeps/unix/sysv/linux/arm/kernel-features.h	Mon Mar 25 11:32:28 2002
@@ -0,0 +1 @@
+#include <sysdeps/unix/sysv/linux/i386/kernel-features.h>
--- sysdeps/unix/sysv/linux/cris/kernel-features.h.rlimit	Mon Mar 25 11:32:07 2002
+++ sysdeps/unix/sysv/linux/cris/kernel-features.h	Mon Mar 25 11:32:28 2002
@@ -0,0 +1 @@
+#include <sysdeps/unix/sysv/linux/i386/kernel-features.h>
--- sysdeps/unix/sysv/linux/i386/kernel-features.h.rlimit	Mon Mar 25 11:31:54 2002
+++ sysdeps/unix/sysv/linux/i386/kernel-features.h	Mon Mar 25 11:35:31 2002
@@ -0,0 +1,8 @@
+#include <sysdeps/unix/sysv/linux/kernel-features.h>
+
+/* We have to make sure __NR_ugetrlimit is defined, other wise
+   [sg]etrlimit in the glibc compiled under kernel 2.2 won't work
+   under kernel 2.4 and above.  */
+#ifndef __NR_ugetrlimit
+# define __NR_ugetrlimit 191
+#endif
--- sysdeps/unix/sysv/linux/m68k/kernel-features.h.rlimit	Mon Mar 25 11:32:44 2002
+++ sysdeps/unix/sysv/linux/m68k/kernel-features.h	Mon Mar 25 11:32:40 2002
@@ -0,0 +1 @@
+#include <sysdeps/unix/sysv/linux/i386/kernel-features.h>
--- sysdeps/unix/sysv/linux/powerpc/kernel-features.h.rlimit	Mon Mar 25 11:33:39 2002
+++ sysdeps/unix/sysv/linux/powerpc/kernel-features.h	Mon Mar 25 11:35:39 2002
@@ -0,0 +1,8 @@
+#include <sysdeps/unix/sysv/linux/kernel-features.h>
+
+/* We have to make sure __NR_ugetrlimit is defined, other wise
+   [sg]etrlimit in the glibc compiled under kernel 2.2 won't work
+   under kernel 2.4 and above.  */
+#ifndef __NR_ugetrlimit
+# define __NR_ugetrlimit 190
+#endif
--- sysdeps/unix/sysv/linux/s390/s390-32/kernel-features.h.rlimit	Mon Mar 25 11:33:09 2002
+++ sysdeps/unix/sysv/linux/s390/s390-32/kernel-features.h	Mon Mar 25 11:32:58 2002
@@ -0,0 +1 @@
+#include <sysdeps/unix/sysv/linux/i386/kernel-features.h>
--- sysdeps/unix/sysv/linux/sh/kernel-features.h.rlimit	Mon Mar 25 11:33:22 2002
+++ sysdeps/unix/sysv/linux/sh/kernel-features.h	Mon Mar 25 11:33:17 2002
@@ -0,0 +1 @@
+#include <sysdeps/unix/sysv/linux/i386/kernel-features.h>
