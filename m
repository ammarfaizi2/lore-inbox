Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268532AbTANCrd>; Mon, 13 Jan 2003 21:47:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268535AbTANCqj>; Mon, 13 Jan 2003 21:46:39 -0500
Received: from dp.samba.org ([66.70.73.150]:43916 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S268534AbTANCqB>;
	Mon, 13 Jan 2003 21:46:01 -0500
From: Rusty Trivial Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [TRIVIAL] [2.5 patch] MODULE_FORCE_UNLOAD must depend on MODULE_UNLOAD (fwd)
Date: Tue, 14 Jan 2003 13:25:21 +1100
Message-Id: <20030114025453.561EF2C43E@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From:  Adrian Bunk <bunk@fs.tum.de>

  Hi Linus,
  
  the patch in the mail forwarded below is still needed in 2.5.56.
  Rusty already stated that the patch is correct.
  
  Please apply
  Adrian
  
  
  ----- Forwarded message from Adrian Bunk <bunk@fs.tum.de> -----
  
  Date:	Wed, 8 Jan 2003 00:07:42 +0100
  From: Adrian Bunk <bunk@fs.tum.de>
  To: "Robert P. J. Day" <rpjday@mindspring.com>,
      rusty@rustcorp.com.au,
      Linus Torvalds <torvalds@transmeta.com>
  Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
  Subject: [2.5 patch] MODULE_FORCE_UNLOAD must depend on MODULE_UNLOAD
  
  On Wed, Jan 01, 2003 at 02:55:01PM -0500, Robert P. J. Day wrote:
  
  >...
  > Loadable module support
  >     
  >     Does "Module unloading" mean whether or not I can run "rmmod"?
  >   And if I deselect this, why can I still select "Forced module
  >   unloading"?  Either I can unload or I can't, no?
  >...
  
  Thanks for spotting this, after reading kernel/module.c it seems obvious 
  to me that you are right. The following simple patch fixes it:
  

--- trivial-2.5.57/init/Kconfig.orig	2003-01-14 12:11:56.000000000 +1100
+++ trivial-2.5.57/init/Kconfig	2003-01-14 12:11:56.000000000 +1100
@@ -156,7 +156,7 @@
 
 config MODULE_FORCE_UNLOAD
 	bool "Forced module unloading"
-	depends on MODULES && EXPERIMENTAL
+	depends on MODULE_UNLOAD && EXPERIMENTAL
 	help
 	  This option allows you to force a module to unload, even if the
 	  kernel believes it is unsafe: the kernel will remove the module
-- 
  Don't blame me: the Monkey is driving
  File: Adrian Bunk <bunk@fs.tum.de>: [2.5 patch] MODULE_FORCE_UNLOAD must depend on MODULE_UNLOAD (fwd)
