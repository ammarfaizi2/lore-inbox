Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751300AbWAZDbv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751300AbWAZDbv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 22:31:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751306AbWAZDbv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 22:31:51 -0500
Received: from ns.miraclelinux.com ([219.118.163.66]:49636 "EHLO
	mail01.miraclelinux.com") by vger.kernel.org with ESMTP
	id S1751300AbWAZDbu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 22:31:50 -0500
Date: Thu, 26 Jan 2006 12:31:56 +0900
To: Grant Grundler <iod00d@hp.com>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       linux-ia64@vger.kernel.org
Subject: [PATCH 3/12] generic ffz()
Message-ID: <20060126033156.GB11138@miraclelinux.com>
References: <20060125112625.GA18584@miraclelinux.com> <20060125113206.GD18584@miraclelinux.com> <20060125200250.GA26443@flint.arm.linux.org.uk> <20060125205907.GF9995@esmail.cup.hp.com> <20060126032713.GA9984@miraclelinux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060126032713.GA9984@miraclelinux.com>
User-Agent: Mutt/1.5.9i
From: mita@miraclelinux.com (Akinobu Mita)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduces the C-language equivalent of the function:
unsigned long ffz(unsigned long word);

HAVE_ARCH_FFZ_BITOPS is defined when the architecture has its own
version of these functions.

This code largely copied from:
include/asm-sparc64/bitops.h


Index: 2.6-git/include/asm-generic/bitops.h
===================================================================
--- 2.6-git.orig/include/asm-generic/bitops.h	2006-01-25 19:14:09.000000000 +0900
+++ 2.6-git/include/asm-generic/bitops.h	2006-01-25 19:14:10.000000000 +0900
@@ -230,6 +230,13 @@
 
 #endif /* HAVE_ARCH___FFS_BITOPS */
 
+#ifndef HAVE_ARCH_FFZ_BITOPS
+
+/* Undefined if no bit is zero. */
+#define ffz(x)	__ffs(~x)
+
+#endif /* HAVE_ARCH_FFZ_BITOPS */
+
 /*
  * fls: find last bit set.
  */
