Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262593AbTIUWga (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Sep 2003 18:36:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262594AbTIUWga
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Sep 2003 18:36:30 -0400
Received: from [203.51.31.218] ([203.51.31.218]:48116 "EHLO e4.eyal.emu.id.au")
	by vger.kernel.org with ESMTP id S262593AbTIUWg2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Sep 2003 18:36:28 -0400
Message-ID: <3F6E27D8.28FC0293@eyal.emu.id.au>
Date: Mon, 22 Sep 2003 08:36:08 +1000
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
X-Mailer: Mozilla 4.8 [en] (X11; U; Linux 2.4.23-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>
CC: list linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.23-pre5: airo.c does not build
References: <Pine.LNX.4.44.0309211438440.17528-100000@logos.cnet>
Content-Type: multipart/mixed;
 boundary="------------097D58853612FACA649360C3"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------097D58853612FACA649360C3
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

gcc -D__KERNEL__ -I/data2/usr/local/src/linux-2.4-pre/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common
-fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i686
-malign-functions=4 -DMODULE -DMODVERSIONS -include
/data2/usr/local/src/linux-2.4-pre/include/linux/modversions.h 
-nostdinc -iwithprefix include -DKBUILD_BASENAME=airo  -DEXPORT_SYMTAB
-c airo.c
airo.c:207: redefinition of `PDE'
/data2/usr/local/src/linux-2.4-pre/include/linux/proc_fs.h:213: `PDE'
previously defined here
make[3]: *** [airo.o] Error 1
make[3]: Leaving directory
`/data2/usr/local/src/linux-2.4-pre/drivers/net/wireless'

--
Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.org/eyal/>
--------------097D58853612FACA649360C3
Content-Type: text/plain; charset=us-ascii;
 name="2.4.23-pre5-airo.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="2.4.23-pre5-airo.patch"

--- linux/drivers/net/wireless/airo.c.orig	Mon Sep 22 08:27:31 2003
+++ linux/drivers/net/wireless/airo.c	Mon Sep 22 08:32:18 2003
@@ -202,7 +202,7 @@
 #ifndef RUN_AT
 #define RUN_AT(x) (jiffies+(x))
 #endif
-#if LINUX_VERSION_CODE < 0x020500
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,4,23)
 static inline struct proc_dir_entry *PDE(const struct inode *inode)
 {
 	return inode->u.generic_ip;

--------------097D58853612FACA649360C3--

