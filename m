Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262437AbTEVBLn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 May 2003 21:11:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262438AbTEVBLn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 May 2003 21:11:43 -0400
Received: from dp.samba.org ([66.70.73.150]:25746 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S262437AbTEVBLm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 May 2003 21:11:42 -0400
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16076.9908.786052.20735@argo.ozlabs.ibm.com>
Date: Thu, 22 May 2003 11:24:04 +1000
To: torvalds@transmeta.com
Cc: benh@kernel.crashing.org, linux-kernel@vger.kernel.org
Subject: [PATCH] SET_MODULE_OWNER change in apm_emu.c
X-Mailer: VM 7.15 under Emacs 21.3.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

The patch below fixes drivers/macintosh/apm_emu.c by replacing the
SET_MODULE_OWNER with a statement that explicitly sets the owner field
of the proc_dir_entry that it creates.

Please apply.

Thanks,
Paul.

diff -urN linux-2.5/drivers/macintosh/apm_emu.c pmac-2.5/drivers/macintosh/apm_emu.c
--- linux-2.5/drivers/macintosh/apm_emu.c	2003-04-03 08:55:29.000000000 +1000
+++ pmac-2.5/drivers/macintosh/apm_emu.c	2003-05-21 13:40:54.000000000 +1000
@@ -524,7 +524,7 @@
 		
 	apm_proc = create_proc_info_entry("apm", 0, NULL, apm_emu_get_info);
 	if (apm_proc)
-		SET_MODULE_OWNER(apm_proc);
+		apm_proc->owner = THIS_MODULE;
 
 	misc_register(&apm_device);
 
