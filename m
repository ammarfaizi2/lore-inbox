Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262131AbTJIMlX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Oct 2003 08:41:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262133AbTJIMlX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Oct 2003 08:41:23 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:43511 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S262131AbTJIMlW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Oct 2003 08:41:22 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16261.22374.861491.176410@gargle.gargle.HOWL>
Date: Thu, 9 Oct 2003 14:41:10 +0200
From: Mikael Pettersson <mikpe@csd.uu.se>
To: linux-kernel@vger.kernel.org
Subject: [PATCH][2.6.0-test7] ftape linkage error
Cc: torvalds@osdl.org
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Since 2.6.0-test6, ftape can't be configured as a built-in driver.
test6 changed ftape-init.c to call ftape_proc_destroy() also in
the non-MODULE case; however, ftape_proc_destroy() is only defined
when the driver is built as a module. The result is a linkage error.

This patch fixes this by deleting the #if MODULE around
ftape_proc_destroy()'s definition.

/Mikael

--- linux-2.6.0-test7/drivers/char/ftape/lowlevel/ftape-proc.c.~1~	2002-02-20 03:11:01.000000000 +0100
+++ linux-2.6.0-test7/drivers/char/ftape/lowlevel/ftape-proc.c	2003-10-09 10:23:08.000000000 +0200
@@ -207,11 +207,9 @@
 		ftape_read_proc, NULL) != NULL;
 }
 
-#ifdef MODULE
 void ftape_proc_destroy(void)
 {
 	remove_proc_entry("ftape", &proc_root);
 }
-#endif
 
 #endif /* defined(CONFIG_PROC_FS) && defined(CONFIG_FT_PROC_FS) */
