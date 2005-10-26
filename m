Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932152AbVJZKG1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932152AbVJZKG1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Oct 2005 06:06:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751482AbVJZKG1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Oct 2005 06:06:27 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:25778 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1751339AbVJZKG0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Oct 2005 06:06:26 -0400
Date: Wed, 26 Oct 2005 11:06:23 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] fix alpha breakage
Message-ID: <20051026100623.GP7992@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	barrier.h uses barrier() in non-SMP case.  And doesn't include
compiler.h.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
----
diff -urN RC14-rc5-git5-base/include/asm-alpha/barrier.h current/include/asm-alpha/barrier.h
--- RC14-rc5-git5-base/include/asm-alpha/barrier.h	2005-10-26 01:00:39.000000000 -0400
+++ current/include/asm-alpha/barrier.h	2005-10-26 03:38:24.000000000 -0400
@@ -1,6 +1,8 @@
 #ifndef __BARRIER_H
 #define __BARRIER_H
 
+#include <linux/compiler.h>
+
 #define mb() \
 __asm__ __volatile__("mb": : :"memory")
 
