Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267984AbUJSFMu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267984AbUJSFMu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 01:12:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267976AbUJSFMs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 01:12:48 -0400
Received: from fw.osdl.org ([65.172.181.6]:44476 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267971AbUJSFMk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 01:12:40 -0400
Date: Mon, 18 Oct 2004 22:10:41 -0700
From: Andrew Morton <akpm@osdl.org>
To: Matthias Andree <matthias.andree@gmx.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9 BK build broken
Message-Id: <20041018221041.184632cb.akpm@osdl.org>
In-Reply-To: <20041019021719.GA22924@merlin.emma.line.org>
References: <20041019021719.GA22924@merlin.emma.line.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthias Andree <matthias.andree@gmx.de> wrote:
>
> include/linux/compiler.h:20: syntax error in macro parameter list

I used this:



include/linux/compiler.h:20: syntax error in macro parameter list

It fails because we use -traditional when compiling .S files.

Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/include/linux/compiler.h |    4 +++-
 1 files changed, 3 insertions(+), 1 deletion(-)

diff -puN include/linux/compiler.h~builtin_warning-is-not-traditional include/linux/compiler.h
--- 25/include/linux/compiler.h~builtin_warning-is-not-traditional	2004-10-18 22:08:25.224796488 -0700
+++ 25-akpm/include/linux/compiler.h	2004-10-18 22:09:05.505672864 -0700
@@ -17,7 +17,9 @@ extern void __chk_io_ptr(void __iomem *)
 # define __iomem
 # define __chk_user_ptr(x) (void)0
 # define __chk_io_ptr(x) (void)0
-#define __builtin_warning(x, ...) (1)
+#ifndef __ASSEMBLY__	/* gcc -traditional fails with varargs-style macros */
+# define __builtin_warning(x, ...) (1)
+#endif
 #endif
 
 #ifdef __KERNEL__
_

