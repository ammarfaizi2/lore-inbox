Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262257AbUCAG12 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Mar 2004 01:27:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262255AbUCAG12
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Mar 2004 01:27:28 -0500
Received: from dp.samba.org ([66.70.73.150]:33213 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S262258AbUCAG1P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Mar 2004 01:27:15 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>, torvalds@osdl.org
Subject: Re: [PATCH] scripts/modpost warning 
In-reply-to: Your message of "Sun, 29 Feb 2004 17:15:35 BST."
             <Pine.GSO.4.58.0402291713230.7483@waterleaf.sonytel.be> 
Date: Mon, 01 Mar 2004 17:00:51 +1100
Message-Id: <20040301062725.6AF702C2FB@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.GSO.4.58.0402291713230.7483@waterleaf.sonytel.be> you write:
> 
> I need the following patch to kill a warning (__endian() may be unused) when
> cross-compiling m68k kernels on an ia32 box.

Yep.  sumversion.c doesn't actually use this routine.

Please apply.
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.


From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>

I need the following patch to kill a warning (__endian() may be unused) when
cross-compiling m68k kernels on an ia32 box.

sumversion.c include modpost.h for grab_file and release_file, and
doesn't use __endian.

--- linux-2.6.4-rc1/scripts/modpost.h	2004-02-29 09:33:41.000000000 +0100
+++ linux-m68k-2.6.4-rc1/scripts/modpost.h	2004-02-29 10:39:56.000000000 +0100
@@ -31,7 +31,7 @@

 #if KERNEL_ELFDATA != HOST_ELFDATA

-static void __endian(const void *src, void *dest, unsigned int size)
+static inline void __endian(const void *src, void *dest, unsigned int size)
 {
 	unsigned int i;
 	for (i = 0; i < size; i++)



