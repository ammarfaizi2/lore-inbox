Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268273AbUHFU3I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268273AbUHFU3I (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 16:29:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268281AbUHFU23
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 16:28:29 -0400
Received: from umhlanga.stratnet.net ([12.162.17.40]:39942 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S268282AbUHFU0H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 16:26:07 -0400
To: Andrew Morton <akpm@osdl.org>
Cc: linux@horizon.com, mbligh@aracnet.com, linux-kernel@vger.kernel.org
Subject: [PATCH] (was Re: HIGHMEM4G config for 1GB RAM on desktop?)
X-Message-Flag: Warning: May contain useful information
References: <20040806125236.24348.qmail@science.horizon.com>
From: Roland Dreier <roland@topspin.com>
Date: Fri, 06 Aug 2004 12:11:18 -0700
In-Reply-To: <20040806125236.24348.qmail@science.horizon.com> (linux@horizon.com's
 message of "6 Aug 2004 12:52:36 -0000")
Message-ID: <524qngdquh.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 06 Aug 2004 19:11:18.0918 (UTC) FILETIME=[273DE260:01C47BE9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    > wli tells me that there are additional places in the code that
    > need fixing.

Looks like arch/i386/kernel/doublefault.c is one place in the code
that hardcodes the assumption that PAGE_OFFSET == 0xC0000000.  Here's
a patch that fixes that.

(Of course this doesn't really fix anything except debugging output)

 - Roland

Signed-off-by: Roland Dreier <roland@topspin.com>

Index: linux-2.6.8-rc1/arch/i386/kernel/doublefault.c
===================================================================
--- linux-2.6.8-rc1.orig/arch/i386/kernel/doublefault.c
+++ linux-2.6.8-rc1/arch/i386/kernel/doublefault.c
@@ -13,7 +13,7 @@
 static unsigned long doublefault_stack[DOUBLEFAULT_STACKSIZE];
 #define STACK_START (unsigned long)(doublefault_stack+DOUBLEFAULT_STACKSIZE)
 
-#define ptr_ok(x) ((x) > 0xc0000000 && (x) < 0xc1000000)
+#define ptr_ok(x) ((x) > PAGE_OFFSET && (x) < PAGE_OFFSET + 0x1000000)
 
 static void doublefault_fn(void)
 {
