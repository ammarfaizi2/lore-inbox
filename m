Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265197AbSKVFQy>; Fri, 22 Nov 2002 00:16:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265246AbSKVFQy>; Fri, 22 Nov 2002 00:16:54 -0500
Received: from supreme.pcug.org.au ([203.10.76.34]:6376 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S265197AbSKVFQx>;
	Fri, 22 Nov 2002 00:16:53 -0500
Date: Fri, 22 Nov 2002 16:23:12 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Linus <torvalds@transmeta.com>
Cc: LKML <linux-kernel@vger.kernel.org>, anton@samba.org,
       "David S. Miller" <davem@redhat.com>, ak@muc.de
Subject: [PATCH] Beginnings of conpat 32 code cleanups
Message-Id: <20021122162312.32ff4bd3.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 0.8.5 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

There is a lot of duplicated code among the 32 compatibility layers in our
64 bit architectures.  I am proposing to considate this as much as
possible. To that end, I first need to tidy up the relevant header files
and make them as common as possible.  Discussions with Dave Miller, Andi
Kleen, and Anton Blanchard has led to the creation of compat32.h to
contain all the 32 compatibility data types.

This patch merely adds include/asm-generic/compat32.h which is the header
information that is common to all the 32 bit compatibility code across all
the architectures (except parisc as I don't pretend to understand that
:-)).

I will follow this up with patches for each architecture that I can. I
also intend to intruduce a CONFIG_COMPAT32 define that will be used to
wrap generic implementations of some of the 32 bit compatibility code in
our architecture independent code.  The idea is to share as much of the
non compatibility code and where that is not possible, to keep the 32 bit
versions of code near their "normal" (i.e.64 bit) counterparts in order to
minimise the number of bugs introduced and maximise the number of bugs
fixed.

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN 2.5.48/include/asm-generic/compat32.h 2.5.48-32bit.1/include/asm-generic/compat32.h
--- 2.5.48/include/asm-generic/compat32.h	1970-01-01 10:00:00.000000000 +1000
+++ 2.5.48-32bit.1/include/asm-generic/compat32.h	2002-11-22 16:02:56.000000000 +1100
@@ -0,0 +1,31 @@
+#ifndef _ASM_GENERIC_COMPAT32_H
+#define _ASM_GENERIC_COMPAT32_H
+
+#include <linux/types.h>
+
+typedef unsigned int		__kernel_size_t32;
+typedef int			__kernel_ssize_t32;
+typedef int			__kernel_time_t32;
+typedef int			__kernel_clock_t32;
+typedef int			__kernel_pid_t32;
+typedef unsigned int		__kernel_ino_t32;
+typedef int			__kernel_daddr_t32;
+typedef int			__kernel_off_t32;
+typedef unsigned int		__kernel_caddr_t32;
+typedef long			__kernel_loff_t32;
+typedef __kernel_fsid_t		__kernel_fsid_t32;
+
+struct timespec32 {
+	s32			tv_sec;
+	s32			tv_nsec;
+};
+
+struct flock32 {
+	short			l_type;
+	short			l_whence;
+	__kernel_off_t32	l_start;
+	__kernel_off_t32	l_len;
+	__kernel_pid_t32	l_pid;
+};
+
+#endif /* _ASM_GENERIC_COMPAT32_H */
