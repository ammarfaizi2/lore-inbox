Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261215AbVATXSV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261215AbVATXSV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 18:18:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261294AbVATXST
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 18:18:19 -0500
Received: from mo01.iij4u.or.jp ([210.130.0.20]:1019 "EHLO mo01.iij4u.or.jp")
	by vger.kernel.org with ESMTP id S261215AbVATXPo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 18:15:44 -0500
Date: Fri, 21 Jan 2005 08:15:30 +0900
From: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
To: Andrew Morton <akpm@osdl.org>
Cc: yuasa@hh.iij4u.or.jp, linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.6.11-rc1-mm2] mips: fixed conflicting types
Message-Id: <20050121081530.47c0dcdb.yuasa@hh.iij4u.or.jp>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch had fixed following 2 conflicting type errors.

Yoichi

arch/mips/lib/csum_partial_copy.c:21: error: conflicting types for `csum_partial_copy_nocheck'
include/asm/checksum.h:65: error: previous declaration of `csum_partial_copy_nocheck'
arch/mips/lib/csum_partial_copy.c:38: error: conflicting types for `csum_partial_copy_from_user'
include/asm/checksum.h:38: error: previous declaration of `csum_partial_copy_from_user'
make[1]: *** [arch/mips/lib/csum_partial_copy.o] Error 1
make: *** [arch/mips/lib] Error 2

Signed-off-by: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>

diff -urN -X dontdiff a-orig/arch/mips/lib/csum_partial_copy.c a/arch/mips/lib/csum_partial_copy.c
--- a-orig/arch/mips/lib/csum_partial_copy.c	Wed Jan 12 13:02:09 2005
+++ a/arch/mips/lib/csum_partial_copy.c	Fri Jan 21 07:47:35 2005
@@ -16,7 +16,7 @@
 /*
  * copy while checksumming, otherwise like csum_partial
  */
-unsigned int csum_partial_copy_nocheck(const char *src, char *dst,
+unsigned int csum_partial_copy_nocheck(const unsigned char *src, unsigned char *dst,
 	int len, unsigned int sum)
 {
 	/*
@@ -33,7 +33,7 @@
  * Copy from userspace and compute checksum.  If we catch an exception
  * then zero the rest of the buffer.
  */
-unsigned int csum_partial_copy_from_user (const char *src, char *dst,
+unsigned int csum_partial_copy_from_user (const unsigned char *src, unsigned char *dst,
 	int len, unsigned int sum, int *err_ptr)
 {
 	int missing;
