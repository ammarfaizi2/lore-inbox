Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261474AbSKBUp7>; Sat, 2 Nov 2002 15:45:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261476AbSKBUp6>; Sat, 2 Nov 2002 15:45:58 -0500
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:26891 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S261474AbSKBUp5>; Sat, 2 Nov 2002 15:45:57 -0500
Message-Id: <200211022047.gA2KlRp25928@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain;
  charset="us-ascii"
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] De-inline some of arch/i386/kernel/i387.c
Date: Sat, 2 Nov 2002 23:39:27 -0200
X-Mailer: KMail [version 1.3.2]
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Reply-To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

These functions are _way too large_ for inline keyword.
--
vda

diff -urN linux-2.5.45.orig/arch/i386/kernel/i387.c linux-2.5.45/arch/i386/kernel/i387.c
--- linux-2.5.45.orig/arch/i386/kernel/i387.c	Wed Oct 30 22:43:47 2002
+++ linux-2.5.45/arch/i386/kernel/i387.c	Sat Nov  2 22:19:34 2002
@@ -109,7 +109,7 @@
         return tmp;
 }

-static inline unsigned long twd_fxsr_to_i387( struct i387_fxsave_struct *fxsave )
+static unsigned long twd_fxsr_to_i387( struct i387_fxsave_struct *fxsave )
 {
 	struct _fpxreg *st = NULL;
 	unsigned long twd = (unsigned long) fxsave->twd;
@@ -232,7 +232,7 @@
  * FXSR floating point environment conversions.
  */

-static inline int convert_fxsr_to_user( struct _fpstate *buf,
+static int convert_fxsr_to_user( struct _fpstate *buf,
 					struct i387_fxsave_struct *fxsave )
 {
 	unsigned long env[7];
@@ -260,7 +260,7 @@
 	return 0;
 }

-static inline int convert_fxsr_from_user( struct i387_fxsave_struct *fxsave,
+static int convert_fxsr_from_user( struct i387_fxsave_struct *fxsave,
 					  struct _fpstate *buf )
 {
 	unsigned long env[7];

