Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262883AbVDAUpA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262883AbVDAUpA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 15:45:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262878AbVDAUnS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 15:43:18 -0500
Received: from mail-relay-4.tiscali.it ([213.205.33.44]:41180 "EHLO
	mail-relay-4.tiscali.it") by vger.kernel.org with ESMTP
	id S262884AbVDAUmY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 15:42:24 -0500
Subject: [patch 1/1] uml: va_copy fix
To: linux-kernel@vger.kernel.org
Cc: blaisorblade@yahoo.it, stable@kernel.org
From: blaisorblade@yahoo.it
Date: Fri, 01 Apr 2005 22:40:56 +0200
Message-Id: <20050401204058.EFFC1A8A2@zion>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


CC: <stable@kernel.org>

Uses __va_copy instead of va_copy since some old versions of gcc (2.95.4
for instance) don't accept va_copy.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 clean-linux-2.6.11-paolo/arch/um/kernel/skas/uaccess.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletion(-)

diff -puN arch/um/kernel/skas/uaccess.c~uml-va_copy_fix arch/um/kernel/skas/uaccess.c
--- clean-linux-2.6.11/arch/um/kernel/skas/uaccess.c~uml-va_copy_fix	2005-04-01 22:37:11.000000000 +0200
+++ clean-linux-2.6.11-paolo/arch/um/kernel/skas/uaccess.c	2005-04-01 22:37:11.000000000 +0200
@@ -61,7 +61,8 @@ static void do_buffer_op(void *jmpbuf, v
 	void *arg;
 	int *res;
 
-	va_copy(args, *(va_list *)arg_ptr);
+	/* Some old gccs recognize __va_copy, but not va_copy */
+	__va_copy(args, *(va_list *)arg_ptr);
 	addr = va_arg(args, unsigned long);
 	len = va_arg(args, int);
 	is_write = va_arg(args, int);
_
