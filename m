Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267256AbTBQONK>; Mon, 17 Feb 2003 09:13:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267242AbTBQOM2>; Mon, 17 Feb 2003 09:12:28 -0500
Received: from chii.cinet.co.jp ([61.197.228.217]:31872 "EHLO
	yuzuki.cinet.co.jp") by vger.kernel.org with ESMTP
	id <S267216AbTBQOLB>; Mon, 17 Feb 2003 09:11:01 -0500
Date: Mon, 17 Feb 2003 23:19:38 +0900
From: Osamu Tomita <tomita@cinet.co.jp>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCHSET] PC-9800 subarch. support for 2.5.61 (21/26) PNP
Message-ID: <20030217141938.GU4799@yuzuki.cinet.co.jp>
References: <20030217134333.GA4734@yuzuki.cinet.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030217134333.GA4734@yuzuki.cinet.co.jp>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is patchset to support NEC PC-9800 subarchitecture
against 2.5.61 (21/26).

Small change for Legacy bus PNP support.
For fix IO port address.

diff -Nru linux/drivers/pnp/isapnp/core.c linux98/drivers/pnp/isapnp/core.c
--- linux/drivers/pnp/isapnp/core.c	2003-01-02 12:22:18.000000000 +0900
+++ linux98/drivers/pnp/isapnp/core.c	2003-01-04 16:40:40.000000000 +0900
@@ -72,8 +72,13 @@
 MODULE_PARM_DESC(isapnp_verbose, "ISA Plug & Play verbose mode");
 MODULE_LICENSE("GPL");
 
+#ifndef CONFIG_X86_PC9800
 #define _PIDXR		0x279
 #define _PNPWRP		0xa79
+#else
+#define _PIDXR		0x259
+#define _PNPWRP		0xa59
+#endif
 
 /* short tags */
 #define _STAG_PNPVERNO		0x01
