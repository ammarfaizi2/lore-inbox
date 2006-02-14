Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030411AbWBNFGY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030411AbWBNFGY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 00:06:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030403AbWBNFGA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 00:06:00 -0500
Received: from ns.miraclelinux.com ([219.118.163.66]:60623 "EHLO
	mail01.miraclelinux.com") by vger.kernel.org with ESMTP
	id S1030402AbWBNFFK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 00:05:10 -0500
Message-Id: <20060214050443.852246000@localhost.localdomain>
References: <20060214050351.252615000@localhost.localdomain>
Date: Tue, 14 Feb 2006 14:04:02 +0900
From: Akinobu Mita <mita@miraclelinux.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, Richard Henderson <rth@twiddle.net>,
       Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
       Russell King <rmk@arm.linux.org.uk>, Ian Molton <spyro@f2s.com>,
       dev-etrax@axis.com, David Howells <dhowells@redhat.com>,
       Yoshinori Sato <ysato@users.sourceforge.jp>,
       Linus Torvalds <torvalds@osdl.org>, linux-ia64@vger.kernel.org,
       Hirokazu Takata <takata@linux-m32r.org>, linux-m68k@vger.kernel.org,
       Greg Ungerer <gerg@uclinux.org>, linux-mips@linux-mips.org,
       parisc-linux@parisc-linux.org, linuxppc-dev@ozlabs.org,
       linux390@de.ibm.com, linuxsh-dev@lists.sourceforge.net,
       linuxsh-shmedia-dev@lists.sourceforge.net, sparclinux@vger.kernel.org,
       ultralinux@vger.kernel.org, Miles Bader <uclinux-v850@lsi.nec.co.jp>,
       Andi Kleen <ak@suse.de>, Chris Zankel <chris@zankel.net>,
       Akinobu Mita <mita@miraclelinux.com>
Subject: [patch 11/47] generic fls64()
Content-Disposition: inline; filename=fls64.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduces the C-language equivalent of the function:
int fls64(__u64 x);

In include/asm-generic/bitops/fls64.h

This code largely copied from:
include/linux/bitops.h

Signed-off-by: Akinobu Mita <mita@miraclelinux.com>
 include/asm-generic/bitops/fls64.h |   12 ++++++++++++
 1 files changed, 12 insertions(+)

Index: 2.6-rc/include/asm-generic/bitops/fls64.h
===================================================================
--- /dev/null
+++ 2.6-rc/include/asm-generic/bitops/fls64.h
@@ -0,0 +1,12 @@
+#ifndef _ASM_GENERIC_BITOPS_FLS64_H_
+#define _ASM_GENERIC_BITOPS_FLS64_H_
+
+static inline int fls64(__u64 x)
+{
+	__u32 h = x >> 32;
+	if (h)
+		return fls(h) + 32;
+	return fls(x);
+}
+
+#endif /* _ASM_GENERIC_BITOPS_FLS64_H_ */

--
