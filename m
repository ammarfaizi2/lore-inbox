Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261400AbVCFOZh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261400AbVCFOZh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Mar 2005 09:25:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261401AbVCFOZh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Mar 2005 09:25:37 -0500
Received: from mo01.iij4u.or.jp ([210.130.0.20]:58832 "EHLO mo01.iij4u.or.jp")
	by vger.kernel.org with ESMTP id S261400AbVCFOZJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Mar 2005 09:25:09 -0500
Date: Sun, 6 Mar 2005 23:24:50 +0900
From: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
To: Andrew Morton <akpm@osdl.org>
Cc: yuasa@hh.iij4u.or.jp, linux-kernel <linux-kernel@vger.kernel.org>,
       Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 2.6.11-mm1] mips: more convert verify_area to access_ok
Message-Id: <20050306232450.104fd7b7.yuasa@hh.iij4u.or.jp>
X-Mailer: Sylpheed version 1.0.1 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch converts verify_area to access_ok for include/asm-mips.

Yoichi

Signed-off-by: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>

diff -urN -X dontdiff a-orig/include/asm-mips/uaccess.h a/include/asm-mips/uaccess.h
--- a-orig/include/asm-mips/uaccess.h	Sat Mar  5 04:15:22 2005
+++ a/include/asm-mips/uaccess.h	Sun Mar  6 15:51:02 2005
@@ -254,13 +254,11 @@
 ({									\
 	__typeof__(*(ptr)) __gu_val = 0;				\
 	long __gu_addr;							\
-	long __gu_err;							\
+	long __gu_err = -EFAULT;					\
 									\
 	might_sleep();							\
 	__gu_addr = (long) (ptr);					\
-	__gu_err = verify_area(VERIFY_READ, (void *) __gu_addr, size);	\
-									\
-	if (likely(!__gu_err)) {					\
+	if (access_ok(VERIFY_READ, (void *) __gu_addr, size)) {		\
 		switch (size) {						\
 		case 1: __get_user_asm("lb", __gu_err); break;		\
 		case 2: __get_user_asm("lh", __gu_err); break;		\
@@ -348,14 +346,12 @@
 ({									\
 	__typeof__(*(ptr)) __pu_val;					\
 	long __pu_addr;							\
-	long __pu_err;							\
+	long __pu_err = -EFAULT;					\
 									\
 	might_sleep();							\
 	__pu_val = (x);							\
 	__pu_addr = (long) (ptr);					\
-	__pu_err = verify_area(VERIFY_WRITE, (void *) __pu_addr, size);	\
-									\
-	if (likely(!__pu_err)) {					\
+	if (access_ok(VERIFY_WRITE, (void *) __pu_addr, size)) {	\
 		switch (size) {						\
 		case 1: __put_user_asm("sb", __pu_val); break;		\
 		case 2: __put_user_asm("sh", __pu_val); break;		\
