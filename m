Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754347AbWKZXNc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754347AbWKZXNc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Nov 2006 18:13:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754411AbWKZXNc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Nov 2006 18:13:32 -0500
Received: from smtp.osdl.org ([65.172.181.25]:50105 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1754347AbWKZXNc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Nov 2006 18:13:32 -0500
Date: Sun, 26 Nov 2006 15:12:54 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Ralf Baechle <ralf@linux-mips.org>,
       Russell King <rmk+lkml@arm.linux.org.uk>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alexey Dobriyan <adobriyan@gmail.com>
Subject: Re: Build breakage ...
In-Reply-To: <Pine.LNX.4.64.0611261459010.3483@woody.osdl.org>
Message-ID: <Pine.LNX.4.64.0611261509330.3483@woody.osdl.org>
References: <20061126224928.GA22285@linux-mips.org>
 <Pine.LNX.4.64.0611261459010.3483@woody.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 26 Nov 2006, Linus Torvalds wrote:
> 
> Does the obvious fix (to include <linux/kernel.h> in irqflags.h) fix it 
> for you?

Btw, Alexey, why did you do _both a BUILD_BUG_ON and a "typecheck()"?

If there are any broken users, we shouldn't break the build, but a 
_warning_ is certainly appropriate.

I think I'll just commit this..

Ralf, Russell, does this work for you guys?

		Linus
---
diff --git a/include/linux/irqflags.h b/include/linux/irqflags.h
index 4fe740b..8c5d9d1 100644
--- a/include/linux/irqflags.h
+++ b/include/linux/irqflags.h
@@ -11,11 +11,10 @@
 #ifndef _LINUX_TRACE_IRQFLAGS_H
 #define _LINUX_TRACE_IRQFLAGS_H
 
-#define BUILD_CHECK_IRQ_FLAGS(flags)					\
-	do {								\
-		BUILD_BUG_ON(sizeof(flags) != sizeof(unsigned long));	\
-		typecheck(unsigned long, flags);			\
-	} while (0)
+#include <linux/kernel.h>
+
+#define BUILD_CHECK_IRQ_FLAGS(flags) \
+	typecheck(unsigned long, flags)
 
 #ifdef CONFIG_TRACE_IRQFLAGS
   extern void trace_hardirqs_on(void);
