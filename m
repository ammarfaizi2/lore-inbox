Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261351AbVFDPnc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261351AbVFDPnc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Jun 2005 11:43:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261352AbVFDPnc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Jun 2005 11:43:32 -0400
Received: from wildsau.idv.uni.linz.at ([193.170.194.34]:34432 "EHLO
	wildsau.enemy.org") by vger.kernel.org with ESMTP id S261351AbVFDPn0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Jun 2005 11:43:26 -0400
From: Herbert Rosmanith <kernel@wildsau.enemy.org>
Message-Id: <200506041543.j54Fh7xv018234@wildsau.enemy.org>
Subject: [PATCH] struct thread_struct, asm-i386/processor.h: wrong datatype?
To: linux-kernel@vger.kernel.org
Date: Sat, 4 Jun 2005 17:43:06 +0200 (MET DST)
CC: torvalds@osdl.org, Herbert Rosmanith <kernel@wildsau.enemy.org>
X-Mailer: ELM [version 2.4ME+ PL100 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


good day,

concerning this file:

/usr/src/linux/include/asm-i386/processor.h

we find a "struct thread_struct":

struct thread_struct {
        unsigned long   esp0;
        unsigned long   eip;
        unsigned long   esp;
        unsigned long   fs;
        ^^^^^^^^^^^^^^^^^^^
        unsigned long   gs;
        ^^^^^^^^^^^^^^^^^^^

as segment-registers, aren't fs and gs only 16 bit? why are they not
unsigned short (or possibly u_int16_t)?

kind regards,
herbert rosmanith

# diff -uN processor.h.orig processor.h
--- processor.h.orig    Wed Feb 18 14:36:32 2004
+++ processor.h Sat Jun  4 17:41:58 2005
@@ -2,6 +2,9 @@
  * include/asm-i386/processor.h
  *
  * Copyright (C) 1994 Linus Torvalds
+ *
+ * Sat Jun  4 17:41:23 MET DST 2005 herp - Herbert Rosmanith
+ *  fix wrong datatypes in struct thread_struct
  */

 #ifndef __ASM_I386_PROCESSOR_H
@@ -361,8 +364,8 @@
        unsigned long   esp0;
        unsigned long   eip;
        unsigned long   esp;
-       unsigned long   fs;
-       unsigned long   gs;
+       unsigned short  fs;
+       unsigned short  gs;
 /* Hardware debugging registers */
        unsigned long   debugreg[8];  /* %%db0-7 debug registers */
 /* fault info */

