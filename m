Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262887AbUKXWrT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262887AbUKXWrT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 17:47:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262888AbUKXWqY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 17:46:24 -0500
Received: from zeus.kernel.org ([204.152.189.113]:10937 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S262873AbUKXWqP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 17:46:15 -0500
Message-ID: <41A4B52D.2030402@zytor.com>
Date: Wed, 24 Nov 2004 08:22:05 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en, sv, es, fr
MIME-Version: 1.0
To: Linus Torvalds <torvalds@Osdl.ORG>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] Allow compiling i386 with an x86-64 compiler
Content-Type: multipart/mixed;
 boundary="------------040501090706070803050701"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040501090706070803050701
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

This patch adds -m32 if gcc supports it, thus making it easier to 
compile the i386 architecture with an x86-64 compiler.

Note that it adds the option to CC, since it also affects assembly code 
and linking.  The extra level of indirection is because $(call 
cc-option) itself uses $(CC), so just doing CC += ... would cause $(CC) 
to be recursively defined.

	-hpa


Signed-Off-By: H. Peter Anvin <hpa@zytor.com>

--------------040501090706070803050701
Content-Type: text/x-patch;
 name="build_on_x86_64.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="build_on_x86_64.diff"

Index: linux-2.5/arch/i386/Makefile
===================================================================
RCS file: /home/hpa/kernel/bkcvs/linux-2.5/arch/i386/Makefile,v
retrieving revision 1.72
diff -u -r1.72 Makefile
--- linux-2.5/arch/i386/Makefile	27 Oct 2004 17:27:13 -0000	1.72
+++ linux-2.5/arch/i386/Makefile	23 Nov 2004 02:04:09 -0000
@@ -20,6 +20,10 @@
 LDFLAGS_vmlinux :=
 CHECKFLAGS	+= -D__i386__
 
+# This allows compilation with an x86-64 compiler
+CC_M32		:= $(call cc-option,-m32)
+CC 		+= $(CC_M32)
+
 CFLAGS += -pipe -msoft-float
 
 # prevent gcc from keeping the stack 16 byte aligned

--------------040501090706070803050701--
