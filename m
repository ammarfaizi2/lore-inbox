Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262705AbVAQGJh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262705AbVAQGJh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 01:09:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262708AbVAQGJh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 01:09:37 -0500
Received: from ozlabs.org ([203.10.76.45]:13214 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S262705AbVAQGJZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 01:09:25 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16875.22379.65938.260915@cargo.ozlabs.ibm.com>
Date: Mon, 17 Jan 2005 17:12:59 +1100
From: Paul Mackerras <paulus@samba.org>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, mjwolf@us.ibm.com
Subject: [PATCH] Ioctl compatibility for TIOCMIWAIT and TIOCGICOUNT
X-Mailer: VM 7.19 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch lets us use TIOCMIWAIT and TIOCGICOUNT from a 32-bit
process on a 64-bit processor.  TIOCMIWAIT uses the argument as a
bitmap of things to wait for.  The argument for TIOCGICOUNT points to
a struct serial_icounter_struct, which only contains ints and arrays
of int.

Signed-off-by: Paul Mackerras <paulus@samba.org>

diff -urN linux-2.5/include/linux/compat_ioctl.h test/include/linux/compat_ioctl.h
--- linux-2.5/include/linux/compat_ioctl.h	2004-11-17 09:38:21.000000000 +1100
+++ test/include/linux/compat_ioctl.h	2005-01-17 14:25:41.000000000 +1100
@@ -25,6 +25,8 @@
 COMPATIBLE_IOCTL(TIOCLINUX)
 COMPATIBLE_IOCTL(TIOCSBRK)
 COMPATIBLE_IOCTL(TIOCCBRK)
+ULONG_IOCTL(TIOCMIWAIT)
+COMPATIBLE_IOCTL(TIOCGICOUNT)
 /* Little t */
 COMPATIBLE_IOCTL(TIOCGETD)
 COMPATIBLE_IOCTL(TIOCSETD)
