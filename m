Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031329AbWKUTZN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031329AbWKUTZN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 14:25:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031331AbWKUTZN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 14:25:13 -0500
Received: from agminet01.oracle.com ([141.146.126.228]:31429 "EHLO
	agminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1031329AbWKUTZM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 14:25:12 -0500
Date: Tue, 21 Nov 2006 11:25:04 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: jonathan@buzzard.org.uk, akpm <akpm@osdl.org>
Subject: [PATCH] export toshiba SMM support for neofb module
Message-Id: <20061121112504.187a2d00.randy.dunlap@oracle.com>
Organization: Oracle Linux Eng.
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <randy.dunlap@oracle.com>

When CONFIG_TOSHIBA=y and CONFIG_FB_NEOMAGIC=m, tosh_smm() needs
to be exported for neofb to use it.

WARNING: "tosh_smm" [drivers/video/neofb.ko] undefined!
make[1]: *** [__modpost] Error 1
make: *** [modules] Error 2

Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
---
 drivers/char/toshiba.c |    1 +
 1 file changed, 1 insertion(+)

--- linux-2619-rc6g4.orig/drivers/char/toshiba.c
+++ linux-2619-rc6g4/drivers/char/toshiba.c
@@ -249,6 +249,7 @@ int tosh_smm(SMMRegisters *regs)
 
 	return eax;
 }
+EXPORT_SYMBOL(tosh_smm);
 
 
 static int tosh_ioctl(struct inode *ip, struct file *fp, unsigned int cmd,


---
