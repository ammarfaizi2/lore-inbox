Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964824AbVI0GX1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964824AbVI0GX1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 02:23:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964826AbVI0GX1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 02:23:27 -0400
Received: from mail.renesas.com ([202.234.163.13]:24314 "EHLO
	mail01.idc.renesas.com") by vger.kernel.org with ESMTP
	id S964824AbVI0GX0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 02:23:26 -0400
Date: Tue, 27 Sep 2005 15:23:25 +0900 (JST)
Message-Id: <20050927.152325.424252181.takata.hirokazu@renesas.com>
To: viro@ftp.linux.org.uk
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org, takata@linux-m32r.org
Subject: Re: [PATCH] m32r: set CHECKFLAGS properly
From: Hirokazu Takata <takata@linux-m32r.org>
In-Reply-To: <E1EJlNM-00059K-R8@ZenIV.linux.org.uk>
References: <E1EJlNM-00059K-R8@ZenIV.linux.org.uk>
X-Mailer: Mew version 3.3 on XEmacs 21.4.17 (Jumbo Shrimp)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please don't specify __BIG_ENDIAN__.  ;-)
We have supported both big- and little-endian for the m32r kernel.
I hope it will be kept unconditional.

Now, the endianness is to be determined by a (cross)compiler:
- For the big-endian, a compiler (m32r-linux-gcc or m32r-linux-gnu-gcc)
  provides a predefined macro __BIG_ENDIAN__.
- For little-endian, a compiler (m32rle-linux-gcc or m32rle-linux-gnu-gcc)
  provides a predefined macro __LITTLE_ENDIAN__.

Here is a modified patch.

Thank you.

From: Al Viro <viro@ftp.linux.org.uk>
Date: Mon, 26 Sep 2005 06:18:04 +0100
> What we do need is __BIG_ENDIAN__; right now unconditional, when m32r starts
> using CPU_LITTLE_ENDIAN, we'll need to adjust.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Hirokazu Takata <takata@linux-m32r.org>
----
 arch/m32r/Makefile |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6.14-rc2/arch/m32r/Makefile
===================================================================
--- linux-2.6.14-rc2.orig/arch/m32r/Makefile	2005-08-29 08:41:01.000000000 +0900
+++ linux-2.6.14-rc2/arch/m32r/Makefile	2005-09-27 13:15:19.000000000 +0900
@@ -24,7 +24,7 @@ aflags-$(CONFIG_ISA_M32R)	+= -DNO_FPU -W
 CFLAGS += $(cflags-y)
 AFLAGS += $(aflags-y)
 
-CHECKFLAGS	:= $(CHECK) -D__m32r__
+CHECKFLAGS	+= -D__m32r__
 
 head-y	:= arch/m32r/kernel/head.o arch/m32r/kernel/init_task.o
 
--
Hirokazu Takata <takata@linux-m32r.org>
Linux/M32R Project:  http://www.linux-m32r.org/
