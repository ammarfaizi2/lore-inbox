Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261622AbVCGFMy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261622AbVCGFMy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 00:12:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261624AbVCGFMy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 00:12:54 -0500
Received: from orb.pobox.com ([207.8.226.5]:61060 "EHLO orb.pobox.com")
	by vger.kernel.org with ESMTP id S261622AbVCGFMr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 00:12:47 -0500
Date: Sun, 6 Mar 2005 21:12:41 -0800
From: "Barry K. Nathan" <barryn@pobox.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org,
       barryn@pobox.com
Subject: [PATCH] kconfig: DEBUG_PAGEALLOC and SOFTWARE_SUSPEND are incompatible on i386
Message-ID: <20050307051241.GA5083@ip68-4-98-123.oc.oc.cox.net>
References: <20050306030852.23eb59db.akpm@osdl.org> <20050306225730.GA1414@elf.ucw.cz> <20050306195954.6d13cff9.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050306195954.6d13cff9.akpm@osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On i386, SOFTWARE_SUSPEND requires the CPU to have PSE support, but
DEBUG_PAGEALLOC disables PSE. Thus, allowing both options to be enabled
simultaneously makes no sense. This patch disables DEBUG_PAGEALLOC if
SOFTWARE_SUSPEND is enabled; it also displays a comment to briefly
explain why DEBUG_PAGEALLOC is missing in that case.

I have tested this patch against oldconfig and menuconfig on 2.6.11-bk2.

Signed-off-by: Barry K. Nathan <barryn@pobox.com>

--- linux-2.6.11-bk2/arch/i386/Kconfig.debug	2004-12-24 13:34:45.000000000 -0800
+++ linux-2.6.11-bk2-bkn2/arch/i386/Kconfig.debug	2005-03-06 20:59:07.000000000 -0800
@@ -38,9 +38,12 @@
 
 	  This option will slow down process creation somewhat.
 
+comment "Page alloc debug is incompatible with Software Suspend on i386"
+	depends on DEBUG_KERNEL && SOFTWARE_SUSPEND
+
 config DEBUG_PAGEALLOC
 	bool "Page alloc debugging"
-	depends on DEBUG_KERNEL
+	depends on DEBUG_KERNEL && !SOFTWARE_SUSPEND
 	help
 	  Unmap pages from the kernel linear mapping after free_pages().
 	  This results in a large slowdown, but helps to find certain types
