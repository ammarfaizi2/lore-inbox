Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261406AbTKONI0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Nov 2003 08:08:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261509AbTKONI0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Nov 2003 08:08:26 -0500
Received: from wblv-224-88.telkomadsl.co.za ([165.165.224.88]:18304 "EHLO
	nosferatu.lan") by vger.kernel.org with ESMTP id S261406AbTKONIY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Nov 2003 08:08:24 -0500
Subject: [PATCH 2.4] byteorder.h breaks with __STRICT_ANSI__ defined
	(trivial)
From: Martin Schlemmer <azarah@nosferatu.za.org>
Reply-To: azarah@nosferatu.za.org
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>
In-Reply-To: <20031111145805.45206335.davem@redhat.com>
References: <1068140199.12287.246.camel@nosferatu.lan>
	 <20031106093746.5cc8066e.davem@redhat.com>
	 <1068489427.7910.147.camel@nosferatu.lan> <3FAFE1E2.2020000@zytor.com>
	 <1068589739.19849.2.camel@nosferatu.lan>
	 <20031111145805.45206335.davem@redhat.com>
Content-Type: multipart/mixed; boundary="=-t1sDB2mYeUt3UHzUX0j+"
Message-Id: <1068901780.5033.9.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sat, 15 Nov 2003 15:09:40 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-t1sDB2mYeUt3UHzUX0j+
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Marcelo

This patch fixes include/asm-i386/types.h to define __s64 and __u64
even with -ansi passed to gcc, else we get breaks for userland that
may include include/asm-i386/byteorder.h through another header.

It is with help/comments from David S. Miller and H. Peter Anvin.


Thanks,

-- 
Martin Schlemmer

--=-t1sDB2mYeUt3UHzUX0j+
Content-Disposition: attachment; filename=asm-types_h-extension.patch
Content-Type: text/x-patch; name=asm-types_h-extension.patch; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

--- linux-2.4.22/include/asm-i386/types.h	2003-11-10 07:38:32.000000000 +0200
+++ linux-2.4.22.ext/include/asm-i386/types.h	2003-11-10 07:48:42.000000000 +0200
@@ -17,11 +17,15 @@
 typedef __signed__ int __s32;
 typedef unsigned int __u32;
 
-#if defined(__GNUC__) && !defined(__STRICT_ANSI__)
-typedef __signed__ long long __s64;
-typedef unsigned long long __u64;
+#ifndef __GNUC__
+# ifndef __extension__
+#  define __extension__
+# endif
 #endif
 
+__extension__ typedef __signed__ long long __s64;
+__extension__ typedef unsigned long long __u64;
+
 /*
  * These aren't exported outside the kernel to avoid name space clashes
  */

--=-t1sDB2mYeUt3UHzUX0j+--

