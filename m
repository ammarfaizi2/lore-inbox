Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263113AbTCWQuP>; Sun, 23 Mar 2003 11:50:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263115AbTCWQuP>; Sun, 23 Mar 2003 11:50:15 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:24965
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S263113AbTCWQuO>; Sun, 23 Mar 2003 11:50:14 -0500
Date: Sun, 23 Mar 2003 18:06:13 GMT
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200303231806.h2NI6DH6030125@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: DISCUSSION: isapnp change
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


PC9800 uses the ISAPnP protocol but on CBUS not ISA bus. The
current patch is below. I'm wondering if there is a cleaner way we
should do this ?

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65-bk4/drivers/pnp/isapnp/core.c linux-2.5.65-ac4/drivers/pnp/isapnp/core.c
--- linux-2.5.65-bk4/drivers/pnp/isapnp/core.c	2003-03-23 16:46:30.000000000 +0000
+++ linux-2.5.65-ac4/drivers/pnp/isapnp/core.c	2003-03-18 17:02:48.000000000 +0000
@@ -72,8 +72,13 @@
 MODULE_PARM_DESC(isapnp_verbose, "ISA Plug & Play verbose mode");
 MODULE_LICENSE("GPL");
 
+#ifdef CONFIG_X86_PC9800
+#define _PIDXR		0x259
+#define _PNPWRP		0xa59
+#else
 #define _PIDXR		0x279
 #define _PNPWRP		0xa79
+#endif
 
 /* short tags */
 #define _STAG_PNPVERNO		0x01
