Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263130AbUJ2H1a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263130AbUJ2H1a (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 03:27:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263129AbUJ2H12
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 03:27:28 -0400
Received: from [192.55.52.67] ([192.55.52.67]:21935 "EHLO
	fmsfmr001.fm.intel.com") by vger.kernel.org with ESMTP
	id S263124AbUJ2HZd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 03:25:33 -0400
Date: Fri, 29 Oct 2004 15:07:51 +0800 (CST)
From: "Zhu, Yi" <yi.zhu@intel.com>
X-X-Sender: chuyee@mazda.sh.intel.com
Reply-To: "Zhu, Yi" <yi.zhu@intel.com>
To: Andrew Morton <akpm@osdl.org>
cc: Pavel Machek <pavel@ucw.cz>, Shaohua Li <shaohua.li@intel.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] [swsusp] print error message when swapping is disabled
In-Reply-To: <16A54BF5D6E14E4D916CE26C9AD3057563D61B@pdsmsx402.ccr.corp.intel.com>
Message-ID: <Pine.LNX.4.44.0410291500250.29394-100000@mazda.sh.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Oct 2004, Li, Shaohua wrote:

> Another case is PSE disabled. Should notify this to user also. 

Here is a patch to address it.

Thanks,
-yi


Signed-off-by: Zhu Yi <yi.zhu@intel.com>

diff -urp linux-2.6.10-rc1-orig/include/asm-i386/suspend.h linux-2.6.10-rc1/include/asm-i386/suspend.h
--- linux-2.6.10-rc1-orig/include/asm-i386/suspend.h	2004-10-29 14:11:44.000000000 +0800
+++ linux-2.6.10-rc1/include/asm-i386/suspend.h	2004-10-29 14:14:41.000000000 +0800
@@ -12,8 +12,11 @@ arch_prepare_suspend(void)
 	/* If you want to make non-PSE machine work, turn off paging
            in do_magic. swsusp_pg_dir should have identity mapping, so
            it could work...  */
-	if (!cpu_has_pse)
+	if (!cpu_has_pse) {
+		printk(KERN_ERR "swsusp: FATAL: PSE is not availiable or "
+				"disabled on your system!\n");
 		return -EPERM;
+	}
 	return 0;
 }
 

