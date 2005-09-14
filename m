Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965064AbVINW1h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965064AbVINW1h (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 18:27:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030246AbVINW1M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 18:27:12 -0400
Received: from lakshmi.addtoit.com ([198.99.130.6]:60421 "EHLO
	lakshmi.solana.com") by vger.kernel.org with ESMTP id S965064AbVINW1I
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 18:27:08 -0400
Message-Id: <200509142156.j8ELu16t012147@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: [PATCH 5/10] UML - Remove some build warnings
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 14 Sep 2005 17:56:01 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

These ugly double-casts are the result of gdb complaining about size 
differences when casting between ints and pointers.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.13-mm2/arch/um/os-Linux/aio.c
===================================================================
--- linux-2.6.13-mm2.orig/arch/um/os-Linux/aio.c	2005-09-08 11:18:05.000000000 -0400
+++ linux-2.6.13-mm2/arch/um/os-Linux/aio.c	2005-09-08 11:29:22.000000000 -0400
@@ -142,7 +142,7 @@
                                "errno = %d\n", errno);
                 }
                 else {
-			aio = (struct aio_context *) event.data;
+			aio = (struct aio_context *) (long) event.data;
 			if(update_aio(aio, event.res)){
 				do_aio(ctx, aio);
 				continue;
Index: linux-2.6.13-mm2/arch/um/os-Linux/elf_aux.c
===================================================================
--- linux-2.6.13-mm2.orig/arch/um/os-Linux/elf_aux.c	2005-09-08 11:18:05.000000000 -0400
+++ linux-2.6.13-mm2/arch/um/os-Linux/elf_aux.c	2005-09-08 11:29:22.000000000 -0400
@@ -9,6 +9,7 @@
  */
 #include <elf.h>
 #include <stddef.h>
+#include <asm/elf.h>
 #include "init.h"
 #include "elf_user.h"
 #include "mem_user.h"
@@ -54,7 +55,8 @@
                                  * a_un, so we have to use a_val, which is
                                  * all that's left.
                                  */
-				elf_aux_platform = (char *) auxv->a_un.a_val;
+				elf_aux_platform = 
+					(char *) (long) auxv->a_un.a_val;
 				break;
 			case AT_PAGESZ:
 				page_size = auxv->a_un.a_val;

