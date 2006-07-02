Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932122AbWGBRLT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932122AbWGBRLT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jul 2006 13:11:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932126AbWGBRLS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jul 2006 13:11:18 -0400
Received: from ftp.linux-mips.org ([194.74.144.162]:31452 "EHLO
	ftp.linux-mips.org") by vger.kernel.org with ESMTP id S932122AbWGBRLS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jul 2006 13:11:18 -0400
Date: Sun, 2 Jul 2006 17:15:20 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Andrew Morton <akpm@osdl.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>, "Randy.Dunlap" <rdunlap@xenotime.net>,
       erik_frederiksen@pmc-sierra.com, linux-kernel@vger.kernel.org
Subject: Re: IS_ERR Threshold Value
Message-ID: <20060702161520.GA15791@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44A6F5E3.8000300@zytor.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

So MAX_ERRNO of EMAXERRNO which was also being used in assembler code.
Other architectures may have the same issue, so I propose wrapping the
C parts with #ifndef __ASSEMBLY__ to keep as happy.

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

diff --git a/include/linux/err.h b/include/linux/err.h
index cd3b367..1ab1d44 100644
--- a/include/linux/err.h
+++ b/include/linux/err.h
@@ -15,6 +15,8 @@ #include <asm/errno.h>
  */
 #define MAX_ERRNO	4095
 
+#ifndef __ASSEMBLY__
+
 #define IS_ERR_VALUE(x) unlikely((x) >= (unsigned long)-MAX_ERRNO)
 
 static inline void *ERR_PTR(long error)
@@ -32,4 +34,6 @@ static inline long IS_ERR(const void *pt
 	return IS_ERR_VALUE((unsigned long)ptr);
 }
 
+#endif
+
 #endif /* _LINUX_ERR_H */
