Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262472AbTAIJll>; Thu, 9 Jan 2003 04:41:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262620AbTAIJlk>; Thu, 9 Jan 2003 04:41:40 -0500
Received: from TYO201.gate.nec.co.jp ([210.143.35.51]:24966 "EHLO
	TYO201.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id <S262506AbTAIJko>; Thu, 9 Jan 2003 04:40:44 -0500
To: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH]  Prevent .gnu.linkonce.this_module section from being merged with other sections
Cc: linux-kernel@vger.kernel.org
Reply-To: Miles Bader <miles@gnu.org>
Message-Id: <20030109094923.63723374A@mcspd15.ucom.lsi.nec.co.jp>
Date: Thu,  9 Jan 2003 18:49:23 +0900 (JST)
From: miles@lsi.nec.co.jp (Miles Bader)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As I mentioned in an earlier email, this is necessary on the v850
because the default -r linker-script merges .gnu.linkonce.t* into the
.text output section.  I don't think it will hurt any other platforms.

diff -ruN -X../cludes linux-2.5.55-moo.orig/Makefile linux-2.5.55-moo/Makefile
--- linux-2.5.55-moo.orig/Makefile	2003-01-09 14:03:45.000000000 +0900
+++ linux-2.5.55-moo/Makefile	2003-01-09 14:07:36.000000000 +0900
@@ -163,7 +164,7 @@
 MODFLAGS	= -DMODULE
 CFLAGS_MODULE   = $(MODFLAGS)
 AFLAGS_MODULE   = $(MODFLAGS)
-LDFLAGS_MODULE  = -r
+LDFLAGS_MODULE  = -r --unique=.gnu.linkonce.this_module
 CFLAGS_KERNEL	=
 AFLAGS_KERNEL	=
 
