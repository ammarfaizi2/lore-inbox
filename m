Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750809AbVJ2FnG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750809AbVJ2FnG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Oct 2005 01:43:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751127AbVJ2FnF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Oct 2005 01:43:05 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:46299 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1750809AbVJ2FnE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Oct 2005 01:43:04 -0400
Date: Sat, 29 Oct 2005 06:43:01 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Russell King <rmk@arm.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: [PATCH] MACHINE_START fix
Message-ID: <20051029054301.GZ7992@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	unreferenced static variables can be killed by cc(1), so when
we want them to survive (we collect these suckers in array in special
section), we'd better not make them static.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
----
diff -urN RC14-base/include/asm-arm/mach/arch.h current/include/asm-arm/mach/arch.h
--- RC14-base/include/asm-arm/mach/arch.h	2005-10-28 18:17:09.000000000 -0400
+++ current/include/asm-arm/mach/arch.h	2005-10-28 20:25:09.000000000 -0400
@@ -49,7 +49,7 @@
  * a table by the linker.
  */
 #define MACHINE_START(_type,_name)			\
-static const struct machine_desc __mach_desc_##_type	\
+const struct machine_desc __mach_desc_##_type	\
  __attribute__((__section__(".arch.info.init"))) = {	\
 	.nr		= MACH_TYPE_##_type,		\
 	.name		= _name,
