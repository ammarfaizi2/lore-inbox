Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261738AbULUMiD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261738AbULUMiD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Dec 2004 07:38:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261739AbULUMiD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Dec 2004 07:38:03 -0500
Received: from koto.vergenet.net ([210.128.90.7]:47593 "EHLO koto.vergenet.net")
	by vger.kernel.org with ESMTP id S261738AbULUMiA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Dec 2004 07:38:00 -0500
Date: Tue, 21 Dec 2004 21:37:47 +0900
From: Horms <horms@verge.net.au>
To: lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: solar@openwall.com, Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Subject: [PATCH] binfmt_elf force_sig arguments fix
Message-ID: <20041221123744.GA2294@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Cluestick: seven
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

There appears to be a small error in the change that was recently
applied to fs/binfmt_elf.c to fix error codes and eraly corrupt
binary detection.

The patch includes changing a send_sig() call to a force_sig() call in
load_elf_binary(). However force_sig() only accepts 2 arguments, and
thus the patch causes the build to fail.

I propose the following patch to simply remove the extra argument to
force_sig(), which I beleive will give a sensible result.  That or
change the call back to send_sig(), though I assume it was changed to
force_sig() for a reason.

-- 
Horms

===== fs/binfmt_elf.c 1.36 vs edited =====
--- 1.36/fs/binfmt_elf.c	2004-12-18 03:17:46 +09:00
+++ edited/fs/binfmt_elf.c	2004-12-21 21:21:25 +09:00
@@ -806,7 +806,7 @@
 		if (BAD_ADDR(elf_entry)) {
 			printk(KERN_ERR "Unable to load interpreter %.128s\n",
 				elf_interpreter);
-			force_sig(SIGSEGV, current, 0);
+			force_sig(SIGSEGV, current);
 			retval = -ENOEXEC; /* Nobody gets to see this, but.. */
 			goto out_free_dentry;
 		}
